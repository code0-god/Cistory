# **Week 1: Hello, World! 출력하기**
## **과제 개요**
- 첫 번째 과제는 C 언어로 **자기소개 문구를 출력**하는 프로그램을 작성하는 것입니다.
- 이 과제를 통해 C 프로그램의 구조와 GitHub PR 제출 과정을 익힙니다.

---

## **과제 설명**
1. `weeks/week1/src/hello.c` 파일을 작성/수정합니다.
2. 프로그램이 실행되면 **자신의 이름과 학번**를 출력해야 합니다.
   
---

## **예제 입출력**

**Ex.1**
<style>
  .custom-table {
    border-collapse: collapse;
    width: auto; /* 테이블 너비 조절 */
  }
  .custom-table th, .custom-table td {
    border: 1px solid #ccc;
    padding: 10px;
    text-align: left;
  }
  .custom-table th {
    background-color: #a0a0a0ff; /* 헤더 배경색 */
    text-align: center;
    vertical-align: center;
    width: auto; 
  }
</style>

<table class="custom-table">
  <tbody>
    <tr>
      <th style="text-align: center;">Input</th>
      <td>None</td>
    </tr>
    <tr>
      <th>Output</th>
      <td>Hello, World! <br> 이름: 홍길동 <br> 학번: 202512345</td>
    </tr>
  </tbody>
</table>

**Ex.2**

<table class="custom-table">
  <tbody>
    <tr>
      <th style="text-align: center;">Input</th>
      <td>None</td>
    </tr>
    <tr>
      <th>Output</th>
      <td>Hello, World! <br> 이름: 홍길동 <br> 학번: 202512345</td>
    </tr>
  </tbody>
</table>

---

## **실행 방법**

```bash
# 빌드
make build

# 실행
make run
```

> Makefile이 기본 제공됩니다. `make run` 실행 시 `./hello`가 실행됩니다.

---

## **제한사항**
- 반드시 `printf` 함수를 사용하여 출력하세요.
- 출력 형식은 반드시 예제 출력을 따라야 합니다.
- 소스 파일은 `weeks/week1/src/hello.c`를 사용하세요.

---

## **제출 규칙**

1. **브랜치 이름:** `feature/week1-학번`
    - ex. `feature/week1-202512345`
2. **커밋 메시지 예시:**
   ```
   feat: week1 hello.c 자기소개 출력 구현
   ```
3. **Pull Request(PR) 제목:**
   ```
   [week1] 과제 제출 - 이름(학번)
   ```
4. **PR 본문:** 자동 생성된 템플릿을 따라 작성하세요.
   (체크박스와 작성 항목이 표시됩니다.)

---

## **체크포인트**
- [ ] `make run`으로 정상 실행되는가?
- [ ] 이름과 학번이 정확히 출력되는가?
- [ ] 브랜치 이름과 PR 제목 규칙을 지켰는가?
- [ ] PR 본문 템플릿을 채웠는가?
