pragma solidity 0.4.22 <= 0.6.12;

contract Employee{
    
    string employid;
    string name ;
    int phoneno;
    string add;
    string position;
    int salary;
    
    
    constructor(string id , string nam , int phone , string ad , string post , int income) public {
        
        employid = id;
        name = nam;
        phoneno = phone;
        add = ad;
        position = post;
        salary = income ;
     }
    
    
    function GetInfo()public view returns(string , string , int  , string , string ,int ){
        return(employid , name,phoneno,add , position , salary);
      }
    
    
    function SetInfo(int phone , string ad ,string pos , int income ) public {
        phoneno = phone;
        add = ad ;
        position = pos ;
        salary = income;
     }    
    
  }
