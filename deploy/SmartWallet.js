const hre = require("hardhat");

async function main() {
    let smartWallet;
    const tokenAddress = "0x88b5d36f929941f27d7e68f56dc8ed34f36b1e96";
    const initialSigners = ["0x10EF82f63C9F673994218B17375EAee61A133073", "0x728C5A1Fc16C267f82163C926a8eA375533F8B0A", "0x7Bb2368cc8B0cBD24BDb4fDc3C259a18D28291C1"];

    try {
        const SmartWallet = await hre.ethers.getContractFactory("SmartWallet");
        smartWallet = await SmartWallet.deploy(tokenAddress, initialSigners);
        //await smartWallet.deployed();
        console.log("SmartWallet contract has been successfully deployed to:", smartWallet.target);
    } catch (error) {
        console.error("Error during deployment:", error);
        process.exit(1);
    }

    console.log("Contract verification is in progress...");
    await new Promise(resolve => setTimeout(resolve, 60000));

    try {
        await hre.run("verify:verify", {
            address: smartWallet.target,
            constructorArguments: [tokenAddress, initialSigners],
            force: true
        });
        console.log("Contract verified on Etherscan successfully.");
    } catch (error) {
        console.error("Error during verification:", error);
        process.exit(1);
    }
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
