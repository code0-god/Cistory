#include <stdio.h>
#include <stdbool.h>
#include <limits.h>
#include <float.h>

int main(void) {
    // 1) sizeof 출력 (64-bit Linux/GCC 기준)
    //   TODO: int, float, double, char, bool의 크기를 printf로 출력
    printf("sizeof: int=%zu, float=%zu, double=%zu, char=%zu, bool=%zu\n");

    // 2) 입력: 정수 a, 실수 b 
    int a = 0;
    double b = 0.0;
    if (scanf("%d %lf", &a, &b) != 2) {
        return 0; /* 입력 형식이 잘못되면 종료 */
    }

    printf("input: a=%d, b=%.2f\n", a, b);

    /* 3) 보조 변수: (int)b */
    int ib = (int)b;

    /* 4) 정수 나눗셈 */
    // TODO: ib == 0일 경우 "int div: N/A" 출력, 아니면 a / ib 출력
    printf("");

    /* 5) 실수 나눗셈 */
    // TODO: b == 0.0일 경우 "float div: N/A" 출력, 아니면 a / b 출력
    printf("");

    /* 6) 합/차/곱 (정수, 실수) */
    // TODO: sum(int), sum(float), diff(int), diff(float), prod(int), prod(float)
    printf("");

    /* 7) 나머지 */
    // TODO: ib == 0이면 "mod: N/A", 아니면 a % ib 출력
    printf("");

    /* 8) 정수 승격(promotion) */
    // TODO: (char)a + (char)(int)b 의 결과를 int로 출력
    printf("");
    
    return 0;
}
