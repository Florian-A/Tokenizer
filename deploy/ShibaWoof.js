const hre = require("hardhat");

async function main() {
    let shibaWoof;
    try {
        const ShibaWoof = await ethers.getContractFactory("ShibaWoof");
        shibaWoof = await ShibaWoof.deploy();
        console.log("ShibaWoof contract has been successfully deployed to:", shibaWoof.target);
    } catch (error) {
        console.error("Error during deployment:", error);
    }

    console.log("Contract verification is in progress...");
    await new Promise(resolve => setTimeout(resolve, 60000));

    try {
        await hre.run("verify:verify", {
            address: shibaWoof.target,
            constructorArguments: [],
            force: true
        });
        console.log("Contract verified on Etherscan successfully.");
    } catch (error) {
        process.exit(0);
    }
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
