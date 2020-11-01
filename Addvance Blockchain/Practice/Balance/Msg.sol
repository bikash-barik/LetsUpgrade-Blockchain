pragma solidity >=0.4.22 < 0.7.0;

contract Msg{
    
    address public Myadd;
    uint256 public Balance ;
    
    constructor()public{
        Myadd = msg.sender;
    }
    function ReceiveBal()public payable{
        Balance += msg.value; 
        
    }
    function WithdrawBal() public{
        address payable to = msg.sender;
        to.transfer(address(this).balance);
    }
    function SendToaddress(address payable Adre) public{
        Adre.transfer(address(this).balance);
    } 
    function CurrentEither() public view returns (uint256){
        return address(this).balance;
    
    
    
}
}
