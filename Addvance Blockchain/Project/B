pragma solidity >=0.5.13 <0.7.3;

contract Bank{
    address owner;
    string ownername;
    string BankName;
    uint balance ;        // Total Balance of the bank
    int account_no ;
    bool pause;
      
    struct Details {     // struct containing account info
        string  name ;   
        uint AccountBalance;
    }
    
    mapping(address => Details) Account_No;
    mapping(address => uint) AddresstoLoan;        // maps for maintaing ledger
    mapping(address => uint) LoanRepayment;
    mapping(int => address) AccountToAddress;
    mapping(address => bool) AccountActive;
    
    constructor(string memory Ownername , string memory Bankname)public payable{         // Deploying Bank 
        ownername = Ownername ; 
        BankName = Bankname;
        owner = msg.sender;
        require(msg.value >= 50 ether , "You can not Setup Bank Due to Unsufficient Funds");   
        account_no = 100 ;
        AccountToAddress[account_no] = msg.sender;
        Details memory account_no = Details(Ownername,msg.value);
        Account_No[msg.sender] = account_no;
        balance = msg.value;

    }
    function Owner() public view returns(string memory){                                        // To view name of the owner and bank name
         return string(abi.encodePacked( ownername ," is the owner of the bank " , BankName));
    }
    function CreateAccount(string memory Name) public Ispause payable{              // Creating new account 
        if(AccountActive[msg.sender] == false){  // To check if Account is terminated or not
            AccountActive[msg.sender] = true;
        }
        require(Account_No[msg.sender].AccountBalance ==  0 ether  ,"Your Account has already been created");
        require(msg.value >= 5 ether , "You need to pay atleast 5 ether to create account in the bank");
         account_no = account_no + 1;
         AccountToAddress[account_no] = msg.sender;
         uint RemainingMoney = msg.value - 5 ether;
         Details memory account_no = Details(Name,RemainingMoney);
         Account_No[msg.sender] = account_no;
         balance += msg.value;
         AddresstoLoan[msg.sender] = 0 ;
         LoanRepayment[msg.sender] = 0 ;
        
    }
    function Deposit()public Ispause AccountAlive checkexist payable{
        require(msg.value > 0 ether , "You cannot deposit 0 ether");
        balance += msg.value;
        Account_No[msg.sender].AccountBalance = Account_No[msg.sender].AccountBalance + msg.value;
    }
    function BankStatus()public Onlyowner view  returns(string memory , int , uint , bool ) {
        int AccountsCreated = account_no - 100 ;
        
        return("No. of Accounts Created  ----------------- Bank Credit  ----------------------- Bank Holiday",AccountsCreated ,balance/1000000000000000000,pause);
    }
    function Withdraw(uint amount) public Ispause AccountAlive checkexist {
        require(Account_No[msg.sender].AccountBalance >= amount* 1 ether  ,"You do not have that much funds in the account" );
        uint Ineither = amount * 1 ether  ;
        uint Remaining = address(this).balance - Ineither; 
        address payable to = msg.sender;
        to.transfer(address(this).balance - Remaining );
        Account_No[msg.sender].AccountBalance = Account_No[msg.sender].AccountBalance - Ineither ;
       
    }
    function Balance() public view Ispause checkexist AccountAlive returns(uint) {
        return Account_No[msg.sender].AccountBalance / 1 ether  ;
    }
    function Loan(uint loanamount) public Ispause AccountAlive checkexist {
     uint loaninwei = loanamount * 1 ether;
     require(loaninwei < Account_No[msg.sender].AccountBalance / 4 , "You cannot take so much loan" );
     require(loaninwei <= balance , "Too Huge Cash For Bank to Handle");
     require(LoanRepayment[msg.sender] == 0 ether , "Please Repay Your Other loans first before taking another loan");
     address payable to = msg.sender;
     to.transfer(loaninwei);
     AddresstoLoan[msg.sender] =  AddresstoLoan[msg.sender] + loaninwei;
     uint Repay = loaninwei * 4/3;
     LoanRepayment[msg.sender] = Repay;
     balance -= loaninwei;
    }
    
    function CheckLoan() public view LoanCheck  Ispause checkexist AccountAlive returns(uint){
         return LoanRepayment[msg.sender] / 1 ether ;
    }
    
    function LoanRepay() public payable Ispause LoanCheck checkexist AccountAlive{
        require(msg.value > 0 , " Please Provide With Ether to repay loan");
        uint repaymoney = msg.value;
        balance += repaymoney;
        if(msg.value > LoanRepayment[msg.sender] ){
            uint remainingbalance = msg.value - LoanRepayment[msg.sender] ;
            Account_No[msg.sender].AccountBalance = Account_No[msg.sender].AccountBalance + remainingbalance;
            LoanRepayment[msg.sender] = 0;
        }
        else{
            LoanRepayment[msg.sender] = LoanRepayment[msg.sender] - msg.value;
        }
    }
    function CloseAccount() public Ispause checkexist AccountAlive {
        require(LoanRepayment[msg.sender] ==  0, "You have loans to pay");
        uint rem = Account_No[msg.sender].AccountBalance;
        Account_No[msg.sender].AccountBalance = 0 ;
        balance = balance - rem ;
         address payable to = msg.sender;
        to.transfer(address(this).balance - balance );
        AccountActive[msg.sender] = false ;
        
    }
    function CloseBank() public Ispause Onlyowner {
        for(int i = account_no; i > 100 ; i = i - 1){
            address accowner = AccountToAddress[account_no];
            uint remain = Account_No[accowner].AccountBalance;
            balance = balance - remain ; 
            address payable member = payable(accowner);
            member.transfer(address(this).balance - balance );
        }
         address payable to = msg.sender;
        to.transfer(address(this).balance);
        selfdestruct(to);
        
    }
    function DeclareHoliday() public Onlyowner  {
          if(pause  == true){
             pause = false;
         }
         else{
             pause = true;
         }
    }
    modifier  Ispause(){
       require(pause == false , "Bank Holiday ");
        _;
    }
    modifier checkexist(){
        require(Account_No[msg.sender].AccountBalance >= 0 ether  ,"Your Account already exist");
        _;
    }
    modifier LoanCheck(){
        require(LoanRepayment[msg.sender] > 0, "You haven't taken any loan");
        _;
    }
    modifier Onlyowner(){
      require(owner == msg.sender, "Only Owner has access to this");
      _;
    }
    modifier AccountAlive(){
        require(AccountActive[msg.sender] == true , "This Account has been terminated by the Account's owner");
        _;
    }
}
