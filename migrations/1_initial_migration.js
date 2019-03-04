const Migrations = artifacts.require("milieToken.sol");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
};
