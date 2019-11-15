pragma solidity ^0.5.11;

contract marketPlace{
  mapping(address => User) private users;
  mapping(address => bool) list_ban;
  mapping(address => Demande) candidats;
  Demande[] list_demande;
  address owner;

  modifier admin(){
    require(msg.sender == owner);
  }

  struct User {
    uint reputation;
    string nom;
  }

  enum etatDemande {OUVERTE, EN COURS, FERMEE}

  struct Demande {
    uint256 remuneration;
    uint delaiAcceptation;
    string description;
    etatDemande statut;
    uint minReputation;
    uint candidat;
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

  function ajouterDemande(uint256 remuneration, string memory description, uint delaiAcceptation ) public payable{
    require(msg.value == remuneration + ((remuneration * 2) / 100), "N \'oubliez pas les 2% de frais !");
    nouvelleDemande.remenuration = _remuneration;
    nouvelleDemande.description = _description;
    nouvelleDemande.statut = etatDemande[0];

  }


}
