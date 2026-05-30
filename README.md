# DashBoard

![Dashboard]('images/Dashboard.png')


# Entity Classification

## Strong Entities
Can exist on its own.

| Entity | Justification |
|---|---|
| **User** (Supertype) | Exists before anything else can be done. |
| **Product** | Exists without needing any orders or categories. |
| **Category** | Can exist with no products in it. |
| **Transaction** | Stays in the system as a permanent record. |

---

## Weak Entities
Needs a parent to exist.

| Entity | Justification |
|---|---|
| **GuestUser** (Subtype) | Cannot exist without a parent `User`. |
| **RegisteredUser** (Subtype) | Cannot exist without a parent `User`. |
| **Inventory** | Cannot exist without a parent `Product`. |
| **TransactionItem** | Cannot exist without a parent `Transaction` and `Product`. |
| **Review** | Cannot exist without a parent `User` and `Product`. |