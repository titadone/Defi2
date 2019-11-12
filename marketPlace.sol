pragma solidity ^0.5.11

contract marketPlace{
  mapping(address => User) private users;
  mapping(address => bool) list_ban;
  address owner;

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
      require(list_ban[msg.sender] == true, "Vous êtes déjà banni !");
      users[msg.sender].reputation += 1;
      users[msg.sender].nom = _nom;
  }

  function ban(address ban_user) public admin{
    users[ban_user].reputaion = 0;
    list_ban[ban_user] = true;
  }


}
