# Dynamic NFT [WIP]

-In this tutorial, you're going to build a Dynamic NFT using Chainlink’s decentralized and cryptographically secured oracle network to get and track asset price data.

Then, you will use the automations from the Chainlink Keepers Network to automate your NFT smart contract to update the NFTs according to the asset price data you're tracking.

- If the market price moves up, the smart contract will randomly pick the NFT’s URI to point to one of these three bullish images and the NFT will be dynamically updated:

- If the price feed’s data moves down, the NFT will dynamically update to one of these bearish images, which are also randomly selected!

- Finally, we will use Chainlink’s Verifiable Random Function to add cryptographically guaranteed randomness to our NFT smart contract to randomly select an NFT image from a list of options.

