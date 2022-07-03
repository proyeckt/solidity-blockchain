// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CryptoBank {

    mapping(address => uint) public balances;

    uint public checkCall = 0;
    
    //Solution to Re-entrancy Attack
    bool private locked = false;
    modifier noReentrant(){
        require(!locked,"No re-entrancy allowed");
        locked = true;
        _;
        locked = false;
    }

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public payable noReentrant {

        checkCall = checkCall + 1;

        uint bal = balances[msg.sender];
        require(bal > 0, 'No balance amount');

        //Solution: This line should be before the .call (funds), balance must be updated before
        balances[msg.sender] = 0;

        //check-effect-interaction-pattern
        (bool sent, ) = msg.sender.call{value: bal}("");
        require(sent, "Failed to send Ether");

        //balances[msg.sender] = 0;

    }

    // Helper function to check the balance of this contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

//REFS:
//https://medium.com/returnvalues/smart-contract-security-patterns-79e03b5a1659