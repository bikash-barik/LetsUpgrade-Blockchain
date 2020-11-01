pragma solidity >= 0.5.13 < 0.7.3;

contract LotterySystem{
    address public owner ;
    uint number; 
    bool pause = false ;
    mapping(uint => address)  AddressofLotteryParticipants;
    mapping(address => uint)  NoofEther; 
    
    
constructor() public {
        owner = msg.sender; 
        number = 0; 
    }
    
    function BuyTickets()public Ispause One payable {
        require(msg.value >= 1 ether, "You require atleast 1 ether to participate in the lottery");
        number = number + 1 ; 
        AddressofLotteryParticipants[number] = msg.sender;
        NoofEther[msg.sender] = msg.value; 
    }
    function ChooseWinner() public Ispause OnlyOwner {
        uint No = Random();
        while(No == 0){
          No = Random();
         }
         address to = AddressofLotteryParticipants[No];
         address payable winner = payable(to);
         winner.transfer(address(this).balance);
         
        }
    function Random() public OnlyOwner Ispause returns (uint) {
     uint Winner = uint(keccak256(abi.encodePacked(now,block.difficulty,msg.sender)))% (number + 1 );
        return Winner;
    }
    function Pause()public OnlyOwner {
        if(pause == false){
           pause = true; 
        }
        else{
            pause = false;
        }
    }
    function Destroy()public OnlyOwner Ispause (){
     address payable to  = msg.sender;
     selfdestruct(to);
    }
    function Reset() public OnlyOwner Ispause {
        // uint participate = number - 100 ;
         
            while(number > 100){
                NoofEther[AddressofLotteryParticipants[number]] = 0 ether ;
                number = number - 1;
        }
        
        
 }
     
    
    modifier OnlyOwner() {
        require(msg.sender == owner, "Only The Owner has access to this function") ;
        _;
    }
    modifier Ispause(){
        require(pause == false , "contract on pause by the owner");
        _;
    }
    modifier One(){
        require(NoofEther[msg.sender] < 1 ether , "Already Enrolled in the lottery");
        _;
    }
    
 }
