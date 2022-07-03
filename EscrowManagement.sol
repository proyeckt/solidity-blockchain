// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Owner {

    address private owner;
    
    // event for EVM logging
    event OwnerSet(address indexed oldOwner, address indexed newOwner);
    
    // modifier to check if caller is owner
    modifier isOwner() {
        // If the first argument of 'require' evaluates to 'false', execution terminates and all
        // changes to the state and to Ether balances are reverted.
        // This used to consume all gas in old EVM versions, but not anymore.
        // It is often a good idea to use 'require' to check if functions are called correctly.
        // As a second argument, you can also provide an explanation about what went wrong.
        require(msg.sender == owner, "Caller is not owner");
        _; // When it's called, executes the function that extends from modifier, in this case changeOwner
    }
    
    /**
     * @dev Set contract deployer as owner
     */
    constructor() {
        owner = msg.sender; // 'msg.sender' is sender of current call, contract deployer for a constructor
        emit OwnerSet(address(0), owner);
    }

    /**
     * @dev Change owner
     * @param newOwner address of new owner
     */
    function changeOwner(address newOwner) public isOwner {
        emit OwnerSet(owner, newOwner);
        owner = newOwner;
    }

    /**
     * @dev Return owner address 
     * @return address of owner
     */
    function getOwner() external view returns (address) {
        return owner;
    }
}




contract MyEscrow is Owner {
  
    event Deposited(address indexed payee, uint256 weiAmount);
    event Withdrawn(address indexed payee, uint256 weiAmount);

    mapping(address => uint256) private _deposits;

    function depositsOf(address payee) public view returns (uint256) {
        return _deposits[payee];
    }
   
    function deposit(address payee) public payable  {
        uint256 amount = msg.value;
        _deposits[payee] += amount;
        emit Deposited(payee, amount);
    }

    
    function withdraw(address payable payee) public payable virtual {

        uint256 payment = _deposits[payee];
        _deposits[payee] = 0;

         require(address(this).balance >= payment, "Escrow: insufficient balance");
         (bool success,) = payee.call{ value: payment }(""); 
         require(success, 'Escrow: payment not successful' );
         
        emit Withdrawn(payee, payment);
    }

    function checkEscrowBal() public view returns( uint ) {

        return address(this).balance; 
    }
}





contract myEscroMgt is Owner, MyEscrow {

    address public contractEscoMgt; 
    address public buyer;
    address public seller; 

    uint public productPrice; 

    bool public buyerDeposited;
    bool public sellerDeposited;

    bool public productShipped;
    bool public productReceived; 

    bool public buyerPaidProduct; 

    event ProductShipped( address indexed seller, bool status);
    event ProductReceived( address indexed buyer, bool status ); 

    event ProductPaid( address indexed buyer, address indexed seller, uint amount); 

    constructor (address _buyer, address _seller, uint _amount ) {
        contractEscoMgt = msg.sender; 
        buyer = _buyer;
        seller = _seller;
        productPrice = _amount * 10 ** 18; 
        productShipped = false;
        productReceived = false;
        buyerPaidProduct = false; 
        buyerDeposited = false;
        sellerDeposited = false;
    }

    function buyerDeposit() public payable {

        require( msg.sender == buyer, 'Only Buyer can deposit');

        require( msg.value > 0, 'must have value');

        super.deposit( msg.sender );
        buyerDeposited = true; 

    }

    function sellerDeposit() public payable {

        require( msg.sender == seller, 'Only Seller can deposit');

         require( msg.value > 0, 'must have value');

        super.deposit( msg.sender ); 
        sellerDeposited = true; 

    }

    function sellerShippedProduct() public {

        require( msg.sender == seller, 'Only Seller can set');
       
        productShipped = true;

        emit ProductShipped( seller, true  ); 

    }

    function buyerReceiveProduct() public {

        require( msg.sender == buyer, 'Only Buyer can set');

        require( productShipped, 'Seller had not shipped'); 

        productReceived = true;

        emit ProductReceived( buyer, true  ); 

    }


    function buyerPayProduct() public payable {

        require( msg.sender == buyer, 'Only Buyer can make payment');

         require( msg.value >= productPrice, "Insufficient buyer value");
         
         (bool success,) =  seller.call{ value: productPrice }(""); 
         require(success, 'Product payment to Seller failed' );

         buyerPaidProduct = true; 
         
        emit ProductPaid( buyer, seller, productPrice ); 

    }

    

    function withdrawalAllowed() public view returns (bool) {

        require( productShipped, 'Seller had not shipped product' );
        require( productReceived, 'Buyer had not received product' );
        require( buyerPaidProduct, 'Buyer had not paid product'); 

        return true;
    }

    function withdraw(address payable payee) public payable override {

        require(withdrawalAllowed(), "ConditionalEscrow: payee is not allowed to withdraw");
      
        super.withdraw(payee);
    }

}


