MNEMONIC := $(shell grep -oP 'MNEMONIC="\K[^"]+' .env 2>/dev/null || echo "")

ifeq ($(MNEMONIC),)
MNEMONIC := $(shell security find-generic-password -ga Mnemonic -s Hardhat -w)
endif

install:
	@npm install

build:
	@npx hardhat compile;

deploy: deploy-force

deploy-force:
	@for file in deploy/*.js; do \
		echo "Deploying $$file..."; \
		MNEMONIC="$(MNEMONIC)" npx hardhat run $$file --network sepolia --show-stack-traces; \
	done


test: test-force

test-force:
	@MNEMONIC="$(MNEMONIC)" npx hardhat test --network hardhat --show-stack-traces;

clean:
	rm -rf ./artifcats ./cache

.PHONY: install build deploy test