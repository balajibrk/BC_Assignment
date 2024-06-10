// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VotingManager {
    struct Solution {
        uint256 id;
        address proposer;
        string description;
        uint256 voteCount;
        bool isVerified;
    }

    uint256 public solutionCount;
    mapping(uint256 => Solution) public solutions;
    mapping(uint256 => mapping(address => bool)) public votes;

    event SolutionProposed(uint256 solutionId, address proposer, string description);
    event Voted(uint256 solutionId, address voter, bool isPositive);
    event SolutionVerified(uint256 solutionId);

    function proposeSolution(string memory _description) public {
        solutionCount++;
        solutions[solutionCount] = Solution(solutionCount, msg.sender, _description, 0, false);
        emit SolutionProposed(solutionCount, msg.sender, _description);
    }

    function vote(uint256 _solutionId, bool _isPositive) public {
        require(!votes[_solutionId][msg.sender], "You have already voted");
        votes[_solutionId][msg.sender] = true;

        if (_isPositive) {
            solutions[_solutionId].voteCount++;
        } else {
            solutions[_solutionId].voteCount--;
        }

        emit Voted(_solutionId, msg.sender, _isPositive);
    }

    function verifySolution(uint256 _solutionId) public {
        require(solutions[_solutionId].voteCount > 0, "Solution does not have enough positive votes");
        solutions[_solutionId].isVerified = true;
        emit SolutionVerified(_solutionId);
    }
}
