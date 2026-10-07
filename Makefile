# Check if OPA CLI is installed
OPA := $(shell command -v opa 2> /dev/null)
ifeq ($(OPA),)
$(error "opa CLI not found. Please install it: https://www.openpolicyagent.org/docs/latest/cli/")
endif

.PHONY: help test validate fmt clean build

##@ Help
help: ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\033[1mUsage\033[0m\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Policies
test: ## Test policy files
	@opa test policies

validate: ## Validate policy files (strict)
	@opa check --strict policies

fmt: ## Fail if any policy file is not opa fmt clean
	@opa fmt --fail -l policies

clean: ## Clean up build artifacts
	@rm -f dist/*

# Bundle the policies into a tarball for OCI registry
build: clean ## Build the policy bundle
	@mkdir -p dist/
	@opa build -b policies -o dist/bundle.tar.gz
