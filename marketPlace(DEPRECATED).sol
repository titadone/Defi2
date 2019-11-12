pragma solidity ^0.5.11

contract marketPlace{
  mapping(address => User) private users;
  address[] list_ban;
  address owner;

  //mapping(address => string) private username;
  //uint reputation;
  modifier admin(){
    require(msg.sender == owner);
  }

  struct User {
    uint reputation;
    string nom;
  }

  constructor() {
    owner = msg.sender;
  }

  function  inscripton(string memory _nom) public{
      //users[msg.sender];
      //usernames[msg.sender];
      //reputation += 1;
      require(contain(msg.sender) == true, "Vous êtes déjà banni !");
      users[msg.sender].reputation += 1;
      users[msg.sender].nom = _nom;
  }

  function ban(address ban_user) public admin{
    users[ban_user].reputaion = 0;
    list_ban.push[ban_user];
  }

  function contain(address is_ban) public view returns(bool){
      bool find = false;
    for(uint i = 0; i < list_ban.length; i++){
        if(list_ban[i] == is_ban){
            return true;
        }
        return find;
    }
}
