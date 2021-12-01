pragma solidity >=0.7.0 <0.9.0;

contract coin {
    address public minter; 
    mapping(address => uint) public balances;

    event Sent(address from, address to, uint amount);

    //constructor only runs when you deploy the contract.
    constructor(){
        minter = msg.sender;
    }

    //Create new coins : only owner has access to this ability.
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        balances[receiver] += amount; 
    }

    //send X amount of coins to any wallet address.

    error insufficientBalance(uint requested, uint available);

    //sends an existing amount of coins from a caller to an address. 

    function send(address receiver, uint amount) public {
        if(amount > balances[msg.sender])
        revert insufficientBalance({
            requested: amount,
            available: balances[msg.sender]
        });
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }

}