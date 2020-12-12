.PHONY: help install lint test
.DEFAULT_GOAL := help

# http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install:
	cask install --dev

lint:
	cask exec emacs -Q -batch -l test/lint-init.el -l package-lint.el -f package-lint-batch-and-exit pipenv.el

test: .cask
	cask exec ert-runner

.cask: Cask
	cask install
	touch $@
