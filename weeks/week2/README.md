# **Week 1: Hello, World! 출력하기**
## **과제 개요**
- 첫 번째 과제는 C 언어로 **자기소개 문구를 출력**하는 프로그램을 작성하는 것입니다.
- 이 과제를 통해 C 프로그램의 구조와 **GitHub PR** 제출 과정을 익힙니다.

---

## **과제 설명**
1. `weeks/week1/src/hello.c` 파일을 작성/수정합니다.
2. 프로그램이 실행 시 **자신의 이름과 학번**을 반드시 출력해야 합니다.

> 소스 파일 이름은 모든 주차에서 `main.c`로 통일합니다.

---

## **예제 입출력**

**Ex.1**
| Std | Contents |
|:---:|---|
| **Input** | `None` |
| **Output** | Hello, World! <br> 이름: 홍길동 <br> 학번: 202512345 |

**Ex.2**
| Std | Contents |
|:---:|---|
| **Input** | `None` |
| **Output** | Hello, World! <br> 이름: 정영신 <br> 학번: 202320776 |

---

## **실행 / 테스트 방법**
- 아래 명령은 반드시 **`weeks/week1` 디렉터리에서** 실행합니다.  
- 이 저장소는 **공용 Makefile**을 사용하므로 각 주차 폴더에서 `make run`/`make test`만 실행하면 됩니다.

   ```bash
   # 빌드 후 실행
   make run

   # 빌드 -> 자동 테스트(형식 검사, pattern 기반)
   make test
   ```

## **테스트 출력 형식(중요)**
- 테스트는 케이스 단위로 PASS/FAIL만 표시합니다.
- Ex.
   ```bash
   ===== Pattern Tests (week1) =====
   CASE base_format: PASS
   RESULT: PASS (1/1)
   ```
   또는
   ```bash
   ===== Pattern Tests (week1) =====
   CASE base_format: FAIL
   RESULT: FAIL (0/1, failed=1)
   ```

---

## **제한사항**
- 반드시 `printf` 함수를 사용하여 출력하세요.
- 출력 형식은 반드시 예제와 동일한 형식을 따라야 합니다.
- 소스 파일은 `weeks/week1/src/main.c`를 사용하세요.

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
