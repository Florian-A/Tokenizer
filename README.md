<h1 align="center">Tokenizer</h1>

Projet post tronc-commun de [42](https://42.fr/), dont le but est la création d'un smart contract de type ERC-20 sur la blockchain Ethereum.

Ce projet couvre les aspects suivants :

- Développement d'un token.
- Déploiement d'un smartcontract sur une blockchain public.

---

### Pré-requis :

- Node.js installé sur votre système.

### Installation et configuration :

- Créer un fichier `.env` avec les paramètres suivants :

```
MNEMONIC="votre mnémonique"
INFURA_PROJECT_ID="ID projet Infura"
ETHERSCAN_API="API Etherscan"
```

- Vous pouvez également sur macOS utiliser le trousseau pour stocker votre mnémonique. Pour ce faire, exécutez cette commande :

```
security add-generic-password -a "Mnemonic" -s "Hardhat" -w "votre mnémonique"
```

### Commandes disponibles :

- `make install` : Installe les dépendances.
- `make compile` : Compile le smart contract.
- `make test` : Lance les tests du smart contract.
- `make deploy` : Déploie et vérifie le smart contract.

---

### Documentation :

Consultez le fichier [`ShibaWoof.md`](./documentation/ShibaWoof.md) du dossier `documentation` pour plus d'informations sur le fonctionnement du token ERC-20 ShibaWoof et [`SmartWallet.md`](./documentation/SmartWallet.md) pour le fonctionnement du smart contract `SmartWallet`.

### Démonstration :

Le token `ShibaWoof42` a été déployé sur le réseau de test Sepolia à l'adresse suivante :

https://sepolia.etherscan.io/address/0x88b5d36f929941f27d7e68f56dc8ed34f36b1e96

Et le smartcontract `SmartWallet` :

https://sepolia.etherscan.io/address/0x97b91c84911529727FeA2D4e2FcC76695034E1DE

### Correction :

| |
| --- |
| Pas encore corrigé ! |
