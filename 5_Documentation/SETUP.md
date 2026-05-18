# 🔧 Setup Instructions - Supabase Edition

Complete guide to set up and run this SQL Analytics project using **Supabase** (PostgreSQL cloud).

---

## 📋 Prerequisites

Before starting, ensure you have:

- ✅ A computer (Windows, Mac, or Linux)
- ✅ Internet connection
- ✅ A web browser
- ✅ Free Supabase account
- ✅ **No local installation required!** ☁️

---

## 🚀 Option 1: View Results (Easiest - No Setup)

**For decision makers, analysts, or anyone who just wants to see findings:**

1. Open this file: `4_Business_Insights/Business_Insights.md`
2. Read all 15 findings with business recommendations
3. Done! ✅

**Time required:** 15 minutes

---

## 🔍 Option 2: View SQL Queries (No Setup)

**For data engineers or SQL enthusiasts:**

1. Browse folder: `2_SQL_Queries/`
2. Open any `.sql` file
3. Review the SQL code and logic
4. Done! ✅

**Time required:** 10-30 minutes depending on which queries you examine

---

## ☁️ Option 3: Run Queries in Supabase (Recommended - 30 Minutes)

**This project was built with Supabase. Follow these steps to replicate the exact setup:**

### Step 1: Create Supabase Account
1. Go to: https://supabase.com
2. Click **"Start Your Project"**
3. Sign up with:
   - GitHub account (easiest), OR
   - Email address
4. Verify your email
5. Skip email verification if prompted

### Step 2: Create New Supabase Project
1. Dashboard → Click **"New Project"**
2. Fill in:
   - **Project Name:** `ecommerce-analytics`
   - **Database Password:** Create strong password (save it!)
   - **Region:** Choose closest to you
   - **Pricing Plan:** Free tier (sufficient)
3. Click **"Create New Project"**
4. Wait 2-3 minutes for initialization ⏳

### Step 3: Create Database Tables

1. In Supabase dashboard, go to **"SQL Editor"** (left sidebar)
2. Click **"New Query"**
3. Open file on your computer: `3_ERD_and_Schema/Schema.sql`
4. Copy all SQL code (Ctrl+A → Ctrl+C)
5. Paste into Supabase SQL Editor
6. Click **"Run"** button (blue triangle icon)
7. Wait for completion ✅ (should see green checkmarks)

**Expected result:** 9 tables created successfully

### Step 4: Import CSV Files to Database

1. Go to **"Table Editor"** (left sidebar)
2. For EACH CSV file in `1_Dataset/` folder:

   **For Customers:**
   - Click **"+"** button → **"Import Data"**
   - Choose file: `1_Dataset/olist_customers_dataset.csv`
   - Click **"Import"** → Wait ✅

   **For Products:**
   - Click **"+"** button → **"Import Data"**
   - Choose file: `1_Dataset/olist_products_dataset.csv`
   - Click **"Import"** → Wait ✅

   **Repeat for all 9 files** (in any order):
   - olist_customers_dataset.csv
   - olist_products_dataset.csv
   - olist_sellers_dataset.csv
   - olist_orders_dataset.csv
   - olist_order_items_dataset.csv
   - olist_order_payments_dataset.csv
   - olist_order_reviews_dataset.csv
   - product_category_name_translation.csv
   - olist_geolocation_dataset.csv

**Note:** Files import best when no foreign key constraints are violated. Import in order above if errors occur.

### Step 5: Verify Data Import

In SQL Editor, run this query to verify all tables have data:

```sql
SELECT 'customers' as table_name, COUNT(*) as row_count FROM customers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'order_payments', COUNT(*) FROM order_payments
UNION ALL
SELECT 'order_reviews', COUNT(*) FROM order_reviews
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'sellers', COUNT(*) FROM sellers
UNION ALL
SELECT 'category_translation', COUNT(*) FROM category_translation
UNION ALL
SELECT 'geolocation', COUNT(*) FROM geolocation;
```

**Expected results:**
- customers: 99,441
- orders: 99,441
- order_items: 112,650
- order_payments: 103,886
- order_reviews: 98,979
- products: 32,951
- sellers: 3,095
- category_translation: 71
- geolocation: 29,945

### Step 6: Run Analytics Queries

1. Go to **"SQL Editor"**
2. Click **"New Query"**
3. Open any SQL file from `2_SQL_Queries/` folder
4. Copy query code
5. Paste into Supabase SQL Editor
6. Click **"Run"**
7. View results in bottom panel ✅

**Example queries to try:**
- Query_01_Revenue_by_Month.sql
- Query_05_Retention_Rate.sql
- Query_15_Cohort_Analysis.sql

**Time required:** 30-45 minutes

---

## 💻 Option 4: Local PostgreSQL Setup (Advanced)

**For developers who prefer local database:**

### Prerequisites
- PostgreSQL 12+ installed
- pgAdmin or DBeaver (optional)
- 2GB free disk space

### Setup Steps

1. **Install PostgreSQL**
   ```bash
   # Windows
   Download: https://www.postgresql.org/download/windows/
   
   # macOS
   brew install postgresql
   
   # Linux (Ubuntu)
   sudo apt-get install postgresql postgresql-contrib
   ```

2. **Create Database**
   ```bash
   createdb ecommerce_analytics
   ```

3. **Load Schema**
   ```bash
   psql ecommerce_analytics < 3_ERD_and_Schema/Schema.sql
   ```

4. **Import CSV Files**
   ```bash
   psql ecommerce_analytics -c "\COPY customers FROM '1_Dataset/olist_customers_dataset.csv' WITH (FORMAT csv, HEADER true)"
   # Repeat for all 9 files
   ```

5. **Run Queries**
   ```bash
   psql ecommerce_analytics < 2_SQL_Queries/Query_01_Revenue_by_Month.sql
   ```

**Time required:** 45-60 minutes + PostgreSQL installation

---

## ✅ Verification Checklist

After setup, verify everything works:

- [ ] All 9 CSV files imported to database
- [ ] All tables have correct number of rows
- [ ] Foreign key relationships work
- [ ] Can run at least one query successfully
- [ ] Results match expected data types

---

## 🐛 Troubleshooting

### Issue: "CSV file format error"
**Solution:** Ensure CSV files have proper column headers matching `Schema.sql`

### Issue: "Foreign key constraint violation"
**Solution:** Import tables in correct order (customers → orders → order_items first)

### Issue: "File not found"
**Solution:** Ensure relative paths are correct from your working directory

### Issue: "Connection refused" (local PostgreSQL)
**Solution:** 
```bash
# Check if PostgreSQL is running
pg_isready
# Should show: accepting connections

# If not, start PostgreSQL
pg_ctl start
```

### Issue: "Out of memory"
**Solution:** CSV files are large (~500 MB total). Ensure 2GB free disk space.

---

## 📊 Validation Queries

After importing all data, run these to validate:

```sql
-- Check row counts
SELECT COUNT(*) FROM customers;      -- Should be: 99,441
SELECT COUNT(*) FROM orders;         -- Should be: 99,441
SELECT COUNT(*) FROM order_items;    -- Should be: 112,650
SELECT COUNT(*) FROM products;       -- Should be: 32,951
SELECT COUNT(*) FROM sellers;        -- Should be: 3,095

-- Check foreign keys work
SELECT o.order_id, c.customer_id 
FROM orders o 
JOIN customers c ON o.customer_id = c.customer_id 
LIMIT 5;
```

---

## 🎯 Recommended Path

**For most users:**
1. Start with **Option 1** (View Business Insights)
2. If interested, try **Option 3** (Run Queries in Supabase)
3. Don't need Option 4 unless you're a database admin

---

## 📞 Quick Start (TL;DR)

1. Go to: https://supabase.com
2. Create free account
3. Create new project
4. Run SQL from: `3_ERD_and_Schema/Schema.sql`
5. Import 9 CSV files from: `1_Dataset/`
6. Run queries from: `2_SQL_Queries/`

**Total time:** 30 minutes

---

## 📚 Additional Resources

- **PostgreSQL Docs:** https://www.postgresql.org/docs/
- **Supabase Docs:** https://supabase.com/docs
- **SQL Tutorial:** https://www.w3schools.com/sql/
- **Kaggle Dataset:** https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

---

## ✨ Need Help?

Refer to main README: [../README.md](../README.md)

For detailed findings, see: [../4_Business_Insights/Business_Insights.md](../4_Business_Insights/Business_Insights.md)
