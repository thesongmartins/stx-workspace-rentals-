# STX Workspace Rentals Smart Contract

## Overview

The **STX Workspace Rentals** smart contract is designed for a decentralized workspace rental platform built on the Stacks blockchain. It facilitates secure, transparent, and efficient workspace reservations between users while ensuring fair pricing, commission, and refund mechanisms. 

The contract introduces key features such as workspace listings, rental management, commission-based transactions, and refund policies. It supports granular control for both platform owners and users, ensuring a balanced ecosystem for workspace sharing.

---

## Features

### For Platform Owners
- **Set Pricing:** Define the hourly price for workspace rentals.
- **Adjust Commission and Refund Rates:** Configure the platform's commission and refund policies.
- **Reservation Limits:** Manage global and user-specific workspace reservation limits.

### For Users
- **List Workspaces:** Add or remove workspaces available for rent.
- **Rent Workspaces:** Reserve workspaces listed by other users.
- **Receive Payments:** Earn STX tokens for renting out listed workspaces.
- **Refund Reservations:** Request refunds for unused reservation hours.

### Security and Transparency
- Error handling ensures robust operation and prevents invalid transactions.
- Ownership verification restricts critical operations to the platform owner.
- On-chain data storage provides transparency in reservations and balances.

---

## How It Works

### Workflow
1. **Platform Owner Initialization:**
   - Sets the workspace price, commission rate, refund rate, and reservation limits.

2. **User Interaction:**
   - Users list their available workspaces with price and duration.
   - Other users rent these workspaces by paying the listed price plus a platform commission.
   - Payments are distributed to workspace owners and the platform.

3. **Refund Mechanism:**
   - Users can request refunds for unused hours based on the refund rate set by the platform owner.

### Key Components
- **Data Variables:** Store platform-level settings such as workspace price, commission rate, and reservation limits.
- **Data Maps:** Maintain user-specific balances and workspace details.
- **Private Functions:** Handle calculations for commission and refunds, and update reservation balances securely.
- **Public Functions:** Allow users and platform owners to interact with the contract.

---

## Contract Details

### Constants
| Name                       | Description                                   |
|----------------------------|-----------------------------------------------|
| `platform-owner`           | Address of the platform owner (initialized as `tx-sender`). |
| `err-owner-only`           | Error code for operations restricted to the platform owner. |
| `err-not-enough-space`     | Error code for insufficient available reservation space. |
| ...                        | Additional constants for error handling and validation. |

### Data Variables
| Name                       | Type  | Description                                   |
|----------------------------|-------|-----------------------------------------------|
| `workspace-price`          | `uint`| Price per hour for renting a workspace in microstacks. |
| `commission-rate`          | `uint`| Percentage commission deducted per transaction. |
| `refund-rate`              | `uint`| Percentage of the reservation amount refunded for unused hours. |
| ...                        |       | Additional variables for managing reservations and balances. |

### Data Maps
| Name                       | Key           | Value                        | Description                                   |
|----------------------------|---------------|------------------------------|-----------------------------------------------|
| `user-reservation-balance` | `principal`   | `uint`                       | Tracks reserved hours for each user.         |
| `workspace-for-rent`       | `{user}`      | `{hours, price}`             | Tracks hours and price for listed workspaces.|
| `user-stx-balance`         | `principal`   | `uint`                       | Tracks STX balances for each user.           |

---

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/your-username/stx-workspace-rentals.git
   cd stx-workspace-rentals
   ```

2. Install [Clarinet](https://docs.hiro.so/clarinet/getting-started) for local development:
   ```bash
   curl -L https://github.com/hirosystems/clarinet/releases/download/v<version>/clarinet.tar.gz | tar xz
   mv clarinet /usr/local/bin
   ```

3. Test the contract:
   ```bash
   clarinet test
   ```

---

## Usage

### Deploying the Contract
1. Open the `Clarinet.toml` file and configure your deployment settings.
2. Use the following command to deploy the contract:
   ```bash
   clarinet deploy
   ```

### Interacting with the Contract
1. Update workspace price (Platform Owner Only):
   ```clarity
   (contract-call? .stx-workspace-rentals set-workspace-price u600)
   ```

2. List workspace for rent:
   ```clarity
   (contract-call? .stx-workspace-rentals add-workspace-for-rent u10 u100)
   ```

3. Rent a workspace:
   ```clarity
   (contract-call? .stx-workspace-rentals rent-workspace-from-user tx-sender u5)
   ```

4. Request a refund:
   ```clarity
   (contract-call? .stx-workspace-rentals refund-reservation u5)
   ```

---

## Testing

Tests for the contract are located in the `tests` folder. The suite includes:
- Verification of platform owner functions.
- Validation of user interactions with workspace listings and rentals.
- Error handling and edge cases.

Run tests using Clarinet:
```bash
clarinet test
```

---

## Future Enhancements

1. Implement dynamic pricing for peak and off-peak hours.
2. Introduce penalty rates for late cancellations.
3. Develop a front-end interface for user-friendly interactions.
4. Add support for recurring reservations.

---

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request with detailed information about your changes.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Contact

For questions or support, feel free to reach out via:
- GitHub Issues
- Email: [your-email@example.com](mailto:your-email@example.com)

---

**STX Workspace Rentals** empowers the decentralized sharing economy. Start renting today! 😎✌🏽