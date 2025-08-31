# **Cistory 세미나 Git/GitHub 워크플로우 가이드**
## **목적**
이 문서는 세미나 참여 학생들이 과제를 수행할 때 따라야 하는 **Git/GitHub 기본 워크플로우**를 설명합니다.  
과제 제출은 **pull &rarr; branch &rarr; commit &rarr; push &rarr; Pull Request(PR)** 흐름으로 진행됩니다.

---

## **준비 단계**

1. **저장소 Fork**
- 중앙 저장소([code0-god/Cistory](https://github.com/code0-god/Cistory))를 자신의 GitHub 계정으로 fork합니다.

2. **Clone**
   ```bash
   git clone https://github.com/<your-username>/Cistory.git
   cd Cistory
   ```

3. **Upstream 설정**
- 중앙 저장소를 `upstream`이라는 이름으로 등록합니다.
   ```bash
   git remote add upstream https://github.com/code0-god/Cistory.git
   git remote -v   # 설정 확인
   ```

---

## **매주 시작 시 업데이트**
- 관리자가 새로운 주차 skeleton 코드를 `main` 브랜치에 올립니다.
- 학생은 본인 저장소를 최신 상태로 유지해야 합니다.

   ```bash
   git checkout main
   git pull upstream main      # 중앙 저장소의 변경사항 가져오기
   git push origin main        # 자신의 fork도 최신화
   ```

---

## **과제 진행 (Branch &rarr; Commit &rarr; Push)**
1. **과제 브랜치 생성**
   ```bash
   git checkout -b feature/weekN-학번
   ```

2. **코드 작성**
- ex. `weeks/weekN/src/` 폴더에 있는 skeleton 코드 수정/구현

3. **Commit**
   ```bash
   git add weeks/weekN/src/<file>.c
   git commit -m "feat: weekN 과제 구현"
   ```

4. **Push**
   ```bash
   git push origin feature/weekN-학번
   ```

---

## **Pull Request 제출**
1. GitHub 웹사이트에서 **"Compare & pull request"** 버튼 클릭
   - (혹은 "New pull request" 버튼 &rarr; base: `code0-god/Cistory:main`, compare: `<your-username>/Cistory:feature/weekN-학번` 선택)

2. **PR 제목 규칙**
   ```
   [weekN] 과제 제출 - 이름(학번)
   ```

   - ex. `[week3] 과제 제출 - 홍길동(202512345)`

3. **PR 본문**
   - 자동으로 제공되는 템플릿 [pull_request_template.md](../.github/pull_request_template.md)이 불러와집니다.
   - `- [ ]`는 GitHub에서 **체크박스**로 렌더링됩니다.
   - 각 항목에 맞춰 **체크하거나 작성**하세요.

---

## **제출 후 확인**
- PR이 생성되면 GitHub Actions가 자동 실행됩니다.
- 테스트 결과(공개 + 비공개)가 **PR 코멘트**에 달립니다.
- 필요 시 담당자/동료 학생이 추가 피드백을 남길 수 있습니다.

---

> **Tip:**
> - `git log --graph --oneline --all` 명령으로 브랜치 흐름을 시각적으로 확인할 수 있습니다.
> - 실수했을 경우 `git revert`나 `git reset`으로 수정 가능하니 두려워하지 마세요.