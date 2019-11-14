pragma solidity ^0.5.11;
//pragma experimental ABIEncoderV2;

contract ArtisteContract{

    enum EtatDemande{
        OUVERTE,
        ENCOURS,
        FERMEE
    }

    struct Artiste{
        string nom;
        uint256 reputation;
    }

    struct Demande {
        address owner;
        uint256 remuneration;
        uint256 delai_acceptation;
        string description;
        EtatDemande statut;
        uint256 nbCandidats;
    }

    mapping(address => Artiste) list_artiste;
    mapping(address => Demande) list_candidats;
    mapping(address => bool) list_ban;
    Demande[] list_demande;
    address owner;

    constructor() public{
        owner = msg.sender;
    }

    modifier admin(){
        require(msg.sender == owner,"Vous n'etes pas admin de ce contrat");
        _;
    }

    function inscription(string memory _nom) public{
        require(list_ban[msg.sender] == true,"Vous êtes déjà banni!");

        list_artiste[msg.sender].reputation = 1;
        list_artiste[msg.sender].nom = _nom;
    }

    function ban(address ban_user) public admin{
        list_artiste[ban_user].reputation = 0;
        list_ban[ban_user] = true;
    }

    function ajouterDemande(uint256 remuneration, string memory nom, uint256 delai) public payable{
        Demande d = Demande(msg.sender, remuneration, delai, nom, EtatDemande.OUVERTE,0);
        list_demande.push(d);
        /*
        d.remuneration = remuneration;
        d.description = nom;
        d.delai_acceptation = delai;
        d.statut = EtatDemande.OUVERTE;
        d.owner = msg.sender;
        list_demande.push(d);
        */
    }
}