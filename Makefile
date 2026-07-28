# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agarcia2 <agarcia2@student.42barcelona.co  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/07/28 10:27:46 by agarcia2          #+#    #+#              #
#    Updated: 2026/07/28 14:02:11 by agarcia2         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

help:
	@echo "Apple Security Lab"
	@echo ""
	@echo "Available targets:"
	@echo "  make install"
	@echo "  make check"
	@echo "  make doctor"
	@echo "  make version"
	@echo "  make env [TARGET=name]"
	@echo "  make target-new NAME=name [PROFILE=profile]"
	@echo "  make target-list"
	@echo "  make profile-list"
	@echo "  make lint"
	@echo "  make fmt"
	@echo "  make test"
	@echo "  make clean"

install: check
check:
	./bin/seclab check
doctor:
	./bin/seclab doctor
version:
	./bin/seclab version
env:
	./bin/seclab env $(TARGET)
target-new:
	./bin/seclab target new $(NAME) $(PROFILE)
target-list:
	./bin/seclab target list
profile-list:
	./bin/seclab profile list
lint:
	find . -type f -name "*.sh" -not -path "./.venv/*" -not -path "./.git/*" -exec shellcheck {} +
fmt:
	find . -type f -name "*.sh" -not -path "./.venv/*" -not -path "./.git/*" -exec shfmt -w {} +
test:
	@echo "No tests available yet."
clean:
	rm -rf .tmp

.PHONY: help install check doctor version env target-new target-list profile-list lint fmt test clean
