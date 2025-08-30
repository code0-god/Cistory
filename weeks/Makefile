SHELL := /bin/bash
CC=gcc
CFLAGS=-Wall -Wextra -std=c17

# 이 Makefile(공통)의 실제 경로 (절대경로)
MAKEFILE_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

# 주차명: 주차 폴더에서 실행 시 자동으로 week1, week2 ...
WEEK ?= $(notdir $(CURDIR))

TARGET=prog
SRC := $(MAKEFILE_DIR)/$(WEEK)/src/main.c
BIN := $(MAKEFILE_DIR)/$(WEEK)/$(TARGET)

.PHONY: build run test clean

build:
	$(CC) $(CFLAGS) -o $(BIN) $(SRC)

run: build
	$(BIN)

test: build
	cd $(MAKEFILE_DIR)/$(WEEK) && bash ../run_tests.sh

clean:
	rm -f $(BIN)
