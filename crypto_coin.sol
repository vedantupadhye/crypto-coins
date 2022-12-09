// SPDX-License-Identifier: GPL-3.05

pragma solidity >=0.7.0 <0.9.0;

contract coin{
    address public minter;
    mapping(address=>uint)public balances;

    event Sent(address from , address to, uint amount);

    constructor(){
        minter=msg.sender;
    }

    // this function sends the amount of newly created coins to reciever address
    // which can be created by minter (owner) only

    function mint (address reciever , uint amount) public{
        require(msg.sender == minter);
        balances[reciever] += amount;
    }
    

    // errors gives the info about why an operation failed

    error InsufficientBalance(uint requested , uint available);

    // this function sends the coins to other person once the coins are created by owner
    function send(address reciever , uint amount)public{
        // if the balance of the person transferring the coins is less than the amount he has put then transaction will not be done

        if(amount > balances[msg.sender])

        // revert stops the process of transaction 

            revert InsufficientBalance({
                requested:amount,
                available: balances[msg.sender]
            });

        balances[msg.sender] -= amount;
        balances[reciever] += amount;

        emit Sent(msg.sender , reciever , amount);
    }
}