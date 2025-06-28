# Decentralized Crowdfunding DApp

A full-stack decentralized crowdfunding application built with Solidity, Hardhat, React.js, Tailwind CSS, and Ethers.js.

## Features
- Create and manage fundraising campaigns
- Donate ETH to campaigns
- Claim funds if goal is reached, refund if not
- MetaMask wallet integration
- Real-time campaign status and progress

## Project Structure
```
crowdfunding-dapp/
├── contracts/
├── scripts/
├── client/
│   ├── src/
│   │   ├── components/
│   │   ├── pages/
│   │   └── App.js
├── hardhat.config.js
└── .env
```

## Getting Started

### 1. Install dependencies
```
npm install
```

### 2. Compile contracts
```
npx hardhat compile
```

### 3. Deploy contracts (local/testnet)
```
npx hardhat run scripts/deploy.js --network <network>
```

### 4. Run frontend
```
cd client
npm install
npm run dev
```

### 5. Environment Variables
Create a `.env` file in the root directory with your private key and RPC URLs. See `.env.example` for reference.

---

## Deployment
- Deploy contracts to Goerli/Sepolia using Hardhat
- Deploy frontend to Vercel or Netlify

---

## License
MIT
