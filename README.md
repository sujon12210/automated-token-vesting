# Automated Token Vesting

This repository provides a secure way to manage token distributions. It is essential for blockchain startups to build trust by locking founder and investor tokens, preventing a sudden market dump.

## Features
* **Linear Release:** Tokens are unlocked second-by-second after the cliff period.
* **Cliff Period:** A set duration where no tokens can be claimed.
* **Revocable:** Optional feature to allow the owner to stop vesting (useful for employee departures).
* **ERC-20 Compatible:** Works with any standard Ethereum-based token.

## Vesting Logic
The amount of tokens claimable is calculated as:
$Claimable = \frac{Total\_Amount \times (Current\_Time - Start\_Time)}{Duration}$



## Deployment
1. Deploy the contract with the beneficiary address, start time, cliff duration, and total duration.
2. Transfer the total token amount to the contract address.
3. The beneficiary calls `release()` once the cliff has passed.
