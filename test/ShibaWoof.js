const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("ShibaWoof", function () {
    let ShibaWoof;
    let shibaWoof;
    let owner;
    let addr1;
    let addr2;

    beforeEach(async function () {
        ShibaWoof = await ethers.getContractFactory("ShibaWoof");
        [owner, addr1, addr2] = await ethers.getSigners();
        shibaWoof = await ShibaWoof.deploy();
    });

    it("Should return the correct name, symbol, and decimals", async function () {
        expect(await shibaWoof.name()).to.equal("ShibaWoof42");
        expect(await shibaWoof.symbol()).to.equal("SW42");
        expect(await shibaWoof.decimals()).to.equal(0);
    });

    it("Should return the total supply of 42", async function () {
        expect(await shibaWoof.totalSupply()).to.equal(42);
    });

    it("Should transfer tokens correctly", async function () {
        await shibaWoof.transfer(addr1.address, 10);
        expect(await shibaWoof.balanceOf(addr1.address)).to.equal(10);
    });

    it("Should not allow transferring more tokens than the balance", async function () {
        await expect(shibaWoof.transfer(addr1.address, 50)).to.be.revertedWith("Insufficient balance");
    });

    it("Should not allow transferring to the zero address", async function () {
        await expect(shibaWoof.transfer("0x0000000000000000000000000000000000000000", 10)).to.be.revertedWith("Invalid recipient");
    });

    it("Should approve and transferFrom tokens correctly", async function () {
        await shibaWoof.approve(addr1.address, 20);
        await shibaWoof.connect(addr1).transferFrom(owner.address, addr2.address, 20);
        expect(await shibaWoof.balanceOf(addr2.address)).to.equal(20);
    });

    it("Should not allow transferring more tokens than allowed", async function () {
        await shibaWoof.approve(addr1.address, 10);
        await expect(shibaWoof.connect(addr1).transferFrom(owner.address, addr2.address, 20)).to.be.revertedWith("Insufficient allowance");
    });
});
