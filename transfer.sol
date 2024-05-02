pragma solidity ^0.4.18;
contract propertyTransfer {
    address public DA;
    uint256 public totalNoProperty;
    function PropertyTransfer() public{
        DA=msg.sender;
    }
    modifier onlyOwner(){
        require(msg.sender==DA);
        _;}
        struct Property {
            string name;
            bool isSold;
        }
        mapping(address=> mapping(uint256 =>Property)) public propertiesOwner;
        mapping(address =>uint256)individualCountOfPropertyPerOwner;

        event PropertyAllotted(address indexed _verifiedOwner, uint256 indexed totalNoOpropertyCurrently, string _nameOfProperty, string _msg);
        event PropertyTransferred(address indexed _from, address indexed _to, string _proepertyName, string _msg );
        function getpropertyCountOfAnyAddress(address _ownerAddress)public constant returns (uint256){
            uint count=0;
            for(uint i=0;i<individualCountOfPropertyPerOwner[_ownerAddress];i++){
              if(propertiesOwner[_ownerAddress][i].isSold==true)
              count++;  
            }
            return count;
        }
        function alotProperty(address _verifiedOwner, string _propertyname) public onlyOwner
        {
          propertiesOwner[_verifiedOwner][individualCountOfPropertyPerOwner[_verifiedOwner]].name = _propertyname;
            totalNoProperty++;
            PropertyAllotted(_verifiedOwner,individualCountOfPropertyPerOwner[_verifiedOwner], _propertyname, "property allotted successfully");
        }
        function isOwner(address _checkOwnerAddress, string _propertyName) public view returns (uint){
            uint i;
            bool flag;
            for(i=0;i<individualCountOfPropertyPerOwner[_checkOwnerAddress];i++)
            {
                if(propertiesOwner[_checkOwnerAddress][i].isSold==true){
                    break;
                }
                flag=stringsEqual(propertiesOwner[_checkOwnerAddress][i].name,_propertyName);
                if(flag==true){
                    break;

                }
            }
                if(flag==true){
                    return i;
                }
                else{
                    return 999999999;
                }
            }
            function stringsEqual (string a1, string a2) internal pure returns (bool){
                return keccak256(a1) ==keccak256(a2);
            }
            function transferProperty(address _to, string _propertyName) internal
            returns (bool, uint)
            {
               uint256 checkOwner = isOwner(msg.sender, _propertyName); 
               bool flag;
               if(checkOwner!=99999999 && propertiesOwner[msg.sender][checkOwner].isSold == false){
                propertiesOwner[msg.sender][checkOwner];
                propertiesOwner[msg.sender][checkOwner];
                propertiesOwner[_to][individualCountOfPropertyPerOwner[_to]++].name= _propertyName;
                flag = true;
                PropertyTransferred(msg.sender , _to, _propertyName, "Owner has been changed.");
               }
            
            else{
                flag=false;
                PropertyTransferred(msg.sender , _to, _propertyName, "Owner doesnt own the property.");}
           return (flag, checkOwner);
            }
            }
