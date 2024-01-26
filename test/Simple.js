// Simple.js
const { expect } = require("chai");

describe("Simple", function () {
    let Simple;
    let simple;
    let owner;
    let addr1;
    let addrs;

    beforeEach(async function () {
        [owner, addr1, ...addrs] = await ethers.getSigners();

        Simple = await ethers.getContractFactory("Simple");
        simple = await Simple.connect(owner).deploy();
    });

    it("Should have correct name and symbol", async function () {
        expect(await simple.name()).to.equal("Simple");
        expect(await simple.symbol()).to.equal("MTK");
    });

    it("Should assign the initial supply to the owner", async function () {
        const ownerBalance = await simple.balanceOf(owner.address);
        expect(ownerBalance).to.equal(BigInt(1000000) * BigInt(10 ** 18));
    });

    it("Should transfer tokens between accounts", async function () {
        await simple.connect(owner).transfer(addr1.address, 1000);
        const addr1Balance = await simple.balanceOf(addr1.address);
        expect(addr1Balance).to.equal(1000);
    });

    // it("Should fail if trying to transfer more than the balance", async function () {
    //     await expect(Simple.connect(owner).transfer(addr1.address, BigInt(100000000)))
    //         .to.be.revertedWith("ERC20: transfer amount exceeds balance");
    // });
});
