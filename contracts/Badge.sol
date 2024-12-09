// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Badge is ERC721, Ownable {
    string public baseURI;
    uint tokenIds;
    uint mintingPrice;
    uint share; // 10000/10000

    constructor(string memory name, string memory symbol, string memory _baseURI) ERC721(name, symbol) Ownable(msg.sender) {
        baseURI = _baseURI;
        tokenIds = 0;
        share = 1000; // 10%
        mintingPrice = 20 ether;
    }

    function setBaseURI(string memory _baseURI) public onlyOwner {
        baseURI = _baseURI;
    }

    function setMintingPrice(uint256 _mintingPrice) public onlyOwner {
        mintingPrice = _mintingPrice;
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    function transferFrom(address from, address to, uint256 tokenId) public pure override {
        require(false, "SoulBoundToken: Transfers are not allowed");
    }

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public pure override {
        require(false, "SoulBoundToken: Transfers are not allowed");
    }

    function approve(address to, uint256 tokenId) public pure override {
        require(false, "SoulBoundToken: Approvals are not allowed");
    }

    function setApprovalForAll(address operator, bool approved) public pure override {
        require(false, "SoulBoundToken: Approvals are not allowed");
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireOwned(tokenId);

        return _baseURI();
    }

    function mintNFT(address receiver_cut) payable public returns (uint256) {
        uint256 itemId = tokenIds;
        tokenIds++;
        _mint(msg.sender, itemId);
        require(msg.value == mintingPrice, "Not match minting fee");
        address owner = owner();
        if (receiver_cut == owner) {
            (bool sent, bytes memory data) = owner.call{value: msg.value}("");
            require(sent, "Failed to send Ether");
        } else {
            uint cut = (msg.value * share)/10000;
            (bool sent_receiver, bytes memory data_receiver) = receiver_cut.call{value: cut}("");
            require(sent_receiver, "Failed to send receiver Ether");
            (bool sent_owner, bytes memory data_owner) = owner.call{value: msg.value - cut}("");
            require(sent_owner, "Failed to send Ether");
        }
        return itemId;
    }
}
