//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VendingMachine{

    //Declare state variables of the contract
    address public owner;
    //How many drinks are in your balance, how many drinks has that address it's stored in a table
    mapping(address => uint ) public drinks;
    uint public drinkBal; //Drink balance

    //When 'VendingMachine' contract is deployed:
    // 1. Set the deploying address as the owner of the contract
    // 2. Set the deployed smart contract's Drinks balance to 100
    constructor(){
        owner = msg.sender;
        drinks[address(this)] = 100;
        drinkBal = 100;
    }

     //Allow the owner to increase the smart contract's drink balance
    function topUp(uint amount) public {
        require(msg.sender == owner, "Only the owner can refill.");
        drinks[address(this)] += amount;
        drinkBal += amount;
    }

    //Allow anyone to buy drink
    function buyDrink(uint amount) public payable{
        require(msg.value >= amount * 1 ether, "You must pay at least 1ETH per drink");
        require (drinks[address(this)] >= amount, "Not enough drinks in stock to complete this purchase");
        drinks[address(this)] -=amount;
        drinks[msg.sender] += amount;
        drinkBal -= amount;
    }

    //Allow anyone to buy drink
    function giveDrink() public {
        require(drinks[msg.sender] >=1,"You have no more drinks");
        drinks[msg.sender] -=1;
        drinkBal -=1; 
    }

    function machineBal() public view returns (uint256){
        require(msg.sender == owner,"Only owner can check balance");
        return address(this).balance;
    }
}