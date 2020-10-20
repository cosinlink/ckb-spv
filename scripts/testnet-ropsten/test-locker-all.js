// We require the Buidler Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
// When running the script with `buidler run <script>` you'll find the Buidler
// Runtime Environment's members available in the global scope.
const bre = require("@nomiclabs/buidler");

async function main() {
    // Buidler always runs the compile task when running scripts through it.
    // If this runs in a standalone fashion you may want to call compile manually
    // to make sure everything is compiled
    // await bre.run('compile');

    // mock spv
    const mockSpvAddr = '0x86F401fD9c55bD919f0b5D9e908B9DEE4e006D31';

    // We get the contract to deploy
    const TokenLocker = await ethers.getContractFactory("TokenLocker");
    const locker = await TokenLocker.deploy(mockSpvAddr, 20);
    await locker.deployed();
    console.log("locker deployed to:", locker.address);

    // lockETH 1.34
    let amount = ethers.utils.parseEther("0.34");
    let res = await locker.lockETH(amount, "000111 for lockETH test", {value: amount})
    console.log("lockETH res: ", res)

    // unlockETH
    res = await locker.unlockToken([0,0,0,1,1,1])
    console.log("unlockETH res: ", res)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });
