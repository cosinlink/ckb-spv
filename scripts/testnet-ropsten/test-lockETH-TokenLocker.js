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

    // deployed tokenLocker
    const tokenLockerAddr = '0xC68EC73241815beF23Bd90A873041102BED646e7';

    // get contract
    let amount = ethers.utils.parseEther("1.3333");
    const tokenLocker = await ethers.getContractAt('TokenLocker', tokenLockerAddr)
    const res = await tokenLocker.lockETH(amount, 'TokenLocker', {value: amount})
    console.log(res);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });
