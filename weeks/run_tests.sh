#!/usr/bin/env bash
set -euo pipefail

# 실행 위치: 각 weekN 디렉터리에서 호출됨 (Makefile에서 bash ../run_tests.sh)
# 필수: tests_public/test.conf 존재

CONF="tests_public/test.conf"
if [[ ! -f "$CONF" ]]; then
  echo "[ERROR] $CONF 파일을 찾을 수 없습니다."
  exit 2
fi

# shellcheck disable=SC1090
source "$CONF"

# 필수 변수 기본값/검증
: "${TARGET:=./prog}"         # 실행 파일 (Makefile에서 빌드되는 바이너리 이름)
: "${MODE:?패턴 or 골든 모드를 설정하세요 (pattern | golden)}"

normalize() {
  sed 's/\r$//' | sed 's/[ \t]\+$//'
}

run_golden() {
  : "${CASES_FILE:?골든 비교 모드에는 CASES_FILE 경로가 필요합니다.}"
  if [[ ! -f "$CASES_FILE" ]]; then
    echo "[ERROR] $CASES_FILE 파일을 찾을 수 없습니다."
    exit 2
  fi

  echo "===== Golden Tests ($(basename "$(pwd)")) ====="

  current_case=""; section=""; buf_input=""; buf_expect=""
  while IFS='' read -r line || [[ -n "$line" ]]; do
    case "$line" in
      "##CASE:"*)
        current_case="${line###CASE: }"
        section=""; buf_input=""; buf_expect=""
        ;;
      "#INPUT")
        section="INPUT"
        ;;
      "#EXPECT")
        section="EXPECT"
        ;;
      "##END")
        # 실행
        if [[ "$buf_input" == "(없음)" || -z "$buf_input" ]]; then
          output=$("$TARGET" 2>&1 || true)
        else
          output=$(printf "%s" "$buf_input" | "$TARGET" 2>&1 || true)
        fi

        if diff -u \
          <(printf "%s" "$output"   | normalize) \
          <(printf "%s" "$buf_expect" | normalize); then
          echo "[PASS] $current_case"
        else
          echo "[FAIL] $current_case"
          echo "---- Your Output ----"
          echo "$output"
          exit 1
        fi
        ;;
      *)
        case "$section" in
          "INPUT")  buf_input="${buf_input:+$buf_input$'\n'}$line" ;;
          "EXPECT") buf_expect="${buf_expect:+$buf_expect$'\n'}$line" ;;
          *) : ;;
        esac
        ;;
    esac
  done < "$CASES_FILE"

  echo "===== All golden tests passed ====="
}

run_pattern() {
  : "${PATTERN_FILE:?패턴 모드에는 PATTERN_FILE 경로가 필요합니다.}"
  if [[ ! -f "$PATTERN_FILE" ]]; then
    echo "[ERROR] $PATTERN_FILE 파일을 찾을 수 없습니다."
    exit 2
  fi

  echo "===== Pattern Tests ($(basename "$(pwd)")) ====="
  output=$("$TARGET" 2>&1 || true)

  # 패턴 파일 포맷:
  #   CONTAINS: 리터럴문자열
  #   REGEX:    정규식
  #   NOT_REGEX: 정규식 (매치되면 실패)
  #   (공백/빈줄/#로 시작하는 주석은 무시)
  i=0
  while IFS='' read -r line || [[ -n "$line" ]]; do
    # 주석/빈줄 무시
    [[ -z "$line" || "$line" =~ ^[[:space:]]*$ || "$line" =~ ^# ]] && continue
    ((i++))
    key="${line%%:*}"
    val="${line#*: }"

    case "$key" in
      CONTAINS)
        if printf "%s" "$output" | grep -Fq "$val"; then
          echo "[PASS] CONTAINS $i: $val"
        else
          echo "[FAIL] CONTAINS $i: '$val' 가 출력에 없습니다."
          exit 1
        fi
        ;;
      REGEX)
        if printf "%s" "$output" | grep -Eq "$val"; then
          echo "[PASS] REGEX $i: /$val/"
        else
          echo "[FAIL] REGEX $i: /$val/ 와 일치하지 않습니다."
          exit 1
        fi
        ;;
      NOT_REGEX)
        if printf "%s" "$output" | grep -Eq "$val"; then
          echo "[FAIL] NOT_REGEX $i: /$val/ 에 매치되었습니다(금지)."
          exit 1
        else
          echo "[PASS] NOT_REGEX $i: /$val/ (매치 없음)"
        fi
        ;;
      *)
        echo "[ERROR] 지원하지 않는 규칙: $line"
        exit 2
        ;;
    esac
  done < "$PATTERN_FILE"

  echo "===== Pattern tests passed ====="
}

case "$MODE" in
  golden)  run_golden  ;;
  pattern) run_pattern ;;
  *) echo "[ERROR] MODE는 pattern 또는 golden 이어야 합니다."; exit 2 ;;
esac
