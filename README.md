# **설회 Cistory 세미나**

본 저장소는 **C언어 기초**를 배우면서 동시에 **Git/GitHub 협업 방식**을 익히는 12주 세미나용 저장소입니다.  
관리자는 매주 과제 skeleton 코드를 `main` 브랜치에 업데이트하고, 학생들은 **pull &rarr; branch &rarr; commit &rarr; push &rarr; PR** 흐름을 통해 과제를 수행합니다.

---

## **세미나 목표**
- C언어 기본기 습득 (변수, 조건문, 반복문, 함수, 포인터, 구조체, 파일 입출력 등)
- Git/GitHub 실습을 통한 협업 워크플로우 체득
- **fork & PR** 과정을 통해 실제 오픈소스 개발 방식 경험
- 자동 채점 시스템을 활용한 즉각적 피드백 경험

---

## **저장소 구조**

```makefile
/                   # 루트: 개요 및 설정
├─ README.md        # 세미나 개요 (본 문서)
├─ .github/
│  ├─workflows/
│  │  ├─ dispatch-to-admin.yml  # PR 자동 채점 워크플로우
│  ├─ pull_request_template.md  # PR 템플릿
├─ CONTRIBUTING.md      # 제출 규칙(브랜치/PR/커밋 메시지)
├─ docs/                # 운영 문서, 주차별 가이드
│  ├─ setup.md          # 개발 환경 설정 가이드
│  ├─ workflow.md       # fork & PR, upstream 동기화, 브랜치 전략
│  ├─ git-commands.md   # Git 명령어 설명/치트시트
│  └─ weeks/            # 주차별 학습 가이드
│     ├─ week1.md
│     ├─ week2.md
│     └─ ...
└─ weeks/           # 주차별 과제 skeleton & 공용 테스트 러너
   ├─ Makefile               # 공용(각 주차 폴더에서 include)
   ├─ run_tests.sh           # 공용 테스트 러너(패턴/골든)
   ├─ week1/
   │  ├─ README.md      # 과제 설명
   |  │  ├─ Makefile    # WEEK := $(notdir $(CURDIR)) + include ../Makefile
   │  ├─ src/main.c    # 학생이 수정할 코드
   │  └─ tests_public/  # 공개 테스트 케이스
   │     ├─ test.conf        # MODE=pattern|golden 등
   │     └─ patterns.txt     # 테스트 패턴
   └─ week2/
      ├─ Makefile
      ├─ src/main.c
      └─ tests_public/
         ├─ test.conf
         └─ expected.txt
```
각 주차 디렉터리(weeks/weekN)에서 `make run` / `make test`를 실행하세요. 바이너리 이름은 공통으로 prog 입니다.

---

## **참여 방법 (학생용)**

1. **저장소 Fork**
   - 본 저장소(`code0-god/Cistory`)를 자신의 GitHub 계정으로 `fork`.

2. **로컬 Clone & Upstream 설정**
   ```bash
   git clone https://github.com/<your-username>/Cistory.git
   cd Cistory
   git remote add upstream https://github.com/code0-god/Cistory.git
   ```

3. **매주 시작 시 동기화**
   ```bash
   git checkout main
   git pull upstream main
   git push origin main
   ```

4. **과제 브랜치 생성**
   ```bash
   git checkout -b feature/weekN-학번
   ```

5. **코드 작성 & Commit & Push**
   ```bash
   git add <filename>
   git commit -m "feat: weekN 과제 구현"
   git push origin feature/weekN-<학번>
   ```

6. **Pull Request 생성**
   - GitHub에서 `code0-god/Cistory` 저장소 `main` 브랜치로 PR 생성
   - base: `code0-god/Cistory` &rarr; main
   - compare: `<your-username>/Cistory` &rarr; `feature/weekN-학번`
   - PR 제목 규칙: `[weekN] 과제 제출 - 이름(학번)`
   - PR 본문은 자동으로 제공되는 템플릿 [pull_request_template.md](.github/pull_request_template.md)이 적용됩니다.   

> 자세한 내용은 [docs/workflow.md](docs/workflow.md) 참고.
---

## **자동 채점 시스템**
- 모든 PR은 GitHub Actions를 통해 자동 채점됩니다(케이스별 PASS/FAIL 요약).
- 결과 요약은 PR 코멘트로 자동 게시됩니다.
- 공개/비공개 테스트 구성과 기준: [docs/grading.md](docs/grading.md)

## **주차별 자료**
- [1주차: Hello, World & Git 첫걸음](docs/weeks/week1.md)
- [2주차: 변수와 자료형 & git status/log](docs/weeks/week2.md)
- [3주차: 조건문 & branch](docs/weeks/week3.md)
- [4주차: 반복문 & merge/conflict](docs/weeks/week4.md)
- [5주차: 함수 & 원격 저장소](docs/weeks/week5.md)
- [8주차: 배열과 문자열 & Pull Request(PR)](docs/weeks/week8.md)
- [9주차: 포인터(1) & git diff](docs/weeks/week9.md)
- [10주차: 포인터(2) & .gitignore](docs/weeks/week10.md)
- [11주차: 함수와 포인터 & 워크플로우 복습](docs/weeks/week11.md)
- [12주차: 구조체/공용체 & git revert](docs/weeks/week12.md)
- [13주차: 동적 메모리 할당 & GitHub Issues](docs/weeks/week13.md)
- [14주차: 파일 입출력 & 종합](docs/weeks/week14.md)

---

## **규칙/가이드**
- **브랜치 이름**: `feature/weekN-학번`
- **PR 제목**: `[weekN] 과제 제출 - 이름(학번)`
- **커밋 메시지**: [Conventional Commits](https://www.conventionalcommits.org/) 스타일 권장
> 자세한 규칙은 [CONTRIBUTING.md](CONTRIBUTING.md) 문서를 참고하세요.
> Git 명령은 [docs/git-commands.md](docs/git-commands.md)를 참고하세요.

---

## **도움받기**
- 문제가 생기면 [Issue 탭](https://github.com/code0-god/Cistory/issues)에서 질문을 올리세요.

---

> **주의:** 본 저장소에는 과제 skeleton과 공개 테스트만 제공됩니다.
> 정답 코드 및 비공개 채점 스크립트는 별도의 비공개 저장소(`code0-god/Cistory-admin`)에서 관리됩니다.

