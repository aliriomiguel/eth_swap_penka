// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "./Token.sol";

contract EthSwap {
    string public name = "EthSwap Instant Exchange";
    Token public token;
    uint public rate = 100;

    event TokensPurchased(
        address account,
        address token,
        uint amount,
        uint rate
    );

    event TokensSold(
        address account,
        address token,
        uint amount,
        uint rate
    );

    constructor(Token _token) public {
        token = _token; //we do this in order to get the local value stored into the blockchain
    }
    
    function buyTokens() public payable {
        //Calculate the number of tokens to buy
        uint tokenAmount = msg.value * rate;
        //check if the ethSwap has the amount of tokens
        //we use require to check this
        require(token.balanceOf(address(this)) >= tokenAmount);

        //transfer tokens to the user
        token.transfer(msg.sender, tokenAmount);
    
        //emit an event
        emit TokensPurchased(msg.sender, address(token), tokenAmount, rate);
    }
    
    function sellTokens (uint _amount) public {
        //user cant sell more tokens than they have
        require(token.balanceOf(msg.sender) >= _amount);

        //calculate the amount of ether to redeem
        uint etherAmount = _amount / rate;

        //require that the app has enough ether
        require(address(this).balance >= etherAmount);
        //perform sale
        token.transferFrom(msg.sender, address(this), _amount);
        payable(msg.sender).transfer(etherAmount);

        emit TokensSold(msg.sender, address(token), _amount, rate);
    }

}

