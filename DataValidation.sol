// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataValidationContract {
    struct Data {
        uint256 id;
        string content;
        uint256 timeStamp;
        address owner;
    }

    mapping(uint256 => Data) private dataMapping; 
    mapping(address => uint256[]) private ownedData;

    function storeData(uint256 _id, string memory _content) public {
        uint256 timeStamp = block.timestamp;
        address owner = msg.sender;

        Data memory newData = Data({
            id: _id,
            content: _content,
            timeStamp: timeStamp,
            owner: owner
        });

        dataMapping[_id] = newData;
        ownedData[owner].push(_id);
    }

    function validateData(uint256 _id, string memory _content, uint256 _timeStamp, address _owner) public view returns (bool) {
        Data memory existingData = dataMapping[_id];

        if (keccak256(abi.encodePacked(existingData.content)) != keccak256(abi.encodePacked(_content))) {
            return false;
        }

        if (existingData.timeStamp != _timeStamp) {
            return false;
        }

        if (existingData.owner != _owner) {
            return false;
        }

        return true;
    }
}
