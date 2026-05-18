# 🔧 Setup Instructions

Complete guide to set up and run this SQL Analytics project.

---

## 📋 Prerequisites

Before starting, ensure you have:

- ✅ A computer (Windows, Mac, or Linux)
- ✅ Internet connection
- ✅ A web browser
- ✅ No local database installation needed!

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

## 🗄️ Option 3: Run Queries Yourself (30 Minutes)

**For analysts or data scientists who want to execute queries:**

### Step 1: Download Dataset
- Go to: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
- Click **"Download"**
- Extract CSV files to your computer
- **Note:** You'll need a Kaggle account (free)

### Step 2: Create Supabase Project
1. Go to: https://supabase.com
2. Click **"Start Your Project"**
3. Sign up with email/GitHub (free tier is enough)
4. Verify your email
5. Create new project:
   - **Project Name:** `ecommerce-analytics` (or your choice)
   - **Password:** Create a strong password
   - **Region:** Choose closest to you
6. Wait for project to initialize (2-3 minutes)

### Step 3: Create Database Tables
1. In Supabase, go to **SQL Editor**
2. Click **"New Query"**
3. Open file: `3_ERD_and_Schema/Schema.sql`
4. Copy all SQL code
5. Paste into Supabase SQL Editor
6. Click **"Run"** button
7. Wait for completion ✅

### Step 4: Import CSV Files
1. In Supabase, go to **Table Editor**
2. For each CSV file in `1_Dataset/`:
   - Click **"Create New Table"**
   - Select **"Import Data"**
   - Choose corresponding CSV file
   - Click **"Import"**
3. Import all 9 files in this order:
   - customers
   - products
   - sellers
   - orders
   - order_items
   - order_payments
   - order_reviews
   - category_translation
   - geolocation

### Step 5: Run Queries
1. In Supabase SQL Editor, create new query
2. Open SQL file from `2_SQL_Queries/` folder
3. Copy query code
4. Paste into Supabase
5. Click **"Run"**
6. View results ✅

**Time required:** 30-45 minutes

---

## 🛠️ Option 4: Local Database Setup (Advanced)

**For advanced users who want local PostgreSQL:**

### Prerequisites
- PostgreSQL 12+ installed
- pgAdmin or DBeaver (optional but helpful)
- 2GB free disk space

### Setup Steps

1. **Install PostgreSQL**
   ```bash
   # Windows
   Download from: https://www.postgresql.org/download/windows/
   
   # macOS
   brew install postgresql
   
   # Linux (Ubuntu/Debian)
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

**Time required:** 45-60 minutes + PostgreSQL installation time

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
