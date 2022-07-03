//SPDX-License-Identifier: MIT 
// Solidity data types 

// Solidity program to demonstrate
// Reference Types
pragma solidity ^0.8.0;

// Creating a contract
contract ReferenceType {

    address public owner;

	// Defining an array
	uint[5] public array
	= [uint(1), 2, 3, 4, 5] ; //Casting first element to int
	
	// Defining a Structure
	struct student {
		string name;
		string subject;
		uint8 marks;
	}

	// Creating a structure object
	student public std1;

    constructor() { owner = msg.sender;  } 

	// Defining a function to return
	// values of the elements of the structure
	function structure() public returns(
	string memory, string memory, uint){
		std1.name = "John";
		std1.subject = "Chemistry";
		std1.marks = 88;
		return (
		std1.name, std1.subject, std1.marks);
	}
	
	// Creating a mapping
	mapping (address => student) public result;
	address[] public student_result;

    function record( student memory _student, address addStudent   ) public {
        /*
        Input in IDE field _stundent: ["Jack","Science",98] addStudent: address another user
        */
        require( msg.sender == owner, 'only Admin'); 
    
        result[  addStudent ] = _student;
        student_result.push( addStudent );
    }
}
