#include <stdio.h>
#include <stdbool.h>
#include <limits.h>
#include <float.h>

int main(void) {
    /* 1) sizeof 라인 (64-bit Linux/GCC 기준) */
    printf("sizeof: int=%zu, float=%zu, double=%zu, char=%zu, bool=%zu\n",
           sizeof(int), sizeof(float), sizeof(double), sizeof(char), sizeof(bool));

    /* 2) 입력: 정수 a, 실수 b */
    int a = 0;
    double b = 1.0;
    if (scanf("%d %lf", &a, &b) != 2) {
        return 0; /* 테스트에서는 항상 입력 제공 */
    }
    printf("input: a=%d, b=%.2f\n", a, b);

    /* (int)b와 b 각각에 대해 예외 처리 플래그 */
    int ib = (int)b;
    int ib_is_zero = (ib == 0);
    int b_is_zero  = (b == 0.0);

    /* 3) 정수 나눗셈 */
    if (ib_is_zero) printf("int div: N/A\n");
    else            printf("int div: %d\n", a / ib);

    /* 4) 실수 나눗셈 */
    if (b_is_zero)  printf("float div: N/A\n");
    else            printf("float div: %.2f\n", a / b);

    /* 5) 합/차/곱 (정수/실수) */
    printf("sum(int): %d\n", a + ib);
    printf("sum(float): %.2f\n", a + b);

    printf("diff(int): %d\n", a - ib);
    printf("diff(float): %.2f\n", a - b);

    printf("prod(int): %d\n", a * ib);
    printf("prod(float): %.2f\n", a * b);

    /* 6) 나머지 */
    if (ib_is_zero) printf("mod: N/A\n");
    else            printf("mod: %d\n", a % ib);

    /* 7) 정수 승격: (char)a + (char)(int)b -> int */
    char ca = (char)a;
    char cb = (char)ib;
    int promoted_sum = (int)(ca + cb);
    printf("promotion: (char)a + (char)(int)b = %d\n", promoted_sum);

    return 0;
}
