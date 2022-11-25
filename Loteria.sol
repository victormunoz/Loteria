// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Loteria {
    //manager is in charge of the contract 
    address public manager;

    //new player in the contract using array[] to unlimit number 
    address[] public participants;

    constructor() {
        manager = msg.sender;
    }

    function participar() public payable{
        require(msg.value > .001 ether);
        participants.push(msg.sender);
    }

    function random() private view returns(uint){
        return uint (keccak256(abi.encode(block.timestamp, participants)));
    }

    function sorteig() public restricted{
        uint guanyador = random() % participants.length;

        payable (participants[guanyador]).transfer(address(this).balance);

        participants = new address[](0);
    }

    modifier restricted(){
        require(msg.sender == manager);
        _;
    }
}
