CC=gcc
CFLAGS=-Wall -Wextra -std=c17

# 실행할 주차 (기본은 현재 디렉토리에서 호출하는 weekN)
WEEK ?= $(notdir $(CURDIR))

TARGET=prog
SRC=$(WEEK)/src/main.c
BIN=$(WEEK)/$(TARGET)

.PHONY: build run test clean

build:
	$(CC) $(CFLAGS) -o $(BIN) $(SRC)

run: build
	$(BIN)

test: build
	cd $(WEEK) && bash ../run_tests.sh

clean:
	rm -f $(WEEK)/$(TARGET)
