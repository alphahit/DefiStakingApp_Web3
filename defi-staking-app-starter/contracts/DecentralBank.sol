
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
//This is a decentral bank which will be taking both our reward tokens and our tether tokens and interacting
//Digital Bank functionality for our users, our customers, our investors
//Inside our digital bank we want to have access to the tether tokens, and we bascially want to
//be able to keep track of these and then be able to issue tokens, reward tokens and keep track of the state,
//take the deposits, be able tyo accept deposits and withdrawls

import './RWD.sol';
import './Tether.sol';


contract DecentralBank {
    string public name = "Decentral Bank";
    address public owner;
    Tether public tether;
    RWD public rwd;

    //array of address opf stakers
    address[] public stakers;


    //key Store value setup for address
    mapping (address => uint) public stakingBalance;
    mapping (address => bool) public hasStaked;
    mapping (address => bool) public isStaking;
  
    constructor(RWD _rwd, Tether _tether) public{
        rwd = _rwd;
        tether = _tether;
    }//We are doing this because it is important to wire the smart contracts with each other


    //This is a staking function 
    function depositTokens(uint _amount) public {
        
        //Require staking amount to be greater than 0
        require(_amount> 0, 'amount cannot be 0');
        //Transfer tether tokens to this contract address for staking
        tether.transferFrom(msg.sender, address(this), _amount);

        //Update and keep track of staking balance as they change
        stakingBalance[msg.sender] = stakingBalance[msg.sender] + _amount;

        if(!hasStaked[msg.sender]){
            stakers.push(msg.sender);
        }

        //Update Staking balance
        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;
    }
//Now to check if they have staked or staking 
}