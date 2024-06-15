# Token ShibaWoof (SW42)

## Introduction

ShibaWoof (SW42) est un token ERC-20 développé pour fonctionner sur la machine virtuelle Ethereum (EVM).

## Fonctionnement

Le smart contract ShibaWoof respecte la norme ERC-20, fournissant des fonctions essentielles nécessaires à son utilisation en tant que cryptomonnaie standard sur la blockchain Ethereum. Voici les principales fonctionnalités et méthodes du contrat :

### Fonctions

- **`name()`**: Retourne le nom du token (`"ShibaWoof42"`).
- **`symbol()`**: Retourne le symbole du token (`"SW42"`).
- **`decimals()`**: Retourne le nombre de décimales utilisé par le token (0 dans ce cas).
- **`totalSupply()`**: Retourne le nombre total de tokens en circulation (42 dans ce cas).
- **`balanceOf(address owner)`**: Retourne le solde du compte propriétaire spécifié.
- **`transfer(address to, uint256 value)`**: Transfère une certaine quantité de tokens à un destinataire spécifié.
- **`transferFrom(address from, address to, uint256 value)`**: Transfère une certaine quantité de tokens depuis un compte spécifié vers un autre compte.
- **`approve(address spender, uint256 value)`**: Autorise un autre compte à dépenser une certaine quantité de tokens en votre nom.
- **`allowance(address owner, address spender)`**: Retourne le montant de tokens que le propriétaire a autorisé le dépenseur à utiliser.

### Sécurité

Ce smart contract utilise des vérifications pour s'assurer que les transferts et les autorisations respectent les contraintes définies. Par exemple, il vérifie si l'expéditeur a un solde suffisant pour effectuer un transfert et si les montants transférés ne dépassent pas les soldes ou les autorisations disponibles.

## Utilisation

Pour utiliser ShibaWoof (SW42), vous devez interagir avec le smart contract via une interface utilisateur compatible avec Ethereum, telle qu'un portefeuille de cryptomonnaie (comme MetaMask par exemple). Voici comment utiliser les principales fonctionnalités du token :

1. **Obtenir des Tokens SW42** : Le créateur du token reçoit automatiquement 42 ShibaWoof.
2. **Transférer des Tokens** : Utilisez la fonction `transfer` pour envoyer des tokens SW42 à une autre adresse Ethereum.
3. **Autoriser des Dépenses** : Si vous souhaitez permettre à une autre adresse Ethereum de dépenser des tokens SW42 en votre nom, utilisez la fonction `approve` pour autoriser cette adresse, puis utilisez la fonction `transferFrom` pour effectuer des transactions.

## Ajout du token sur MetaMask

Pour ajouter le token ShibaWoof (SW42) sur MetaMask, suivez ces étapes simples :

1. Ouvrez l'application MetaMask et assurez-vous que vous êtes connecté à votre portefeuille.
2. Cliquez sur le bouton "Ajouter un token" dans la section "Assets" de MetaMask.
3. Sélectionnez "Custom Token".
4. Dans le champ "Token Contract Address", entrez l'adresse du smart contract ShibaWoof.
5. MetaMask devrait automatiquement détecter le nom et le symbole du token. Vérifiez les détails et cliquez sur "Next".
6. Cliquez sur "Add Tokens" pour terminer le processus d'ajout.

Maintenant, vous devriez voir le solde de vos tokens ShibaWoof (SW42) dans votre portefeuille MetaMask.

## Avertissement

Assurez-vous de comprendre les risques associés à l'utilisation de tokens ERC-20 et prenez les mesures de sécurité appropriées pour protéger vos fonds. Les transactions de cryptomonnaie sont irréversibles, il est donc recommandé de vérifier attentivement les détails de chaque transaction avant de les valider.