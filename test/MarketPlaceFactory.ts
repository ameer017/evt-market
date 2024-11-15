import { expect } from "chai";
import hre from "hardhat";
import { ethers } from "hardhat";
import { loadFixture } from "@nomicfoundation/hardhat-toolbox/network-helpers";

describe("MarketplaceFactory", function () {
  const contractFixture = async () => {
    const [owner, address1] = await hre.ethers.getSigners();

    const MarketPlace = await hre.ethers.getContractFactory("MarketPlace");
    const marketPlace = await MarketPlace.deploy();

    return { marketPlace, owner, address1 };
  };

  describe("Marketplace", function () {
    it("deploys a new listing contract", async () => {
      const { marketPlace, owner, address1 } = await loadFixture(
        contractFixture
      );


      const tx = await marketPlace.deployListingContract();
      await tx.wait();

    });

    it("verifies user listings", async () => {

      const { marketPlace, owner } = await loadFixture(
        contractFixture
      );


      await marketPlace.deployListingContract();
      const listingContracts = await marketPlace.getListingContracts(owner.address);
      expect(listingContracts).to.have.lengthOf(1);
    });

    it("verifies correct contract records in the Marketplace", async () => {
      const { marketPlace, owner } = await loadFixture(
        contractFixture
      );


      await marketPlace.deployListingContract();
      const allContracts = await marketPlace.getListingContracts(owner.address);
      expect(allContracts).to.have.lengthOf(1);
    });


  });
})

