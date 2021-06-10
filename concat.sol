pragma solidity ^0.8.1;

contract concate{
    
    function strConcat5(string memory _a, string memory _b, string memory _c, string memory _d, string memory _e) public view returns (string memory){
        bytes memory _ba = bytes(_a);
        bytes memory _bb = bytes(_b);
        bytes memory _bc = bytes(_c);
        bytes memory _bd = bytes(_d);
        bytes memory _be = bytes(_e);
        string memory abcde = new string(_ba.length + _bb.length + _bc.length + _bd.length + _be.length);
        bytes memory babcde = bytes(abcde);
        uint k = 0;
        for (uint i = 0; i < _ba.length; i++) babcde[k++] = _ba[i];
        for (uint i = 0; i < _bb.length; i++) babcde[k++] = _bb[i];
        for (uint i = 0; i < _bc.length; i++) babcde[k++] = _bc[i];
        for (uint i = 0; i < _bd.length; i++) babcde[k++] = _bd[i];
        for (uint i = 0; i < _be.length; i++) babcde[k++] = _be[i];
        return string (babcde);
    }
    function concat(string memory _a, string memory _b, string memory _c, string memory _d, string memory _e) public pure returns (string memory){
        return string(abi.encodePacked(_a,_b,_c,_d,_e));
    }
    function compare() public view returns (bool){
        return (keccak256(bytes(strConcat5("a","b","c","d","e"))) == keccak256(bytes(concat("a","b","c","d","e"))));
    }
    function encodeString() public view returns (bytes32) {
        return (keccak256(bytes(strConcat5("a","b","c","d","e"))));
    }
    function print() public view returns (bytes32){
        return keccak256(bytes(strConcat5("a","b","c","d","e")));
    }
    function print2() public view returns (bytes memory){
        return abi.encodePacked("LiP4vc9ZMeadRdm0wNL4mqibIRmYB8DwadUt3H1zCEMtLD4JyfyZNEknVr3QNvfNYoxCe44CKTvChCsLDSMFuqGVv5Fa2ghxTjYM6nZkS4IgdSI29Kti6EYC2fkNHoggkiNYWs4U0WB6XJ7M3GFROkM7WQJqATo7iA15STppDooKXXU3gMR4OXebtpyWC5RJkJiepT2t","b","c","d","e");
    }

}
