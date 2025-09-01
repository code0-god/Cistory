#!/usr/bin/env bash
# Cistory unified test runner (split-file format)
# - 기본: CASE 단위 PASS/FAIL + 요약만 출력
# - VERBOSE=1: 상세 사유 출력(diff/룰 실패 등)
# - STRICT=1: 하나라도 실패하면 종료코드 1 (기본은 0 = 학생 로컬에서 make 에러 안 뜨게 함)
set -uo pipefail

CONF="tests_public/test.conf"
if [[ ! -f "$CONF" ]]; then
  echo "[ERROR] $CONF 파일을 찾을 수 없습니다."
  exit 2
fi

# shellcheck disable=SC1090
source "$CONF"

: "${TARGET:=./prog}"
: "${MODE:?패턴 or 골든 모드를 설정하세요 (pattern | golden)}"
: "${VERBOSE:=0}"
: "${DEBUG:=0}"
: "${STRICT:=0}"   # 0: 항상 exit 0, 1: 실패시 exit 1

normalize_lines() { sed 's/\r$//' | sed 's/[ \t]\+$//'; }
dbg() { [[ "${DEBUG}" = "1" ]] && echo "[DBG]" "$@"; }
vout() { [[ "${VERBOSE}" = "1" ]] && printf "%s\n" "$*"; }
case_name_of() { printf "%s" "$1" | sed -e 's/^[[:space:]]*##CASE:[[:space:]]*//'; }

# inputs.txt에서 특정 케이스 블록 추출
extract_block() { # $1=file $2=case_name
  local file="$1" name="$2"
  [[ -f "$file" ]] || return 1
  awk -v name="$name" '
    BEGIN{inblk=0}
    /^##CASE:[[:space:]]*/{
      if(inblk) exit;
      cur=$0; sub(/^##CASE:[[:space:]]*/,"",cur);
      inblk = (cur==name); next
    }
    { if(inblk) print }
  ' "$file"
}

# ----------------------------------------
# Golden mode (expected.txt + inputs.txt)
# - EXPECTED_FILE: 필수, ##CASE 블록들 포함
# - INPUTS_FILE:  옵션, 동일 케이스명의 ##CASE 블록이 있으면 표준입력으로 사용
# ----------------------------------------
run_golden() {
  : "${EXPECTED_FILE:?골든 모드에는 EXPECTED_FILE 경로가 필요합니다.}"
  [[ -f "$EXPECTED_FILE" ]] || { echo "[ERROR] $EXPECTED_FILE 없음"; return 2; }

  # 입력 파일은 선택
  : "${INPUTS_FILE:=}"

  echo "===== Golden Tests ($(basename "$(pwd)")) ====="

  local current_case="" buf_expect=""
  local total=0 pass=0 fail=0

  emit_case() {
    [[ -z "$current_case" ]] && return
    ((total++))

    local in_text="" output="" expn=""
    if [[ -n "$INPUTS_FILE" && -f "$INPUTS_FILE" ]]; then
      in_text="$(extract_block "$INPUTS_FILE" "$current_case" || true)"
    fi

    if [[ -n "$in_text" ]]; then
      output="$(printf "%s" "$in_text" | "$TARGET" 2>&1 || true)"
    else
      output="$("$TARGET" 2>&1 || true)"
    fi

    if diff -u \
      <(printf "%s" "$output"     | normalize_lines) \
      <(printf "%s" "$buf_expect" | normalize_lines) > /tmp/cistory_diff.$$ 2>&1
    then
      echo "CASE ${current_case}: PASS"
      ((pass++))
    else
      echo "CASE ${current_case}: FAIL"
      ((fail++))
      if [[ "${VERBOSE}" = "1" ]]; then
        echo "---- diff (expected vs output) ----"
        cat /tmp/cistory_diff.$$
      fi
    fi
    rm -f /tmp/cistory_diff.$$ || true
  }

  while IFS='' read -r line || [[ -n "$line" ]]; do
    if [[ "$line" == "##CASE:"* ]]; then
      # 이전 케이스 마감
      emit_case
      current_case="$(case_name_of "$line")"
      buf_expect=""
      continue
    fi
    # 기대 출력 누적
    buf_expect="${buf_expect:+$buf_expect$'\n'}$line"
  done < <(normalize_lines < "$EXPECTED_FILE")

  # 마지막 케이스 마감
  emit_case

  if [[ $fail -eq 0 ]]; then
    echo "RESULT: PASS (${pass}/${total})"
    return 0
  else
    echo "RESULT: FAIL (${pass}/${total}, failed=${fail})"
    return 1
  fi
}

# ----------------------------------------
# Pattern mode
# - 케이스 블록(옵션): ##CASE: name ... ##END
# - 블록이 없으면 파일 전체를 단일 CASE("format")로 평가
# ----------------------------------------
eval_rule() {
  # $1=key $2=val $3=output
  case "$1" in
    CONTAINS)  printf "%s" "$3" | grep -Fq -- "$2" ;;
    REGEX)     printf "%s" "$3" | grep -Eq -- "$2" ;;
    NOT_REGEX) if printf "%s" "$3" | grep -Eq -- "$2"; then return 1; else return 0; fi ;;
    *) echo "[ERROR] 지원하지 않는 규칙: $1"; return 2 ;;
  esac
}

run_pattern_cases() {
  local output="$1"
  local total=0 pass=0 fail=0
  local in_case=0 case_name="" case_fail=0 line key val

  while IFS='' read -r raw || [[ -n "$raw" ]]; do
    line="$(printf "%s" "$raw" | normalize_lines)"
    if [[ "$line" =~ ^##CASE: ]]; then
      in_case=1; case_name="$(case_name_of "$line")"; case_fail=0; continue
    fi
    if [[ "$line" == "##END" ]]; then
      ((total++))
      if [[ $case_fail -eq 0 ]]; then
        echo "CASE ${case_name}: PASS"; ((pass++))
      else
        echo "CASE ${case_name}: FAIL"; ((fail++))
      fi
      in_case=0; case_name=""; continue
    fi
    [[ $in_case -eq 1 ]] || continue
    [[ -z "$line" || "$line" =~ ^[[:space:]]*$ || "$line" =~ ^# ]] && continue

    key="${line%%:*}"
    val="${line#*:}"; val="${val#"${val%%[![:space:]]*}"}"
    if ! eval_rule "$key" "$val" "$output"; then
      case_fail=1; vout "  > rule fail: $key $val"
    else
      vout "  > rule pass: $key $val"
    fi
  done

  if [[ $fail -eq 0 ]]; then
    echo "RESULT: PASS (${pass}/${total})"; return 0
  else
    echo "RESULT: FAIL (${pass}/${total}, failed=${fail})"; return 1
  fi
}

run_pattern_single() {
  local output="$1" case_fail=0 line key val

  while IFS='' read -r raw || [[ -n "$raw" ]]; do
    line="$(printf "%s" "$raw" | normalize_lines)"
    [[ -z "$line" || "$line" =~ ^[[:space:]]*$ || "$line" =~ ^# ]] && continue
    key="${line%%:*}"
    val="${line#*:}"; val="${val#"${val%%[![:space:]]*}"}"
    if ! eval_rule "$key" "$val" "$output"; then
      case_fail=1; vout "  > rule fail: $key $val"
    else
      vout "  > rule pass: $key $val"
    fi
  done

  echo "CASE format: $([[ $case_fail -eq 0 ]] && echo PASS || echo FAIL)"
  if [[ $case_fail -eq 0 ]]; then
    echo "RESULT: PASS (1/1)"; return 0
  else
    echo "RESULT: FAIL (0/1, failed=1)"; return 1
  fi
}

run_pattern() {
  : "${PATTERN_FILE:?패턴 모드에는 PATTERN_FILE 경로가 필요합니다.}"
  [[ -f "$PATTERN_FILE" ]] || { echo "[ERROR] $PATTERN_FILE 없음"; return 2; }

  echo "===== Pattern Tests ($(basename "$(pwd)")) ====="

  local raw_out output
  raw_out="$("$TARGET" 2>&1 || true)"
  output="$(printf "%s" "$raw_out" | normalize_lines)"

  if grep -q '^##CASE:' "$PATTERN_FILE"; then
    run_pattern_cases "$output" < "$PATTERN_FILE"
  else
    run_pattern_single "$output" < "$PATTERN_FILE"
  fi
}

# 실행
rc=0
case "$MODE" in
  golden)  run_golden  || rc=$? ;;
  pattern) run_pattern || rc=$? ;;
  *) echo "[ERROR] MODE는 pattern 또는 golden 이어야 합니다."; exit 2 ;;
esac

# STRICT=1 이면 실패시 exit 1, 아니면 항상 0
if [[ "${STRICT}" = "1" && $rc -ne 0 ]]; then
  exit $rc
else
  exit 0
fi
