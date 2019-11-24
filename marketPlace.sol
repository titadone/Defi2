pragma solidity ^0.5.11;
pragma experimental ABIEncoderV2;

<<<<<<< HEAD
import "./SafeMath.sol";

contract ArtisteContract{
    using SafeMath for uint256;

    enum EtatDemande{
        OUVERTE,
        ENCOURS,
        FERMEE
    }

    struct Artiste{
        string nom;
        uint256 reputation;
        uint256 solde;
    }

    struct Entreprise{
        string nom;
        address addresse;
    }

    struct Demande {
        address ownerd;
        uint256 remuneration;
        uint256 delai_acceptation;
        string description;
        uint256 reputation_min;
        EtatDemande statut;
        mapping(address => Artiste) list_candidat;
    }

    mapping(address => Artiste) public list_artiste;
    mapping(address => Entreprise) public list_entreprise;
    mapping(address => bool) public list_ban;
    Demande[] public tab_demande;
    address public owner;
    uint256 public _balancesMarket;

    constructor() public{
        owner = msg.sender;
    }

    modifier admin(){
        require(msg.sender == owner,"Vous n'etes pas admin de ce contrat");
        _;
    }
    /*
    modifier onlyEnterprise(){
        require(list_entreprise[msg.sender].typeof(ArtisteContract.Entreprise), "Vous n etes pas une entreprise !");
        _;
    }*/

    function inscription(string memory _nom) public{
        require(list_ban[msg.sender] == true,"Vous êtes déjà banni!");

        list_artiste[msg.sender].reputation = 1;
        list_artiste[msg.sender].nom = _nom;
    }

    function ban(address ban_user) public admin{
        list_artiste[ban_user].reputation = 0;
        list_ban[ban_user] = true;
    }

    function ajouterDemande(uint256 remuneration, string memory nom, uint256 scoreMin, uint256 delai) public payable{
        require(list_entreprise[msg.sender].addresse == msg.sender, "Vous n'etes pas une entreprise !");
        uint256 commission = remuneration * 2/100;
        require(msg.value >= (remuneration+commission), "Vous n'avez pas fournis les 2% de frais minimum");
        _balancesMarket.add(msg.value);
        Demande memory d = Demande(msg.sender, remuneration, delai, nom, scoreMin, EtatDemande.OUVERTE);
        tab_demande.push(d);
    }

    function postuler(Demande memory d) public returns (bool){
        require(list_artiste[msg.sender].reputation >= d.reputation_min, "Votre reputation n'est pas suffisante pour postuler");
        Artiste memory a = list_artiste[msg.sender];
        d.list_candidat[msg.sender] = a;
    }

    function accepterOffre(Demande memory d) public{
        require(d.ownerd == msg.sender,"Vous netes pas le proprietaire");
        d.EtatDemande = EtatDemande.ENCOURS;
    }


    function livraison(string memory hash, Demande memory d) public returns (bool){
        require(msg.sender != address(0), "Adresse non valide");
        _balancesMarket.sub(d.remuneration);
        list_artiste[msg.sender].solde.add(d.remuneration);
        d.statut = EtatDemande.FERMEE;
        list_artiste[msg.sender].reputation += 1;
    }

    function reclamation(Demande memory d) public {
    
    }
}
=======
contract marketPlace{
  mapping(address => User) public users;
  mapping(address => Entreprise) public entreprises;
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

  function ajouterDemande(uint256 _remuneration, uint _delaiAcceptation, string _description, uint _minReputation) public payable{
    require(entreprises[msg.sender] == msg.sender);
    require(msg.value == remuneration + ((remuneration * 2) / 100));
    demande.remenuration = _remuneration;
    demande.delaiAcceptation = _delaiAcceptation;
    demande.description = _description;
    demande.statut = etatDemande[0];
    demande.minReputation = _minReputation;
    list_demande.push(demande);

  }

  function listOffre() public{

  }


}
>>>>>>> d481c2fe9a8043ba9ee27983ef398077915c385a
