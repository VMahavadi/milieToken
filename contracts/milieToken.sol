pragma solidity ^0.5.0;
contract milieToken { 
   
string public name; 
string public symbol; 
uint8 public decimals;
uint256 public totalSupply;
 
// Events
event Approval(address indexed owner, address indexed spender, uint256 value);
event Transfer(address indexed from, address indexed to, uint256 value);
 
// Balances for each account
mapping(address => uint256) balances;

// Owner of account approves the transfer of an amount to another account
mapping(address => mapping (address => uint256)) allowed;
// This is the constructor and automatically runs when the smart contract is uploaded

constructor() public { 
    name = "milieToken"; 
    symbol = "MILIE"; // set the Symbol here
    decimals = 18; // set the number of decimals
    uint initialBalance=1000000; // 1M tokens
    totalSupply+=initialBalance; // Set the total suppy
    balances[msg.sender]= totalSupply;
}



function balanceOf(address owner) public view returns (uint256 balance) {
    return balances[owner];
}
// Transfer the balance from owner's account to another account
function transfer(address receiver, uint numTokens) public returns (bool) {
    require (numTokens <= balances[msg.sender]);
    balances[msg.sender] -= numTokens;
    balances[receiver] += numTokens;
    emit Transfer(msg.sender, receiver, numTokens);
    return true;
}
function transferFrom(address from, address to, uint256 numTokens) public returns (bool success) {
    require (numTokens <= balances[from]);
    require (numTokens <= allowed[from][msg.sender]);
    balances[from] -= numTokens;
    balances[to] += numTokens;
    allowed[from][msg.sender] -= numTokens;
    emit Transfer(from, to, numTokens);
    return true;
}
// Allow spender to withdraw from your account, multiple times, up to the value amount.
// If this function is called again it overwrites the current allowance with value.
function approve(address spender, uint256 amount) public returns (bool success) {
    allowed[msg.sender][spender] = amount;
    emit Approval(msg.sender, spender, amount);
    return true;
}
function allowance(address owner,
                  address delegate) public view returns (uint) {
  return allowed[owner][delegate];
}
}