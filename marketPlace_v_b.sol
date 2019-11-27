pragma solidity ^0.5.11;
import "./safeMath.sol";

contract marketPlace{
  mapping(address => User) public users;
  mapping(address => Entreprise) public entreprises;
  mapping(address => bool) list_ban;
  mapping(address => Demande) list_demande;
  Demande[] tab_demande;
  address owner;
  uint256 balance;

  modifier admin(){
    require(msg.sender == owner);
  }

  struct User {
    uint reputation;
    string nom;
  }

  enum etatDemande {OUVERTE, EN COURS, FERMEE}

  /*struct Candidat {
    uint age;
    string nom;
  }*/

  struct Demande {
    address Owner;
    uint256 remuneration;
    uint delaiAcceptation;
    string description;
    etatDemande statut;
    uint minReputation;
    mapping(address => Candidat) list_candidats;
    string[] candidatName;
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

  function ajouterDemande(uint256 _remuneration, uint _delaiAcceptation, string _description, uint _minReputation) public payable{
    require(entreprises[msg.sender] == msg.sender);
    require(msg.value == remuneration + ((remuneration * 2) / 100));
    Demande memory demande;
    demande.remenuration = _remuneration;
    demande.delaiAcceptation = _delaiAcceptation;
    demande.description = _description;
    demande.statut = etatDemande[0];
    demande.minReputation = _minReputation;
    tab_demande.push(demande);

  }

  function listOffre() public{

  }

  function postuler(uint idOffre, string _nom) public{
    require(users.reputation[msg.sender] > 0, "Reputation insuffisante pour postuler !");
    tab_demande[idOffre].list_candidats[msg.sender] = users[msg.sender];
    candidatName.push(_nom);
  }

  function accepterOffre(uint idOffre) public{
    require(tab_demande[idOffre] == etatDemande[0], "Offre plus disponible !");
    tab_demande[idOffre].statut = etatDemande[1];
  }

  function livraison() public{
    require(msg.sender != address(0), "Adresse non valide !");
    tab_demande.statut = etatDemande[2];
    users[msg.sender].reputation += 1;


  }


}
