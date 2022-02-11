// SPDX-License-Identifier: MIT

pragma solidity >= 0.7.0 < 0.9.0;

contract building_a_bank{
    uint totalContractBalance = 0;

    function getContractBalance() public view returns(uint) {
        return totalContractBalance;
    }

    mapping(address => uint) balance;
    mapping(address => uint) depositTimestamp;

    function addBalance() public payable {
        balance[msg.sender] = msg.value;
        totalContractBalance = totalContractBalance + msg.value ;
        depositTimestamp[msg.sender] = block.timestamp; // block.timestamp is uint 
    }

    function getBalance(address userAddress) public view returns(uint){
        uint principal = balance[userAddress];
        uint timeElapsed = block.timestamp - depositTimestamp[userAddress]; // in seconds
        return principal + uint((principal * timeElapsed * 7)/ (100*365*24*60*60)) + 1;
    }

    function withdraw() public payable {
        // receiver 
        address payable withdrawTo = payable(msg.sender);
        // amount
        uint amountToTransfer = getBalance(msg.sender);
        // transfer
        withdrawTo.transfer(amountToTransfer);
        totalContractBalance = totalContractBalance - amountToTransfer;
        balance[msg.sender] = 0;
    }

    function addMoneyToContract() public payable{
        totalContractBalance += msg.value;
    }
}
