# Git 명령어 설명서

> 각 명령의 **역할**, **자주 쓰는 옵션**, **간단 예시**를 정리했습니다. 예시는 필요에 따라 값만 바꿔서 사용하세요.

---

## **0. 설정(Config)**

| 명령어 | 기능 | 예시 |
| --- | --- | --- |
| `git config --global user.name "<이름>"` | 커밋 작성자 이름 설정 | `git config --global user.name "Hong Gildong"` |
| `git config --global user.email "<이메일>"` | 커밋 작성자 이메일 설정 | |
| `git config --global core.autocrlf <value>` | 개행 문자 변환 방식 설정 (`input`: 리눅스/macOS, `true`: 윈도우) | `git config --global core.autocrlf input` |
| `git config --global init.defaultBranch <브랜치명>` | `git init` 시 생성될 기본 브랜치명 설정 | `git config --global init.defaultBranch main` |
| `git config --list` | 현재 Git 설정 목록 확인 | |

---

## **1. 저장소 만들기/가져오기**

| 명령어 | 기능 | 예시 |
| :--- | :--- | :--- |
| `git init` | 현재 디렉터리를 Git 저장소로 초기화 | |
| `git clone <URL> [디렉터리]` | 원격 저장소를 로컬에 복제 | `git clone https://github.com/user/repo.git project` |

---

## **2. 원격(Remote)**

| 명령어 | 기능 | 예시 |
| --- | --- | --- |
| `git remote -v` | 등록된 원격 저장소 목록과 URL 확인 | |
| `git remote add <이름> <URL>` | 새 원격 저장소 추가 | `git remote add origin https://github.com/user/repo.git` |
| `git remote set-url <이름> <URL>` | 기존 원격 저장소의 URL 변경 | |
| `git fetch [원격] [브랜치]` | 원격 저장소의 최신 변경사항을 로컬로 가져오기만 함 (병합X) | `git fetch --all --prune` |
| `git pull [원격] [브랜치]` | 원격 변경사항을 가져와 현재 브랜치에 병합(fetch + merge) | `git pull origin main` |
| `git push [원격] [브랜치]` | 로컬 브랜치의 커밋을 원격 저장소로 전송 | `git push -u origin feature/login` |
| `git push <원격> --delete <브랜치>` | 원격 저장소의 브랜치 삭제 | `git push origin --delete old-feature` |

---

## **3. 브랜치/전환(Switch/Checkout)**

| 명령어 | 기능 | 예시 |
| --- | --- | --- |
| `git branch` | 로컬/원격/전체 브랜치 목록 확인 | `-r` (원격), `-a` (전체) |
| `git branch <브랜치명>` | 새 브랜치 생성 | |
| `git branch -d <브랜치명>` | 병합된 브랜치 삭제 | `-D` (강제 삭제) |
| `git switch <브랜치명>` | 지정한 브랜치로 전환 (안전하고 명확) | `git switch main` |
| `git switch -c <브랜치명>` | 새 브랜치를 생성하고 즉시 전환 | `git switch -c new-feature` |

---

## **4. 변경 확인/스테이징/커밋**

| 명령어 | 기능 | 예시 |
| --- | --- | --- |
| `git status` | 파일 변경 상태(Staged, Unstaged, Untracked) 확인 | `-s` 또는 `-sb` (요약) |
| `git diff` | Working Directory와 Staging Area 간의 변경 내용 비교 | |
| `git diff --staged` | Staging Area와 마지막 커밋 간의 변경 내용 비교 | |
| `git add <파일/디렉터리>` | 변경된 파일을 Staging Area로 추가 | `git add .` 또는 `git add -p` |
| `git commit -m "<메시지>"` | Staging Area의 변경 내용을 커밋 | |
| `git commit --amend` | 마지막 커밋을 수정 (메시지 또는 파일 추가) | **(주의: push 전 커밋에만 사용)** |

---

## **5. 머지/리베이스/충돌 해결**

| 명령어 | 기능 | 예시 |
| --- | --- | --- |
| `git merge <브랜치>` | 대상 브랜치의 변경 내용을 현재 브랜치로 병합 | `--abort` (병합 취소) |
| `git rebase <브랜치>` | 현재 브랜치의 커밋들을 대상 브랜치 위로 재배치 | `git rebase origin/main` |
| `git rebase --continue` | 리베이스 중 충돌 해결 후 계속 진행 | `--abort` (리베이스 중단) |

---

## **6. 되돌리기/복구(Reset·Revert·Restore)**

| 명령어 | 기능 | 예시 |
| --- | --- | --- |
| `git revert <커밋>` | 특정 커밋의 변경 내용을 취소하는 새로운 커밋을 생성 (안전) | `git revert HEAD` |
| `git reset <옵션> <커밋>` | 커밋 히스토리를 특정 상태로 되돌림 | `--soft`, `--mixed`, `--hard` |
| `git restore <파일>` | Working Directory의 파일을 마지막 커밋 상태로 되돌림 | `git restore --source=<커밋> <파일>` |
| `git reflog` | HEAD 이동 이력을 조회하여 잃어버린 커밋 복구에 사용 | |

---

## **7. 로그/비교/추적**

| 명령어 | 기능 | 예시 |
| --- | --- | --- |
| `git log` | 커밋 히스토리 조회 | `--oneline --graph --decorate --all` |
| `git show <커밋>` | 특정 커밋의 상세 정보(변경 내용 포함) 확인 | |
| `git blame <파일>` | 파일의 각 라인을 누가, 언제 수정했는지 추적 | |
| `git diff <A>..<B>` | 두 커밋 또는 브랜치 간의 차이 비교 | `git diff main..develop` |

---

## **8. 스태시(Stash)**

| 명령어 | 기능 | 예시 |
| --- | --- | --- |
| `git stash` | 추적 중인 파일의 변경 내용을 임시 저장 | `git stash push -m "메시지"` |
| `git stash list` | 임시 저장된 목록 확인 | |
| `git stash pop` | 가장 최근의 임시 저장 내용을 적용하고 목록에서 삭제 | |
| `git stash apply <스태시>` | 임시 저장 내용을 적용 (목록에 유지) | `git stash apply stash@{1}` |
| `git stash drop <스태시>` | 특정 임시 저장 내용 삭제 | `git stash clear` (전체 삭제) |

---

## **9. 태그(Tag)**

| 명령어 | 기능 | 예시 |
| --- | --- | --- |
| `git tag <태그명>` | 현재 커밋에 가벼운(lightweight) 태그 추가 | `git tag v1.0.0` |
| `git tag -a <태그명> -m "<메시지>"` | 주석(annotated) 태그 추가 | `git tag -a v1.0.0 -m "Release v1.0.0"` |
| `git push <원격> --tags` | 모든 태그를 원격 저장소에 push | |

---

## **10. 정리/청소**

| 명령어 | 기능 | 예시 |
| --- | --- | --- |
| `git clean -fd` | 추적하지 않는 파일(untracked files)과 디렉터리 삭제 | `-n` (dry-run) |
| `git gc` | 불필요한 파일을 삭제하고 저장소를 최적화 | |

---

## **11. 유용한 옵션/팁**

| 명령어 | 기능 | 예시 |
| --- | --- | --- |
| `git fetch --prune` | 원격에서 삭제된 브랜치의 로컬 추적 브랜치 정리 | |
| `git cherry-pick <커밋>` | 특정 커밋 하나를 현재 브랜치에 적용 | |
| `git shortlog -sn` | 작성자별 커밋 요약 | |
| `git archive -o out.zip HEAD` | 현재 트리 압축 내보내기 | |

---

## **12. 별칭(Alias)**

| 명령어 | 기능 |
| --- | --- |
| `git config --global alias.co "checkout"` | `git co`로 `checkout` 실행 |
| `git config --global alias.br "branch"` | `git br`로 `branch` 실행 |
| `git config --global alias.cm "commit -m"` | `git cm`으로 `commit -m` 실행 |
| `git config --global alias.st "status -sb"` | `git st`로 `status -sb` 실행 |
| `git config --global alias.lg "log --oneline --graph --decorate --all"` | `git lg`로 `log ...` 실행 |

---

### **주의 요약**
- **파괴적 명령**: `reset --hard`, `clean -fd`는 되돌리기 어려움. 실행 전 `git status`, `git log`, `git reflog`로 상태 점검.
- **히스토리 변경**: `rebase`, `commit --amend`는 **푸시 전**에만 안전. 공동 작업 브랜치에 강제 푸시(force push) 필요해질 수 있음.