//SPDX-License-Identifier: MIT 
// Solidity data types 

pragma solidity ^ 0.8.0;

// Creating a contract
contract Types {

	// Initializing Bool variable
	bool public boolean = false;

    // unsigned integers examples 

    uint public uint_var = 8912345;

    uint256 public uint256_var = 123456789;
	
	// Initializing Signed Integer variable
	int32 public int_var = -2256;

	// Initializing String variable
	string public str = "Hello Solidity";

	// Initializing Byte variable
	bytes1 public b = "a";

    bytes2 public c = "cd"; //Saved as Hex value (0x6364)
	
    bytes3 public d = "t";

    bytes public e = "12345";

    //ufixed8x1 public decimal_int = 3.5;

	// Defining an enumerator
	enum my_enum { _start, _middle , _end } //First index is 0, next 1,2,3...

	// Defining a function to return
	// values stored in an enumerator
	function Enum() public pure returns( my_enum ) {
		return my_enum._middle; 
	}
}
