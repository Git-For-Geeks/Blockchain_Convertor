// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
// importing interface for chainlink price feed
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
contract conversion{
// The address in AggregatorV3Interface is of the chainLink test net eth to usd contract
function getPriceinUsd() public view returns(uint256){

AggregatorV3Interface priceFeed= AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
(,int256 price,,,)=priceFeed.latestRoundData();
 // this function is going to get the conversion rate
// to get the conversion rate we need chainlink datafeed
//to get this we need two things:-
    //ABI
    //Address of the contract from which we get data:-0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e gorelli test net
//solidity don't have decimals so the value returned is in integer which should have 8 decimals
//we need to make it 18 decimal places so we need to muliply price with 1e10
// and we would typecast it to uint256
return (uint256)(price*1e10);
}
function getVersion() public view returns(uint256){
    //this fucntion will give the version of the pricefeed
   
    AggregatorV3Interface priceFeed=AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
    return priceFeed.version();
}
function getConversion(uint256 ethAmount) public view returns(uint256){
  //this function is going to convert msg.value in eth to usd
  uint256 price=getPriceinUsd();
  //the below is returning 18 decimals as price is 18 decimal and ethAmount is also 18 decimal 
  //so mulitplying them gives 36 decimal and we are dividing it by 18 decimals 
  //so it is returned 18 decimals
  return (price*ethAmount)/1e18;
}
}
