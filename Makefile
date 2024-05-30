MNEMONIC := $(shell security find-generic-password -ga Mnemonic -s Hardhat -w)

install:
	@npm install

build:
	@npx hardhat compile;

deploy: deploy-force

deploy-force:
	@MNEMONIC="$(MNEMONIC)" npx hardhat run deploy/*.js --network sepolia;

test: test-force

test-force:
	@MNEMONIC="$(MNEMONIC)" npx hardhat test --network hardhat --show-stack-traces;

clean:
	rm -rf ./artifcats ./cache

.PHONY: install build deploy test