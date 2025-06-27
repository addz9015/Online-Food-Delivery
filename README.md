# Online Food Delivery

This project is a MySQL-based backend database design for an online food delivery platform. It includes schema design, sample data, and feature-specific SQL queries to simulate the core functionality of real-world food ordering systems like Swiggy, Uber Eats, or Zomato.

# Contents
- Normalized Relational Database Schema (3NF)
- SQL Scripts to Create Tables
- Sample Data for All Tables
- SQL Queries for Core and Bonus Features
- ER Diagram (`.dbml` provided)
- Analytics Queries

# Features Implemented

## Core Features
1. User Management (register, manage users)
2. Restaurant Management
3. Menu Management (menu items per restaurant)
4. Order Placement (multiple items per order)
5. Order Status Tracking (placed, accepted, prepared, etc.)
6. Delivery Agent Management
7. Live Order Assignment
8. Real-Time Location Tracking

## Bonus Features
- Ratings & Reviews (restaurant & delivery agent)
- Promo Codes & Discounts
- Multiple Payment Methods (cash, card, wallet)
- Analytics Queries (popular items, top restaurants, etc.)
- Restaurant Operating Hours
- Scheduled Orders

## Technologies Used
- MySQL 8.0+
- SQL scripts written manually and validated via MySQL Workbench

# File Structure

| File                         | Description                      |
|------------------------------|----------------------------------|
| `schema.sql`                 | Table creation with constraints  |
| `sample_data.sql`            | Insert statements for demo data  |
| `queries.sql`                | Core + bonus SQL queries         |
| `food_delivery_schema.dbml`  | ER diagram in dbdiagram.io format|
| `README.md`                  | Project documentation            |

# How to Run

1. Open **MySQL Workbench** or CLI.
2. Execute:
   ```bash
   mysql -u root -p < schema.sql
   mysql -u root -p < sample_data.sql
   ```
3. Run queries from `queries.sql` as needed.

# Example Queries

# Track live location of delivery agent:
```sql
SELECT o.order_id, o.status, da.name AS agent_name, al.latitude, al.longitude
FROM orders o
JOIN order_assignments oa ON o.order_id = oa.order_id
JOIN delivery_agents da ON oa.agent_id = da.agent_id
JOIN agent_locations al ON da.agent_id = al.agent_id
WHERE o.order_id = 1
ORDER BY al.updated_at DESC
LIMIT 1;
```

# Find most popular dishes:
```sql
SELECT mi.name, COUNT(*) AS total_ordered
FROM order_items oi
JOIN menu_items mi ON oi.item_id = mi.item_id
GROUP BY mi.item_id
ORDER BY total_ordered DESC;
```

# ER Diagram

Given in the file structure

# Author

**Name:** Advika Nagool 
**Email:** advikanagool15@gmail.com
**GitHub:** https://github.com/addz9015
