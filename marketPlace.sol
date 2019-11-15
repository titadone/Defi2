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

  function ajouterDemande(uint256 _remuneration, uint _delaiAcceptation, string memory _description, uint _minReputation) public payable{
    require(msg.value == remuneration + ((remuneration * 2) / 100));
    nouvelleDemande.remenuration = _remuneration;
    nouvelleDemande.delaiAcceptation = _delaiAcceptation;
    nouvelleDemande.description = _description;
    nouvelleDemande.statut = etatDemande[0];
    nouvelleDemande.minReputation = _minReputation;
    list_demande.push(nouvelleDemande);

  }


}
