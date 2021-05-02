SHELL=/bin/bash

.PHONY: tf-test-format
tf-test-format:
	@go fmt ./...

.PHONY: tf-install-go-deps
tf-install-go-deps:
	@go mod vendor

.PHONY: tf-test
tf-test: tf-test-format tf-install-go-deps
	@if grep -q "prod" <<< "$$AWS_PROFILE"; then \
  	  echo "Error: You are using a production AWS profile $$AWS_PROFILE, which should not be used for terraform testing"; \
  	  exit 1; \
  	else \
  	  echo Initializing terraform tests with AWS profile \"$$AWS_PROFILE\"; \
  	  aws-vault exec $$AWS_PROFILE -- go test -v -timeout 30m; \
  	fi
	@echo "done"
