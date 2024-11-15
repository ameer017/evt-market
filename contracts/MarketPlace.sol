// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

import "./Listing.sol";
import "./Ilisting.sol";

contract MarketPlace {
    struct DeployedContractInfo {
        address deployer;
        address deployedContract;
    }

    mapping(address => DeployedContractInfo[]) userDeployedContracts;
    DeployedContractInfo[] public allContracts;
    IListing[] public listingContracts;

    mapping(address => address[]) public userToListingContracts;

    event NewContractListed(address indexed user, address listingContract);

    function deployListingContract()
        external
        returns (address contractAddress_)
    {
        require(msg.sender != address(0), "Zero Address not allowed");

        Listing newListingContract = new Listing(msg.sender);
        address _address = address(newListingContract);

        contractAddress_ = _address;

        DeployedContractInfo memory _deployedContract;
        _deployedContract.deployer = msg.sender;
        _deployedContract.deployedContract = _address;

        userToListingContracts[msg.sender].push(address(newListingContract));

        userDeployedContracts[msg.sender].push(_deployedContract);

        allContracts.push(_deployedContract);
        listingContracts.push(IListing(_address));

        emit NewContractListed(msg.sender, address(newListingContract));
    }

    function getListingContracts(
        address user
    ) public view returns (address[] memory) {
        return userToListingContracts[user];
    }

    function createItem(
        address _listItemContract,
        uint256 _itemId,
        string memory _itemName,
        uint16 _itemPrice
    ) external {
        require(
            _listItemContract != address(0),
            "Invalid ProposalVote contract address"
        );

        IListing(_listItemContract).listItem(_itemId, _itemName, _itemPrice);
    }
}
