# **설회 Cistory 세미나**

본 저장소는 **C언어 기초**를 배우면서 동시에 **Git/GitHub 협업 방식**을 익히는 12주 세미나용 저장소입니다.  
진행자는 매주 과제 skeleton 코드를 `main` 브랜치에 업데이트하며, 학생들은 **fork &rarr; pull &rarr; branch &rarr; commit &rarr; push &rarr; PR** 흐름을 통해 과제를 수행합니다.

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
├─ docs/            # 운영 문서, 주차별 가이드
│  ├─ setup.md          # 개발 환경 설정 가이드
│  ├─ workflow.md       # fork & PR 워크플로우 설명
│  └─ weeks/            # 주차별 학습 가이드
│     ├─ week1.md
│     ├─ week2.md
│     └─ ...
├─ weeks/           # 주차별 과제 skeleton
│  ├─ week1/
│  │  ├─ README.md      # 과제 설명
│  │  ├─ src/hello.c    # 학생이 수정할 코드
│  │  └─ tests_public/  # 공개 테스트 케이스
│  ├─ week2/
│  └─ ...
└─ .github/workflows/
└─ pr-grade.yml      # PR 자동 채점 워크플로우
```

---

## **참여 방법 (학생용)**

1. **저장소 Fork**
   - 본 저장소(`code00god/Cistory`)를 자신의 GitHub 계정으로 `fork`.

2. **로컬 Clone & Upstream 설정**
   ```bash
   git clone https://github.com/<your-username>/Cistory.git
   cd Cistory
   git remote add upstream https://github.com/code0-god/Cistory.git
   ```

3. **매주 시작 시 업데이트**
   ```bash
   git checkout main
   git pull upstream main
   git push origin main
   ```

4. **과제 브랜치 생성**
   ```bash
   git checkout -b feature/weekN-학번
   ```

5. **코드 작성 & Commit**
   ```bash
   git add <filename>
   git commit -m "feat: weekN 과제 구현"
   git push origin feature/weekN-<학번>
   ```

6. **Pull Request 제출**
   - GitHub에서 `code0-god/Cistory` 저장소 `main` 브랜치로 PR 생성
   - PR 제목 규칙: `[weekN] 과제 제출 - 이름(학번)`
   - PR 본문은 자동으로 제공되는 템플릿 [pull_request_template.md](.github/pull_request_template.md)이 적용됩니다.   
      &rarr; `- [ ]` 표시는 GitHub에서 체크박스로 렌더링되며, 학생은 체크하거나 답변만 채우면 됩니다.

---

## **자동 채점 시스템**
- 모든 PR은 GitHub Actions를 통해 자동 채점됩니다.
- PR 코멘트에 결과(점수/간단 피드백)가 자동 게시됩니다.
- 정답/비공개 테스트는 별도의 관리자 저장소(code0-god/Cistory-admin)에서 관리되므로 학생은 볼 수 없습니다.
- 채점 기준 및 절차는 [grading.md](docs/grading.md)문서를 참고하세요.

## **주차별 자료**
- [1주차: Hello, World & Git 첫걸음](docs/weeks/week1.md)
- [2주차: 변수와 자료형 & git status/log](docs/weeks/week2.md)
- [3주차: 조건문 & branch](docs/weeks/week3.md)
- [4주차: 반복문 & merge/conflict](docs/weeks/week4.md)
- [5주차: 함수 & 원격 저장소](docs/weeks/week5.md)
- [6주차: 배열/문자열 & Pull Request](docs/weeks/week6.md)
- [7주차: 포인터(1) & git diff](docs/weeks/week7.md)
- [8주차: 포인터(2) & .gitignore](docs/weeks/week8.md)
- [9주차: 함수와 포인터 & 워크플로우 복습](docs/weeks/week9.md)
- [10주차: 구조체 & git revert](docs/weeks/week10.md)
- [11주차: 파일 입출력 & GitHub Issues](docs/weeks/week11.md)
- [12주차: 미니 프로젝트 & 종합](docs/weeks/week12.md)

---

## **자동 채점 시스템**
- 모든 PR은 GitHub Actions를 통해 **자동 채점**됩니다.
- PR 코멘트에 결과(점수/간단 피드백)가 자동 게시됩니다.
- 정답/비공개 테스트는 별도의 관리자 저장소(`code0-god/Cistory-admin`)에서 관리되므로 학생은 볼 수 없습니다.

---

## **규칙**
- **브랜치 이름**: `feature/weekN-학번`
- **PR 제목**: `[weekN] 과제 제출 - 이름(학번)`
- **커밋 메시지**: [Conventional Commits](https://www.conventionalcommits.org/) 스타일 권장
   - 간단히 기능이 드러나도록 작성
   - (ex: `feat: 배열 평균 계산 함수 구현`)

> 자세한 규칙은 [CONTRIBUTING.md](CONTRIBUTING.md) 문서를 참고하세요.
---

## **도움받기**
- 문제가 생기면 [Issue 탭](https://github.com/code0-god/Cistory/issues)에서 질문을 올리세요.
- Git 기본 명령어 및 PR 과정은 [docs/workflow.md](docs/workflow.md) 참고.

---

> **주의:** 본 저장소에는 과제 skeleton과 공개 테스트만 제공됩니다.
> 정답 코드 및 비공개 채점 스크립트는 별도의 비공개 저장소(`code0-god/Cistory-admin`)에서 관리됩니다.

