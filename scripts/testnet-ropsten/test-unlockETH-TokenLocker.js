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

    const [owner, addr] = await ethers.getSigners();
    // console.log(owner, addr)


    // mock spv chain
    const mockSpvAddr = '0x86F401fD9c55bD919f0b5D9e908B9DEE4e006D31';

    // deployed tokenLocker
    // const tokenLockerAddr = '0xC68EC73241815beF23Bd90A873041102BED646e7';
    const tokenLockerAddr = '0x7F840C9A263bf71e7A83088c51e448160C4fe08D';

    // get contract
    const tokenLocker = await ethers.getContractAt('TokenLocker' ,tokenLockerAddr)

    console.log(await tokenLocker.unlockToken([0,0,0]));
    // const result = await tokenLocker.lockETH(amount, "ckbaddr001");
    // console.log("lockETH result", result);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });
