# **2주차: 변수와 자료형(variables & data types) & git status/log**

## **학습 목표**

- **C언어**
  - 변수 개념과 기본 자료형(`int`, `float`, `double`, `char`, `bool`)
  - 스칼라 자료형의 의미/폭(`char`, `int`, `long`, `long long`, `float`, `double`, `bool`)
  - `signed/unsigned`, 리터럴 접미사(`U`,`L`,`LL`,`F`), 암시적 형변환(정수 승격)
  - `sizeof`, `<limits.h>/<float.h>`, 올바른 서식 지정자(`%zu`, `%lld`, `%u`, `%f/%e`)
  - 정수 나눗셈 vs 실수 나눗셈, 오버플로 주의(부호 있는 정수 UB)
- **Git/GitHub**
  - Working tree ↔ **Index(stage)** ↔ **HEAD** 상태 흐름
  - `git status`/`git diff`/`git log`의 목적과 자주 쓰는 옵션
  - 축약 상태(`-s`), 로그 그래프(`--graph --oneline --decorate --all`)


---

## **Summary**
### 1. C: 변수와 자료형
#### 1.1 변수와 기본 자료형

- **변수**: 데이터를 저장하는 이름 붙은 공간. 선언 시 자료형을 지정해야 함.
  ```c
  int age = 20;
  float height = 175.5f;
  ```

- **기본 자료형**
  - `int` : 정수 (보통 4바이트)
  - `float` : 단정도 실수 (소수점 포함, 4바이트)
  - `double` : 배정도 실수 (더 정밀, 8바이트)
  - `char` : 문자 (1바이트)
  - `bool` : 참/거짓 (`<stdbool.h>` 필요)

---

#### 1.2 타입 크기와 형식 지정자

```c
#include <stdio.h>
#include <stdbool.h>
#include <limits.h>
#include <float.h>

int main(void) {
    /* 크기: size_t 반드시 %zu */
    printf("int=%d, float=%zu, double=%zu, char=%zu, bool=%zu\n",
           sizeof(int), sizeof(float), sizeof(double),
           sizeof(char), sizeof(bool));

    int a = 10;
    float b = 3.14f;
    double c = 2.718;

    printf("int=%d, float=%.2f, double=%.3f\n", a, b, c);
    return 0;
}
```

- `int` &rarr; `%d`  
- `float`, `double` &rarr; `%f` (지수 표기는 `%e`)  
- `char`(문자) &rarr; `%c`, `char`(숫자) &rarr; `%d`  
- `bool` &rarr; `%d` (0: 거짓, 1: 참)  
- 크기를 출력할 때는 `%zu` (결과가 `size_t`이므로)

---

#### 1.3 정수 vs 실수 나눗셈

```c
int a = 7, b = 2;
printf("int div: %d\n", a / b);       // 3
printf("float div: %.2f\n", a / 2.0); // 3.50 연산항을 실수로
```

- 정수를 정수로 나누면 나머지는 버려짐.  
- 연산결과는 연산항과 피연산항 중 더 큰 타입을 따라감.
  - 더 큰 타입에 맞게 암시적 형변환
---

#### 1.4 암시적 형변환(정수 승격)

```c
char x = 100, y = 50;
int sum = x + y;   // 내부적으로 char -> int로 변환
printf("sum=%d\n", sum);
```

- 작은 정수형(`char`, `short`)은 연산 시 자동으로 `int`로 변환됨 &rarr; 이를 정수 승격이라고 하며, **암시적 형변환**의 예.  
- **형변환 종류**
  - 암시적 형변환: 컴파일러가 자동으로 수행 (`int` &rarr; `double`)  
  - 명시적 형변환: 프로그래머가 캐스트 지정 `(double)a`  

- **주의**: 부호 있는 정수 오버플로는 정의되지 않음(UB). signed/unsigned 혼합 연산 시 예상치 못한 결과 가능.

---

#### 1.5 signed/unsigned, 리터럴, 배열 길이

```c
#include <stdio.h>
#include <stddef.h>
int main(void) {
    signed char sc = -1;       // 출력은 %d
    unsigned char uc = 255u;   // 출력은 %u
    printf("sc=%d, uc=%u\n", sc, uc);

    // 리터럴 접미사
    unsigned u = 123U;
    long l = 1000000L;
    long long ll = 9LL;
    float f = 3.14F;

    // 배열 길이: 컴파일타임 계산 
    int arr = {0};
    size_t n = sizeof(arr) / sizeof(arr);
    printf("len(arr)=%zu\n", n);
    return 0;
}
```

- 리터럴은 접미사로 타입을 지정: `123U`(unsigned), `123L`(long), `123LL`(long long), `3.14F`(float)
- 변수명은 `l`, `ll` 대신 다른 이름을 써서 숫자 1(`1`)과 혼동 방지


---

#### 1.6 서식 지정자 요약표

- `int` &rarr; `%d`
- `unsigned` &rarr; `%u`
- `long` &rarr; `%ld`
- `long long` &rarr; `%lld`
- `size_t` &rarr; `%zu`
- `double` &rarr; `%f` / `%e`


---

### **2. Git: status/diff/log**
#### 2.1 내부 모델(요약)

```
Working tree (파일 실제 내용)
   │  git add
   ▼
Index / Stage (다음 커밋 후보 스냅샷)
   │  git commit
   ▼
HEAD (현재 브랜치가 가리키는 커밋)
```

---

#### 2.2 상태/차이 확인

```bash
# 상태(축약)
$ git status -s
?? new.c      # untracked
 M main.c     # 작업트리에만 수정
A  util.c     # 새 파일이 스테이징됨

# 차이 보기
$ git diff            # 작업트리 ↔ Index
$ git diff --staged   # Index ↔ HEAD

# 스테이징/취소
$ git add <file>
$ git restore --staged <file>
$ git restore <file>             # 작업트리 변경 취소(주의)

```

---

#### 2.3 로그 살펴보기(옵션 예시)

```
$ git log --oneline
$ git log --graph --oneline --decorate --all   # 브랜치 그래프
$ git log --stat -n 5                          # 최근 5개 커밋 통계
$ git log -- <path>                            # 특정 파일 히스토리

```

---

## **컴파일 & 실행(Week2 폴더)**

```
cd weeks/week2
make run     # 빌드 + 실행 (바이너리: ./prog)
make test    # 공개 테스트(요약 출력)
```


---

## **수업 내 실습 데모(따라하기)**

1. `weeks/week2/src/main.c`에 타입 크기 2~3개와 나눗셈 예제 추가
2. `make run` 실행
3. `git status -s` 확인 → `git add` → 다시 `git status -s`
4. `git commit -m "feat: week2 demo"` → `git log --oneline` 확인
5. `git diff` vs `git diff --staged` 차이 체험


---

## **체크리스트(학습 점검)**

- [ ] `int` / `float` / `double`의 기본 서식 지정자를 아는가?  
- [ ] `size_t` / `unsigned` / `long long`의 서식 지정자를 올바르게 쓸 수 있는가?  
- [ ] 정수 vs 실수 나눗셈 차이를 설명할 수 있는가?  
- [ ] 암시적 형변환(정수 승격)의 의미를 이해했는가?  
- [ ] 부호 있는 정수 오버플로가 UB임을 아는가?  
- [ ] `git status -s` 표기(??, M, A 등)를 해석할 수 있는가?  
- [ ] `git diff`와 `git diff --staged`의 차이를 이해했는가?  
- [ ] `git log` 그래프 옵션으로 브랜치를 시각적으로 추적할 수 있는가?  


---

## **참고 자료**

- C 표준 헤더: `<limits.h>`, `<float.h>`, `<stdbool.h>`
- `man printf` / 컴파일러 문서(서식 지정자 표)
- Git 문서: `git help status|diff|log`
```