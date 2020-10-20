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
    const mockSpvAddr = '0x86F401fD9c55bD919f0b5D9e908B9DEE4e006D31'

    // We get the contract to deploy
    const mockSpv = await ethers.getContractAt('MockCKBSpv', mockSpvAddr)
    const res = await mockSpv.proveTxExist([0, 0, 0], 11)
    console.log(res)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });
