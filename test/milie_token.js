var Token = artifacts.require ("milieToken");

contract('milieToken', function(accounts) {
  it("should assert true", function() {
    var token;
    return Token.deployed().then(function(instance){
     token = instance;
     return token.totalSupply.call();
    }).then(function(result){
     assert.equal(result, 1000000, 'total supply is wrong');
    })
  });

  it("should return the balance of account 0", function() {
    var token;
    return Token.deployed().then(function(instance){
      token = instance;
      return token.balanceOf.call(accounts[0]);
    }).then(function(result){
      assert.equal(result.toNumber(), 0, 'balance is wrong');
    })
  });
  
  it ("testing transfer tokens from address_0 to address_1", function() {
    var token;
    return Token.deployed().then(function(instance) {
      token = instance;
      return token.transfer(accounts[1], 500000);
    }).then (function() {
      return token.balanceOf.call(accounts[0]);
    }).then (function(result) {
      assert.equal(result, 500000, "balance of account[0] is wrong");
      return token.balanceOf.call(accounts[1]);
    }).then (function(result) {
      assert.equal(result, 500000, "balance of account[1] is wrong");
    })
  });
});