
# Terraform tests

This section provides an example how to test terraform code using [terratest]().

# Requirements

- [Install go - we are using 1.15 in this example](https://golang.org/doc/install)
- [Optionally install aws-vault](https://github.com/99designs/aws-vault)

Since version 1.11 is using go mod for dependency management. For more information 
on how to use [go modules see here](https://blog.golang.org/using-go-modules).

# Usage

We have concentrated all steps required to run tests for our dummy terraform setup in a
Makefile. 
Since terratest actually deploys your code, you need to provide it credentials.
If you look in our provided Makefile, you will notice that we are using `aws-vault` 
to inject credentials. To run the tests you simply need to run:

```bash
make AWS_PROFILE=<my-aws-test-profile> tf-test
```
.. where you will need to replace the `<my-aws-test-profile>` part. If your profile contains
`prod` the Makefile will stop execution, as we want to prevent deploying on any production
account by accident.

If you are not using aws-vault, then you can also alternatively run:
```bash
# install go dependencies
make tf-install-go-deps
# run tests
go test -v -timeout 30m
```