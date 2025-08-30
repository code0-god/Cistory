# **1주차: Hello, World & Git 첫걸음**

## **학습 목표**
- **C언어 기초**  
  - C 프로그램의 기본 구조(`main` 함수)
  - `printf`를 활용한 출력
  - 소스코드 &rarr; 컴파일 &rarr; 실행 과정 이해
- **Git/GitHub 기초**  
  - Git 저장소의 개념과 버전 관리 이해
  - GitHub 저장소 fork & clone
  - Upstream 설정 및 첫 `commit`과 `push`

---

## **Summary**
1. **C 프로그램의 구조**
   ```c
   #include <stdio.h>

   int main(void) {
       printf("Hello, World!\n");
       return 0;    
   }
    ```

- `#include <stdio.h>` : 표준 입출력 라이브러리 포함
- `main` 함수 : C 프로그램의 시작점
- `printf` : 문자열 출력 함수
- `return 0;` : 프로그램 정상 종료

2. **컴파일 과정**
- `gcc hello.c -o hello` &rarr; 실행 파일(`hello`) 생성
- `./hello` &rarr; 실행 결과 확인

3. **Git 기본 명령어**
- `git clone <URL>` : 원격 저장소 복제
- `git remote add upstream <URL>` : 중앙 저장소 연결
- `git fetch upstream` / `git pull upstream main` : 최신 코드 가져오기
- `git add <file>` : 변경 파일 스테이징
- `git commit -m "<message>"` : 버전 기록 남기기
- `git push origin <branch>` : 원격 저장소 업로드

---

## **실습 과제**
1. 중앙 저장소 `code0-god/Cistory`를 **fork** 후 로컬 환경에 clone 합니다.
   ```bash
   git clone https://github.com/<your-username>/Cistory.git
   cd Cistory
   ```

2. upstream(중앙 저장소) 설정
    ```
    git remote add upstream https://github.com/code0-god/Cistory.git
    git remote -v   # upstream이 정상 등록되었는지 확인
    ```

3. `weeks/week1` 폴더로 이동 후, `src/hello.c` 파일을 작성합니다.
   ```c
   #include <stdio.h>

   int main(void) {
       printf("Hello, World! 제 이름은 홍길동입니다.\n");
       return 0;
   }
   ```

4. 코드 작성 후, Git으로 저장하고 원격 저장소에 업로드합니다.
   ```bash
   git checkout -b feature/week1-학번
   git add weeks/week1/src/hello.c
   git commit -m "feat: week1 hello.c 자기소개 출력 구현"
   git push origin feature/week1-학번
   ```

4. GitHub에서 PR을 생성합니다.
- **대상 저장소**: `code0-god/Cistory`
- **PR 제목**: `[week1] 과제 제출 - 이름(학번)`
- **PR 본문**: 자동 생성된 템플릿을 채워 제출

---

## 제출 예시

**PR 제목**: [week1] 과제 제출 - 홍길동(202512345)

**PR 본문 (템플릿 일부 작성 후)**

```markdown
## 과제 정보
- 주차: week1
- 이름/학번: 홍길동 / 202512345

## 제출 내용
- [x] 구현한 기능을 간단히 요약:
    - hello.c 작성
    - printf로 자기소개 출력
- [ ] 추가 설명이나 어려웠던 점이 있다면 적어주세요 (선택):
    - 없음

## 규칙 확인
- [x] 브랜치 이름이 `feature/week1-202512345` 규칙을 따름
- [x] PR 제목이 `[week1] 과제 제출 - 홍길동(202512345)` 규칙을 따름
```

---

> **Tip:**
> 첫 주는 “Hello, World”를 찍어보는 것이 목표입니다.
> GitHub PR 과정을 익히는 것이 더 중요하니, 코드 자체는 간단히 작성해도 괜찮습니다.
