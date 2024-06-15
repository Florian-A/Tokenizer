# SmartWallet

## Introduction

Le contrat `SmartWallet` est un portefeuille multi-signature conçu pour fonctionner avec le token ERC-20 ShibaWoof (SW42). Il permet à plusieurs signataires d'approuver les transferts avant leur exécution, garantissant ainsi une sécurité renforcée pour les fonds détenus.

### Fonctions

- **`constructor(address _tokenAddress, address[] memory _initialSigners)`**: Initialise le SmartWallet avec l'adresse du token et une liste de signataires initiaux.
- **`receive() external payable`**: Fonction de fallback pour recevoir des ethers.
- **`getBalance() public view returns (uint256)`**: Retourne le solde de tokens SW42 détenus par le SmartWallet.
- **`withdraw(uint256 value) public onlyOwner`**: Permet au propriétaire de retirer des tokens du SmartWallet.
- **`requestTransfer(address to, uint256 value) public returns (bytes32 transferId)`**: Demande un transfert de tokens, générant un ID de transfert unique.
- **`approveTransfer(bytes32 transferId) public onlySigner`**: Approuve un transfert de tokens en attente.
- **`executeTransfer(bytes32 transferId) internal`**: Exécute un transfert de tokens approuvé.
- **`getSignerCount() public view returns (uint256)`**: Retourne le nombre de signataires autorisés.

## Utilisation

Pour effectuer un transfert depuis `SmartWallet` :

- Appeler la fonction `requestTransfer` en spécifiant l'adresse de destination et la quantité de tokens à transférer. Cette fonction retourne un `transferId`.

- Approuver le transfert, utilisez la fonction `approveTransfer` en fournissant le `transferId`.

La transaction est confirmée lorsque la moitié des signataires autorisés ont approuvé le transfert.
