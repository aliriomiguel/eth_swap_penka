const Token = artifacts.require("Token");
const EthSwap = artifacts.require("EthSwap");

module.exports = async function(deployer) {
  //Deploy Token
  await deployer.deploy(Token);
  const token = await Token.deployed();

  //Deploy EthSwap
  await deployer.deploy(EthSwap, token.address);
  const ethSwap = await EthSwap.deployed();

  //Transfer all the tokens to the EthSwap SC. This is 'cause all the
  //tokens are asigned to the first address in our Ganache 
  //(the deployer)
  await token.transfer(ethSwap.address, '1000000000000000000000000');
};
