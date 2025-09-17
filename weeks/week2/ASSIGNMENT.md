# **Week 2: 변수와 자료형, Git 상태 추적**
## **과제 개요**
- 표준 입력으로 정수 a와 실수 b를 받아, 정수/실수 연산과 정수 승격(promotion) 결과를 지정된 포맷대로 출력합니다.
- 예외 처리 필수:
   - `(int)b == 0` &rarr; int div, mod 는 N/A 출력
   - `b == 0.0 `&rarr; float div 는 N/A 출력

- 채점은 GOLDEN(문자 단위 완전 일치)입니다.

---

## **과제 설명**
- `weeks/week2/src/main.c` 파일을 작성/수정합니다.
- 입력: 공백으로 구분된 정수 a, 실수 b 1줄.
- 아래 정확한 순서/라벨/포맷으로 출력하세요.

```
sizeof: int=4, float=4, double=8, char=1, bool=1
input: a=<a>, b=<b>
int div: <a / (int)b 결과>
float div: <a / b 결과, 소수점 둘째 자리>
sum(int): <a + (int)b>
sum(float): <a + b>
diff(int): <a - (int)b>
diff(float): <a - b>
prod(int): <a * (int)b>
prod(float): <a * b>
mod: <a % (int)b>
promotion: (char)a + (char)(int)b = <정수 승격 결과>
```
> 주의: 출력 포맷(공백, 콤마, 콜론, 줄바꿈, 소수점 자리수) 하나라도 다르면 FAIL 처리됩니다.

---

## **예제 입출력**

**Ex.1**
| Std | Contents |
|:---:|---|
| **Input** | `3 5.0` |
| **Output** | sizeof: int=4, float=4, double=8, char=1, bool=1 <br> input: a=3, b=5.00 <br> int div: 0 <br> float div: 0.60 <br> sum(int): 8 <br> sum(float): 8.00 <br> diff(int): -2 <br> diff(float): -2.00 <br> prod(int): 15 <br> prod(float): 15.00 <br> mod: 3 <br> promotion: (char)a + (char)(int)b = 8


**Ex.2**
| Std | Contents |
|:---:|---|
| **Input** | `10 20.0` |
| **Output** | sizeof: int=4, float=4, double=8, char=1, bool=1 <br> input: a=10, b=20.00 <br> int div: 0 <br> float div: 0.50 <br> sum(int): 30 <br> sum(float): 30.00 <br> diff(int): -10 <br> diff(float): -10.00 <br> prod(int): 200 <br> prod(float): 200.00 <br> mod: 10 <br> promotion: (char)a + (char)(int)b = 30

## **실행 / 테스트 방법**
- 반드시 **`weeks/week2` 디렉터리에서** 실행합니다.

```bash
# 빌드 후 실행
make run

# 빌드 -> 자동 테스트 실행
make test
```

- 테스트는 공개 케이스(`tests_public/`) 기준으로 PASS/FAIL을 보여줍니다.

---

## **제한사항**

- `printf`를 사용하여 출력해야 합니다.
- **서식 지정자**는 반드시 자료형에 맞게 사용해야 합니다.
  - `int` → `%d`, `float/double` → `%f`, `char` → `%c` or `%d`, `size_t` → `%zu`
- 출력 형식이 예제와 다르면 FAIL 처리될 수 있습니다.

---

## **Git 실습 과제**

1. `main.c`를 수정 후 `git status -s` 실행하여 변경 사항 확인
2. `git add main.c` → 다시 `git status -s` 실행
3. `git commit -m "feat: week2 자료형 및 연산 예제 구현"`
4. `git log --oneline` 및 `git log --graph --oneline --decorate --all`로 커밋 기록 확인
5. `git diff`와 `git diff --staged`의 차이를 비교 실습

---

## **제출 규칙**

1. **브랜치 이름:** `feature/week2-학번`
    - ex. `feature/week2-202512345`
2. **커밋 메시지 예시:**
    ```
    feat: week2 자료형 및 연산 예제 구현
    ```
3. **Pull Request(PR) 제목:**
    ```
    [week2] 과제 제출 - 이름(학번)
    ```
4. **PR 본문:** 자동 생성된 템플릿을 따라 작성하세요.

---

## **체크포인트**

* [ ] `make run`으로 정상 실행되는가?
* [ ] 변수 크기, 정수/실수 나눗셈, 정수 승격, 배열 길이 출력이 모두 포함되었는가?
* [ ] 자료형에 맞는 서식 지정자를 사용했는가?
* [ ] `git status -s`, `git diff`, `git log`를 실습했는가?
* [ ] 브랜치 이름과 PR 제목 규칙을 지켰는가?
* [ ] PR 본문 템플릿을 채웠는가?