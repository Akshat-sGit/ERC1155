// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "../node_modules/@openzeppelin/contracts/access/AccessControl.sol";
import "../node_modules/@openzeppelin/contracts/utils/Counters.sol";


contract NFT is ERC1155, AccessControl{
    using Counters for Counters.Counter;
    Counters.Counter private idCounter;

    constructor() ERC1155("https://bafybeidpdvd4zb4mqbl77oqtooztduftdbm2iz7q64dcobwarbmkbg5jpi.ipfs.w3s.link/NFT_metadata.json") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function mint(uint amount) external  onlyRole(DEFAULT_ADMIN_ROLE) {
        uint token = idCounter.current();
        _mint(msg.sender, token, amount, "");
        idCounter.increment();
    }

    function minBatch(uint256[] memory amounts) external onlyRole(DEFAULT_ADMIN_ROLE) {
        for(uint i = 0; i < amounts.length; i++){
            uint token = idCounter.current();
            _mint(msg.sender, token, amounts[i], "");
            idCounter.increment();
        }
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC1155, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
