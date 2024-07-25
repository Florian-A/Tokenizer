const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("SmartWallet", function () {
    let ShibaWoof;
    let shibaWoof;
    let SmartWallet;
    let smartWallet;
    let owner;
    let addr1;
    let addr2;

    beforeEach(async function () {

        [owner, addr1, addr2, addr3, addr4] = await ethers.getSigners();

        ShibaWoof = await ethers.getContractFactory("ShibaWoof");
        shibaWoof = await ShibaWoof.connect(owner).deploy();

        SmartWallet = await ethers.getContractFactory("SmartWallet");
        smartWallet = await SmartWallet.connect(owner).deploy(await shibaWoof.getAddress(), [addr1, addr2, addr3]);

        await shibaWoof.transfer(smartWallet.getAddress(), 20);
    });

    it("Should have correct initial balance of tokens", async function () {
        // Check initial balance of smartWallet
        const smartWalletBalance = await smartWallet.getBalance();
        expect(smartWalletBalance).to.equal(20);
    });

    it("Should be able to transfer tokens to another address", async function () {
        // Withdraw tokens from smartWallet to addr1
        await smartWallet.withdraw(10);
        const smartWalletBalance = await smartWallet.getBalance();
        const ownerBalance = await shibaWoof.balanceOf(owner.address);

        expect(smartWalletBalance).to.equal(10);
        expect(ownerBalance).to.equal(32);
    });

});
