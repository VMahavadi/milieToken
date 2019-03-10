pragma solidity ^0.5.0;
contract milieToken { 
   
string public name; 
string public symbol; 
uint8 public decimals;
uint256 public totalSupply;
 
// Balances for each account
mapping(address => uint256) balances;
address devAddress;
// Events
event Approval(address indexed owner, address indexed spender, uint256 value);
event Transfer(address indexed from, address indexed to, uint256 value);
 
// Owner of account approves the transfer of an amount to another account
mapping(address => mapping (address => uint256)) allowed;
// This is the constructor and automatically runs when the smart contract is uploaded
constructor() public { 
    name = "milieToken"; 
    symbol = "MILIE"; // set the Symbol here
    decimals = 18; // set the number of decimals
    devAddress=0x0000000000000000000000000000000000000000; // Add the address that you will distribute tokens from here
    uint initialBalance=1000000; // 1M tokens
    balances[devAddress]=initialBalance;
    totalSupply+=initialBalance; // Set the total suppy
    balances[msg.sender]= totalSupply;
}
function balanceOf(address owner) public view returns (uint256 balance) {
    return balances[owner];
}
// Transfer the balance from owner's account to another account
function transfer(address to, uint256 amount) public returns (bool success) {
    if (balances[msg.sender] >= amount 
        && amount > 0
        && balances[to] + amount > balances[to]) {
        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount); 
        return true;
    } else {
        return false;
    }
}
function transferFrom(
    address from,
    address to,
    uint256 amount
) public returns (bool success) {
    if (balances[from] >= amount
        && allowed[from][msg.sender] >= amount
        && amount > 0
        && balances[to] + amount > balances[to]) {
        balances[from] -= amount;
        allowed[from][msg.sender] -= amount;
        balances[to] += amount;
        return true;
    } else {
        return false;
    }
}
// Allow spender to withdraw from your account, multiple times, up to the value amount.
// If this function is called again it overwrites the current allowance with value.
function approve(address spender, uint256 amount) public returns (bool success) {
    allowed[msg.sender][spender] = amount;
    emit Approval(msg.sender, spender, amount);
    return true;
}
}