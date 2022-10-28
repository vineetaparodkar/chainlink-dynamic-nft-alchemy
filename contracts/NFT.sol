// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract BullBear is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    AggregatorV3Interface public priceFeed;

    int256 public currentPrice;

    string[] bullIpfsURIs = [
        "https://ipfs.io/ipfs/bafkreigstxcwompphrioktkxxr3okwl2o7mj52qyklrrkriefg6dmmng2q?filename=gamer_bull.json",
        "https://ipfs.io/ipfs/bafkreihrwza6fqyhw3cm7qsk55lvoqijypim5zazfli4tvtlsgvuxyphei?filename=party_bull.json"
    ];
    string[] bearIpfsURIs = [
        "https://ipfs.io/ipfs/bafkreib3jofwj4r6u3mlklwjtbkgpvdun6grw7xrqk5lsfsjdq7mkolufq?filename=beanie_bear.json",
        "https://ipfs.io/ipfs/bafkreiaafmeaaokac25tozliz2ehg7tqrbs3j2jekxg7hpokgbrlwfyxsy?filename=coolio_bear.json"
    ];

    /**
     * Network: Goerli
     * Aggregator: ETH/USD
     * Address: 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
     */
    constructor() ERC721("Bull&Bear", "BBTK") {
        priceFeed = AggregatorV3Interface(
            0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        );
        // set the price for the chosen currency pair.
        currentPrice = getLatestPrice();
    }

    function safeMint(address to) public {
        // Current counter value will be the minted token's token ID.
        uint256 tokenId = _tokenIdCounter.current();

        // Increment it so next time it's correct when we call .current()
        _tokenIdCounter.increment();

        // Mint the token
        _safeMint(to, tokenId);

        // Default to a bull NFT
        string memory defaultUri = bullIpfsURIs[0];
        _setTokenURI(tokenId, defaultUri);
    }

    /**
     * Returns the latest price
     */
    function getLatestPrice() public view returns (int256) {
        (
            uint80 roundID,
            int256 price,
            uint256 startedAt,
            uint256 timeStamp,
            uint80 answeredInRound
        ) = priceFeed.latestRoundData();
        return price;
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
