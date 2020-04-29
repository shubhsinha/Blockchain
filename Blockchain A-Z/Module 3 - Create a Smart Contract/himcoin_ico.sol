// Himcoin ICO

// Version of compiler
pragma solidity ^0.5.1;

contract himcoin_ico{
    // Introducing maximum number of himcoin 
    uint public max_himcoins = 1000000;
    
    // Introducing USD to Himcoin conversionj rate
    uint public usd_to_himcoin = 1000;
    
    // Introducing the total number of Himcoin been bought by the investors
    uint public total_himcoin_bought = 0;
    
    // Mapping from the investor address to its equity in Himcoins and usd_to_himcoin
    mapping(address => uint) equity_himcoin;
    mapping(address => uint) equity_usd;
    
    // Checking if an investor can buy Himcoin
    modifier can_buy_himcoin(uint usd_invested){
        require(usd_invested*usd_to_himcoin + total_himcoin_bought <= max_himcoins);
        _;
    }
    
    // Getting the equity in Himcoins of an investor
    function equity_in_himcoin(address investor) external view returns(uint){
        return equity_himcoin[investor];
    }
    
    // Getting the equity in USD of an investor
    function equity_in_usd(address investor) external view returns(uint){
        return equity_usd[investor];
    }
    
    // Buying Himcoins
    function buy_himcoin(address investor, uint usd_invested) external
    can_buy_himcoin(usd_invested){
        uint himcoins_bought = usd_invested * usd_to_himcoin;
        equity_himcoin[investor] += himcoins_bought;
        equity_usd[investor] += equity_himcoin[investor]/usd_to_himcoin;
        total_himcoin_bought += himcoins_bought;
    }
    
    // Selling Himcoins
    function sell_himcoin(address investor, uint himcoins_sold) external{
        equity_himcoin[investor] -= himcoins_sold;
        equity_usd[investor] += equity_himcoin[investor]/usd_to_himcoin;
        total_himcoin_bought -= himcoins_sold;
    }
        
}
