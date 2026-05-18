# Database Schema Documentation

## Overview

**Database Name:** Brazilian E-Commerce Analytics  
**Type:** PostgreSQL  
**Total Tables:** 9  
**Total Records:** 99,441+ orders with supporting data  
**Purpose:** Store and analyze Brazilian e-commerce transaction data including customers, products, orders, payments, reviews, sellers, and geolocation.

---

## 📊 Database Architecture

### Entity Relationship Overview

```
customers (1) ←→ (many) orders
    ↓
orders (1) ←→ (many) order_items
    ↓
order_items → products (many-to-one)
    ↓
order_items → sellers (many-to-one)
    ↓
orders (1) ←→ (0-1) order_reviews
    ↓
orders (1) ←→ (many) order_payments
    ↓
products → category_translation (many-to-one)
    ↓
geolocation (standalone - lookup table)
```

---

## 🔑 Table Definitions

### 1. **customers**

**Purpose:** Store customer profile and location information

**Primary Key:** `customer_id`

| Column | Data Type | Nullable | Description |
|--------|-----------|----------|-------------|
| customer_id | VARCHAR(32) | NO | Unique identifier for each customer |
| customer_unique_id | VARCHAR(32) | YES | Anonymized unique ID (may be null) |
| customer_zip_code_prefix | VARCHAR(5) | YES | First 5 digits of customer's zip code |
| customer_city | VARCHAR(100) | YES | City where customer is located |
| customer_state | VARCHAR(2) | YES | State abbreviation (e.g., 'SP', 'RJ') |

**Sample Data:**
```
customer_id: 06b8999424a7d2d0bd0b...
customer_unique_id: 4841e409f1b9c...
customer_zip_code_prefix: 01315
customer_city: São Paulo
customer_state: SP
```

**Usage Notes:**
- One customer can have multiple orders
- Used to join with orders table
- Geographic analysis of customer distribution

---

### 2. **products**

**Purpose:** Store product catalog information

**Primary Key:** `product_id`

| Column | Data Type | Nullable | Description |
|--------|-----------|----------|-------------|
| product_id | VARCHAR(32) | NO | Unique product identifier |
| product_category_name | VARCHAR(100) | YES | Portuguese category name |
| product_name_length | INT | YES | Number of characters in product name |
| product_description_length | INT | YES | Number of characters in product description |
| product_photos_qty | INT | YES | Number of product photos |
| product_weight_g | FLOAT | YES | Product weight in grams |
| product_length_cm | FLOAT | YES | Product length in centimeters |
| product_height_cm | FLOAT | YES | Product height in centimeters |
| product_width_cm | FLOAT | YES | Product width in centimeters |

**Sample Data:**
```
product_id: 1234567890abcdef
product_category_name: cama_mesa_banho
product_name_length: 45
product_description_length: 200
product_photos_qty: 4
product_weight_g: 1500.5
product_length_cm: 30.0
product_height_cm: 20.0
product_width_cm: 15.0
```

**Usage Notes:**
- One product can appear in many orders (order_items)
- Join with category_translation for English category names
- Physical dimensions used for freight calculations

---

### 3. **sellers**

**Purpose:** Store seller/vendor information

**Primary Key:** `seller_id`

| Column | Data Type | Nullable | Description |
|--------|-----------|----------|-------------|
| seller_id | VARCHAR(32) | NO | Unique seller identifier |
| seller_zip_code_prefix | VARCHAR(5) | YES | First 5 digits of seller's zip code |
| seller_city | VARCHAR(100) | YES | City where seller is located |
| seller_state | VARCHAR(2) | YES | State abbreviation (e.g., 'SP', 'RJ') |

**Sample Data:**
```
seller_id: 3442f733faee...
seller_zip_code_prefix: 04567
seller_city: São Paulo
seller_state: SP
```

**Usage Notes:**
- One seller can fulfill many order items
- Join with order_items to analyze seller performance
- Geographic distribution affects shipping costs and times

---

### 4. **orders**

**Purpose:** Store order header information with status and timeline

**Primary Key:** `order_id`  
**Foreign Keys:** `customer_id` → customers.customer_id

| Column | Data Type | Nullable | Description |
|--------|-----------|----------|-------------|
| order_id | VARCHAR(32) | NO | Unique order identifier |
| customer_id | VARCHAR(32) | YES | FK to customers table |
| order_status | VARCHAR(20) | YES | Order status (delivered, canceled, etc.) |
| order_purchase_timestamp | TIMESTAMP | YES | When customer purchased the order |
| order_approved_at | TIMESTAMP | YES | When order was approved/payment confirmed |
| order_delivered_carrier_date | TIMESTAMP | YES | When carrier received the order |
| order_delivered_customer_date | TIMESTAMP | YES | When customer received the order |
| order_estimated_delivery_date | TIMESTAMP | YES | Expected delivery date at purchase time |

**Sample Data:**
```
order_id: e481f51cbdc54...
customer_id: 06b8999424a7d...
order_status: delivered
order_purchase_timestamp: 2016-10-03 11:05:28
order_approved_at: 2016-10-03 11:05:28
order_delivered_carrier_date: 2016-10-04 14:23:00
order_delivered_customer_date: 2016-10-10 00:12:00
order_estimated_delivery_date: 2016-10-13
```

**Order Status Values:**
- `delivered` - Order successfully delivered
- `canceled` - Order was canceled
- `unavailable` - Product unavailable
- `shipped` - Order in transit
- `processing` - Order being prepared
- `approved` - Payment approved, awaiting fulfillment

**Usage Notes:**
- One order can have multiple items (order_items)
- One order can have multiple payments (order_payments)
- One order can have one review (order_reviews)
- Delivery delay = order_delivered_customer_date - order_estimated_delivery_date

---

### 5. **order_items**

**Purpose:** Store line items in each order (what products were ordered)

**Primary Key:** (order_id, order_item_id) - Composite  
**Foreign Keys:**
- `order_id` → orders.order_id
- `product_id` → products.product_id
- `seller_id` → sellers.seller_id

| Column | Data Type | Nullable | Description |
|--------|-----------|----------|-------------|
| order_id | VARCHAR(32) | NO | FK to orders table |
| order_item_id | INT | NO | Sequential item number within order (1, 2, 3...) |
| product_id | VARCHAR(32) | YES | FK to products table |
| seller_id | VARCHAR(32) | YES | FK to sellers table (which seller fulfilled this item) |
| shipping_limit_date | TIMESTAMP | YES | Deadline for seller to ship item |
| price | FLOAT | YES | Item price in Brazilian Real (R$) |
| freight_value | FLOAT | YES | Shipping cost in R$ |

**Sample Data:**
```
order_id: e481f51cbdc54...
order_item_id: 1
product_id: 1234567890abc...
seller_id: 3442f733faee...
shipping_limit_date: 2016-10-07
price: 58.90
freight_value: 5.83
```

**Usage Notes:**
- One order can have multiple items
- Same product can be sold by different sellers
- `total_order_value = SUM(price + freight_value)` for the order
- Used for revenue analysis and seller performance tracking

---

### 6. **order_payments**

**Purpose:** Store payment information for each order

**Primary Key:** (order_id, payment_sequential) - Composite  
**Foreign Keys:** `order_id` → orders.order_id

| Column | Data Type | Nullable | Description |
|--------|-----------|----------|-------------|
| order_id | VARCHAR(32) | NO | FK to orders table |
| payment_sequential | INT | NO | Payment sequence number (1, 2, 3...) |
| payment_type | VARCHAR(20) | YES | Type of payment (credit_card, boleto, etc.) |
| payment_installments | INT | YES | Number of installments (1 = full payment, >1 = EMI) |
| payment_value | FLOAT | YES | Payment amount in R$ |

**Sample Data:**
```
order_id: e481f51cbdc54...
payment_sequential: 1
payment_type: credit_card
payment_installments: 1
payment_value: 64.73
```

**Payment Type Values:**
- `credit_card` - Credit card payment
- `boleto` - Brazilian payment method (similar to bank transfer)
- `debit_card` - Debit card payment
- `voucher` - Gift card or voucher
- `not_defined` - Unknown payment method

**Usage Notes:**
- One order can have multiple payment records (rare but possible)
- One payment can be split across multiple installments
- Total order payment = SUM(payment_value) for the order
- EMI (Equated Monthly Installments) = payment_installments > 1

---

### 7. **order_reviews**

**Purpose:** Store customer reviews and ratings for orders

**Primary Key:** `id` (auto-incremented BIGSERIAL)  
**Foreign Keys:** `order_id` → orders.order_id

| Column | Data Type | Nullable | Description |
|--------|-----------|----------|-------------|
| id | BIGSERIAL | NO | Auto-incremented primary key (safe, avoids null issues) |
| review_id | VARCHAR(32) | YES | Unique review identifier |
| order_id | VARCHAR(32) | YES | FK to orders table |
| review_score | INT | YES | Rating (1-5 stars) |
| review_comment_title | VARCHAR(255) | YES | Review title/summary |
| review_comment_message | TEXT | YES | Detailed review comment |
| review_creation_date | TIMESTAMP | YES | When customer posted the review |
| review_answer_timestamp | TIMESTAMP | YES | When seller responded to review |

**Sample Data:**
```
id: 1
review_id: 5a4f9...
order_id: e481f51cbdc54...
review_score: 5
review_comment_title: Excelente produto!
review_comment_message: Chegou rápido e bem embalado
review_creation_date: 2016-10-17 18:45:23
review_answer_timestamp: 2016-10-18 14:30:00
```

**Review Score Interpretation:**
- 5 = Very Satisfied / Excellent
- 4 = Satisfied / Good
- 3 = Neutral / Average
- 2 = Dissatisfied / Poor
- 1 = Very Dissatisfied / Terrible

**Usage Notes:**
- One order can have 0-1 review (not all orders have reviews)
- Used to measure customer satisfaction
- Correlated with delivery speed and product quality
- Missing values (NULL review_score) = No review left

---

### 8. **category_translation**

**Purpose:** Translate Portuguese product categories to English

**Primary Key:** `product_category_name`

| Column | Data Type | Nullable | Description |
|--------|-----------|----------|-------------|
| product_category_name | VARCHAR(100) | NO | Portuguese category name (key) |
| product_category_name_english | VARCHAR(100) | YES | English translation |

**Sample Data:**
```
product_category_name: cama_mesa_banho
product_category_name_english: bed_bath_table

product_category_name: esportes_lazer
product_category_name_english: sports_leisure

product_category_name: informatica_acessorios
product_category_name_english: computers_accessories
```

**Usage Notes:**
- Lookup table for translation purposes
- Join with products table to get English category names
- Used in all category-based analysis queries

---

### 9. **geolocation**

**Purpose:** Store geolocation data mapping zip codes to coordinates and cities

**Primary Key:** None (lookup table)

| Column | Data Type | Nullable | Description |
|--------|-----------|----------|-------------|
| geolocation_zip_code_prefix | INT | YES | 5-digit zip code prefix |
| geolocation_lat | FLOAT | YES | Latitude coordinate |
| geolocation_lng | FLOAT | YES | Longitude coordinate |
| geolocation_city | TEXT | YES | City name |
| geolocation_state | TEXT | YES | State name |

**Sample Data:**
```
geolocation_zip_code_prefix: 01315
geolocation_lat: -23.5505
geolocation_lng: -46.6333
geolocation_city: São Paulo
geolocation_state: SP
```

**Usage Notes:**
- Standalone lookup table (no primary key)
- Used to map zip codes to geographic coordinates
- Enables geographic analysis and mapping
- Not directly used in main transaction queries but useful for mapping/visualization

---

## 🔗 Key Relationships

### Order Flow (Main Transaction Path)
```
1. Customer places order
   customers → orders (1 customer : many orders)

2. Order contains items
   orders → order_items (1 order : many items)

3. Items link to products and sellers
   order_items → products (many-to-one)
   order_items → sellers (many-to-one)

4. Order has payments
   orders → order_payments (1 order : many payments)

5. Order gets reviewed
   orders → order_reviews (1 order : 0-1 review)

6. Category lookup
   products → category_translation (many-to-one)

7. Geographic lookup
   geolocation (standalone)
```

---

## 📈 Data Statistics

| Table | Estimated Records | Purpose |
|-------|-------------------|---------|
| customers | 99,441 | Unique customers |
| orders | 99,441 | Total orders |
| order_items | 112,650 | Line items (avg 1.13 per order) |
| order_payments | 99,441+ | Payment records |
| order_reviews | ~80,000 | Customer reviews (~80% review rate) |
| sellers | 3,095 | Unique sellers |
| products | 32,951 | Unique products |
| category_translation | 71 | Product categories |
| geolocation | 29,353 | Unique zip codes |

---

## 💡 Common Query Patterns

### Revenue Analysis
```sql
SELECT order_items.price + order_items.freight_value as total
FROM order_items
JOIN orders ON orders.order_id = order_items.order_id
WHERE orders.order_status = 'delivered'
```

### Customer Lifetime Value
```sql
SELECT customer_id, SUM(price + freight_value) as lifetime_value
FROM order_items
JOIN orders USING (order_id)
WHERE orders.order_status = 'delivered'
GROUP BY customer_id
```

### Seller Performance
```sql
SELECT seller_id, 
       AVG(review_score) as avg_rating,
       SUM(price + freight_value) as revenue
FROM order_items
LEFT JOIN order_reviews ON order_items.order_id = order_reviews.order_id
GROUP BY seller_id
ORDER BY revenue DESC
```

### Delivery Performance by State
```sql
SELECT customer_state,
       AVG(order_delivered_customer_date - order_estimated_delivery_date) as avg_delay
FROM orders
JOIN customers USING (customer_id)
WHERE order_status = 'delivered'
GROUP BY customer_state
ORDER BY avg_delay DESC
```

### Category Performance
```sql
SELECT category_translation.product_category_name_english,
       COUNT(DISTINCT order_items.order_id) as orders,
       SUM(order_items.price + order_items.freight_value) as revenue,
       AVG(order_reviews.review_score) as avg_rating
FROM order_items
JOIN products USING (product_id)
LEFT JOIN category_translation ON products.product_category_name = category_translation.product_category_name
LEFT JOIN order_reviews ON order_items.order_id = order_reviews.order_id
GROUP BY category_translation.product_category_name_english
ORDER BY revenue DESC
```

---

## 📋 Notes & Constraints

1. **Nullable Fields:** Many fields are nullable; use `COALESCE()` in queries to handle NULL values
2. **Composite Keys:** `order_items` and `order_payments` use composite primary keys
3. **Safe Primary Key:** `order_reviews` uses BIGSERIAL auto-increment to avoid null PK issues
4. **Payment Types:** Not all orders have corresponding reviews
5. **Delivery Dates:** Calculate delays as: `order_delivered_customer_date - order_estimated_delivery_date`
6. **Timestamps:** All timestamps are in Brazilian timezone (stored as UTC)
7. **Currency:** All monetary values in Brazilian Real (R$)
8. **Status Values:** Standardized status values for order_status field
9. **Freight Costs:** Separate from product price; combine for total order value
10. **Seller-Product Relationship:** Same product can be sold by multiple sellers at different prices

---

## 🔍 Data Quality Notes

- **Missing Reviews:** Not all orders have customer reviews (NULL review_score)
- **Incomplete Addresses:** Some zip codes/cities may be NULL
- **Timestamp Consistency:** All dates follow YYYY-MM-DD HH:MM:SS format
- **Zero Values:** Some measurements (weight, dimensions) may be 0 or NULL
- **Duplicate Handling:** Customer_id + unique_id combination should be unique but verify in analysis

---

## 🎯 Use Cases

This schema supports analysis for:
- Revenue trends and forecasting
- Customer segmentation and retention
- Product performance and category analysis
- Seller/vendor evaluation and ranking
- Logistics and delivery performance optimization
- Payment method analysis and optimization
- Geographic market analysis
- Cohort analysis and customer lifetime value
- Customer satisfaction trends
- Fraud detection and anomaly analysis

---

**Last Updated:** May 4, 2026  
**Database Version:** 1.0  
**Total Tables:** 9  
**Status:** ✅ Production Ready
