pragma solidity >=0.4.22 < 0.7.0;

contract Charity{
 address public  Owner;
 bool public ispause;
 
 constructor() public{
        Owner = msg.sender;
 }    
 function SendMoney() public payable{
     
 }  
 function ReceiveMoney() public{
     require(Owner == msg.sender,"You cannot Withdraw Money from this account");
     require(!ispause,"Contract on PAUSE BY OWNER ");
     address payable to = msg.sender;
     to.transfer(address(this).balance);
     
 }
 function Pause(bool _ispause) public{
     require(Owner == msg.sender,"You do not have access to this feature");
     ispause = _ispause;
 }
 function setNewOwner(address newowner) public{
     require(Owner == msg.sender,"You do not have access to this feature");
     require(!ispause,"Contract on PAUSE BY OWNER ");
     Owner = newowner ; 
 }
 function Terminate()public{
     require(Owner == msg.sender,"You do not have access to this feature");
     require(!ispause,"Contract on PAUSE BY OWNER ");
     address payable to  = msg.sender;
     selfdestruct(to);
 }
    
}
