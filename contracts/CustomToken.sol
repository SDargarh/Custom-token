// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract CustomToken is ERC20{
    
    address public owner;
    mapping(address => bool) public blackList;
    
    constructor() ERC20("CustomToken", "CT") {
        owner = msg.sender;
        //creating 100 tokens with 18 decimals
        _mint(msg.sender, 100 * (10**uint256(decimals())));
    }
    
    modifier ownable() {
        require(msg.sender == owner, "you are not authorised to make this call");
        _;
    }
    
    modifier checkBlockList() {
        require(!blackList[msg.sender], "you are blocked, not authorised to make this call");
        _;
    }
    
    function updateBlockList(address user, bool action) public ownable {
        blackList[user] = action;
    }
    
    function special_transfer(address recipient, uint256 amount) public checkBlockList {
        //giving bonus token for users who call this function and not blocked making it a special function
        uint bonus = 100000;
        transfer(recipient, amount + bonus);
    }
    
    function transfer(address recipient, uint256 amount) override public checkBlockList returns(bool) {
        return super.transfer(recipient, amount);
    }
    
    function transferFrom(address sender, address recipient, uint256 amount) override public checkBlockList returns(bool) {
        return super.transferFrom(sender, recipient, amount);   
    }
}