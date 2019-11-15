pragma solidity ^0.5.11;


interface IOffre{

    function listOffres() external;

    function getOffre(address addresse) external;

    function faireOffre(address) external;

    function annulerOffre(address) external;
}