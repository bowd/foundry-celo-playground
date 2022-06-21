# Foundry playground for Celo Protocol contracts

This repository enables us to interact with the celo core contracts in foundry and make use of the speed and awesome features for writing tests, debugging and optimizing gas.

<script id="asciicast-503199" src="https://asciinema.org/a/503199.js" async></script>

## Installation

### Install foundry

```sh
curl -L https://foundry.paradigm.xyz | bash
```

### Install dependencies and run post-install scripts

```sh
yarn
```

> The post install scripts pull the submodules and also do a tiny patch on the [forge-std](https://github.com/foundry-rs/forge-std) changing the `Vm.sol` contract to be compiled with `>0.5.13`, for some reason they have it as `>0.6.0`.

## Using the repo

See the `FederatedAttestations.t.sol` file for some example interaction. Run tests via:

```sh
forge test
```

## Why I did this, what's next?

I setup this repo because I was reviewing the ASv2 code and wanted to compare gas on some alternative implementations and to better understand some of the code. Doing it in foundry greatly reduce my feedback loop time. Being able to stay in Solidity land when writing tests is really cool.

I've spent some time looking into adding the precompiles to `revm` and I'm trying to tap some people for help on this, but even without precompiles we could potentially start using foundry in `celo-monorepo` and start migrating some of our tests to it. It would result in way better DX and faster CI.
