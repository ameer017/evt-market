// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

contract Listing {
    address public owner;

    struct Item {
        string itemName;
        uint256 itemPrice;
    }

    mapping(uint256 => Item) public items;

    event NewItem(uint256 indexed itemId, string name, uint256 price);

    constructor(address _owner) {
        owner = _owner;
    }

    function listItem(
        uint256 itemId,
        string memory itemName,
        uint256 itemPrice
    ) public {
        items[itemId] = Item(itemName, itemPrice);

        emit NewItem(itemId, itemName, itemPrice);
    }
}
