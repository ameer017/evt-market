// script/DeployMarketplace.ts
import hre from "hardhat";

async function main() {
    const MarketPlace = await hre.ethers.getContractFactory("MarketPlace");
    const marketPlace = await MarketPlace.deploy();
    console.log("Marketplace deployed to:", marketPlace.target);

    const tx = await marketPlace.deployListingContract();
    await tx.wait();
    console.log("Listing contract created");

}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });