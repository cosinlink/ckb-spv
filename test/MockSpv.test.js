const { expect } = require("chai");

describe("ProveTxExist", function() {
    it("Should return the new greeting once it's changed", async function() {
        const factory = await ethers.getContractFactory("MockCKBSpv");
        const mockSpv = await factory.deploy();

        await mockSpv.deployed();
        expect(await mockSpv.proveTxExist([0], 0)).to.equal(true);
    });
});