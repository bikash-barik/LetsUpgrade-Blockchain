pragma solidity 0.4.22 <= 0.6.12;

contract RestaurantBill{
    string invoiceNo;
    string customername;
    int number;
    int tableno;
    string servername;
    int amount;
    
    constructor(string invoice , string name , int no , int table , string waiter , int total )public {
        
        invoiceNo = invoice;
        customername = name;
        number = no; 
        tableno = table;
        servername = waiter ;
        amount = total;
        
    }
    function GetInfo()public view returns(string , string , int  , int  , string ,int ){
        return(invoiceNo,customername,number,tableno,servername,amount);
    }
    function SetInfo(int amount1) public {
       amount = amount1;
        
    }
   }
