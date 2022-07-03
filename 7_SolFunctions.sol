/*
Modifiers of a function
- Pure: Disallows modifications or access of state
- View: Disallows modifications of state
- Payable: Allows them to receive Ether together with a call
- Virtual: Allows the function's or modifier's behaviour to 
  be changed in derived contracts (inheritance). 
  Allows to override the function
- Override: States that this function, modifier or public state variable
  changes the behaviour of a function or modifier in a base contract.
*/


/*
Function Modifiers
- modifier: Can be used to change the behaviour of functions in a declarative way, 
for example, adding a require to use that function
- constant: For state variables, disallows assignment (except initialisation),
  doesn't occupy storage slot.
- inmutable: For state variables, allows exactly one assignment at construction
  time and is constant afterwards
- anonymous: For states, does not store event signatures as topic.
- Indexed: For event parameters: Stores the parameter as topic, works as ids
*/

/*
Event is an inheritable member of a contract. When an event is emitted, 
it stores the arguments passed in transaction logs.
These logs are stored on blockchain and are accessible using address of the
contract till the contract is present on the blockchain.
An event generated is not accessible from within contracts, not even the 
one which have created and emitted them.
*/

/*
Error Hanling
Assert
In case condition is not met, this method call causes an invalid opcode and
any changes done to state got reverted. This method is to be for internal errors.
assert(bool condition)
Require
In case condition is not met, this method reverts to original state. This 
method is to be used for errors in inputs or external components. It provides
an option to provied custom messages.
require(bool condition, optional string  memory message)
Revert
This method abort the execution and revert any changes done to the state. It 
provides an option to provied custom messages.
revert(optional string memory reason)
*/

/*
Inheritance
Solidity supports multiple inheritance. Contracts can inherit other contract
by using the is keyword. 
Function that is going to be overridden by a child contract must be declared
as virtual.
Function that is going to override a parent function must use the keyword override.
Order of inheritance is important.

*/

/*
How to send Ether? You can send Ether to other contracts by:
- transfer (2300 gas, throws error)
- send (2300 gas, returns bool)
- call (forward all gas or set gas, returns bool)

call is more recommended because you need to specify who are you sending to, and
you need to be sign-up, like some kind of validation of the action 

How to receive Ether? A contract receiving Ether must have at least one of
the functions below:
- receive() external payable
- fallback() external payable

It's more recommenede to use receive() is called if msg.data is empty, otherwise fallback() is called.

//External to send money to other person, and not to yourself

/*
Extensibility is key when it comes to building larger, more complex
distributed applications (dapps). Solidity offers two ways to facilitate 
this in your dapps: abstract contracts and interfaces.

Abstract
Contracts need to be marked as abstract when at least one of their functions 
is not implemented. Contracts may be marked as abstract even though
all functions are implemented. Works like a template. It's different from
inheritance of another contract, and is used when it's required to extend.

Interfaces are similar to abstract contracts, but they cannot have
any functions implemented. There are further restrictions:
- They cannot inherit from other contracts, but they can inherit
from other interfaces.
- All declared functions must be external.
- They cannot declare a constructor.
- They cannot declare state variables.
- They cannot declare modifiers.

Some of these restrictions might be lifted in the future.

// Inheritance must be ordered from “most base-like” to “most derived” in the tree.
// Swapping the order of A and B will throw a compilation error.

// Contracts can inherit from multiple parent contracts.
// When a function is called that is defined multiple times in
// different contracts, parent contracts are searched from
// right to left, and in depth-first manner.

*/