// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Payable2 {
    // Payable address can receive Ether
    address payable public owner;

    event Withdrawal( address indexed _to, address indexed _contract, uint256 _amount);
    event Transfer( address indexed _from, address indexed _to, uint256 _amount); 
    // Payable constructor can receive Ether
    constructor() payable {
        owner = payable(msg.sender);
    }

    // Function to deposit Ether into this contract.
    // Call this function along with some Ether.
    // The balance of this contract will be automatically updated.
    function deposit() public payable {}

    // Call this function along with some Ether.
    // The function will throw an error since this function is not payable.
    function notPayable() public {}

    // Function to withdraw all Ether from this contract.
    function withdraw() public  payable {
        // get the amount of Ether stored in this contract

        require( msg.sender == owner, 'only owner can withdraw');
        uint amount = address(this).balance;

        // send all Ether to owner
        // Owner can receive Ether since the address of owner is payable
        (bool success, ) = owner.call{value: amount}("");
        require(success, "Failed to send Ether");
        emit Withdrawal( msg.sender, address(this), amount ); 
    }

    // Function to transfer Ether from this contract to address from input
    function transfer(address payable _to, uint _amount) public payable {
        // Note that "to" is declared as payable
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Failed to send Ether");
        emit Transfer( msg.sender, _to,  _amount  ); 
    }
    function showBal() public view returns(uint) { 
        return address(this).balance;
     }

}
