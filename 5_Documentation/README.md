# Brazilian E-Commerce SQL Analytics Case Study

## 📊 Overview

A comprehensive **SQL analytics project** analyzing 99,441 e-commerce orders to answer critical business questions about returns, profitability, and customer behavior.

**Key Discovery:** 🚨 **0% customer retention rate** - all customers are one-time buyers

---

## 📦 Dataset

- **Source:** [Kaggle - Brazilian E-Commerce Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
- **Time Period:** September 2016 - August 2018
- **Orders:** 99,441 total
- **Customers:** 96,478 unique
- **Products:** 32,951 items
- **Sellers:** 3,095 merchants
- **Cities:** 4,119 across 27 states

---

## 🗂️ Project Structure

```
1_Dataset/                    → 9 CSV files (original data)
2_SQL_Queries/                → 15 analytical queries
3_ERD_and_Schema/             → Database design & schema
4_Business_Insights/          → Analysis findings & recommendations
5_Documentation/              → This folder
```

---

## 📋 15 Queries Included

| # | Question | Key Finding |
|---|----------|-------------|
| 1 | Revenue by month | Peak: $1.15M (Nov 2017) |
| 2 | Top 10 categories | Health & Beauty: 46% of revenue |
| 3 | Delivery delays | ALL states deliver EARLY |
| 4 | Reviews vs delivery | On-time: 4.27⭐ vs Late: 1.66⭐ |
| 5 | Customer retention | **0% repeat rate** 🚨 |
| 6 | Payment methods | Credit card: 75.6% of revenue |
| 7 | Seller performance | Top seller: $249.6K |
| 8 | Returns by category | Cancellation <1%, but quality complaints |
| 9 | Peak order times | Tuesday 2 PM peaks (1,095 orders) |
| 10 | City concentration | São Paulo: 15% of customers |
| 11 | AOV by state | Remote states: +89% higher |
| 12 | Price vs reviews | Consistent 3.89-4.01⭐ across prices |
| 13 | Freight margin | Northeast: 17.26% of order value |
| 14 | Month-over-month growth | Growth plateau at 6-7K orders/month |
| 15 | Cohort retention | All cohorts: 0.00% repeat rate |

---

## 🎯 Key Insights

### Critical Issue
**Zero Repeat Customer Retention** - Every customer is a one-time buyer. This is unsustainable and requires immediate retention program launch.

### Strengths
- Exceptional logistics: ALL states deliver ahead of estimate
- High satisfaction when delivered on-time (4.27⭐)
- Strong category performers (Health & Beauty)
- Healthy $1.15M monthly revenue peak

### Opportunities
- Northeast markets show +89% higher AOV
- Growth plateau at 6-7K orders/month can be broken
- Retention program could add $32M+ annually
- Geographic expansion beyond São Paulo concentration

---

## 📈 Strategic Recommendations

**Immediate (0-3 months):**
1. Launch customer retention program (0% → 5% target)
2. Quality assurance for high-volume categories
3. Optimize Northeast/North freight costs

**Medium-term (3-6 months):**
4. Geographic expansion to high-AOV Northeast cities
5. New growth initiatives to break 7K/month plateau
6. Diversify seller network outside São Paulo

**Long-term (6-12 months):**
7. Move customer lifetime value from $160 → $500+
8. Implement regional pricing strategy
9. Build data-driven decision culture

---

## 🚀 How to Access Results

### Option 1: Read Insights (No Setup Required) ✅
Open `4_Business_Insights/Business_Insights.md` for all findings with recommendations.

### Option 2: View SQL Queries
All queries available in `2_SQL_Queries/` folder with detailed comments.

### Option 3: Run Queries Yourself
1. Download CSV files from `1_Dataset/`
2. Create Supabase project (free at https://supabase.com)
3. Import all 9 CSVs
4. Copy-paste queries from `2_SQL_Queries/` into SQL editor
5. Execute and analyze results

---

## 💻 Technology Stack

| Component | Tool |
|-----------|------|
| Database | PostgreSQL (Supabase) |
| Query Language | SQL |
| Analysis | 15 analytical queries |
| Documentation | Markdown |
| Dataset | Kaggle (Brazilian E-Commerce) |

---

## 📊 Database Schema

**9 Tables:**
- customers (demographics)
- orders (order headers)
- order_items (line items)
- order_payments (payment info)
- order_reviews (ratings/comments)
- products (product catalog)
- sellers (seller information)
- category_translation (category names)
- geolocation (city/location data)

**View full schema:** See `3_ERD_and_Schema/Schema_Documentation.md`

---

## ✅ Deliverables

- ✅ 15 SQL analytical queries
- ✅ Comprehensive business insights
- ✅ Database schema documentation
- ✅ Entity relationship diagram
- ✅ Strategic recommendations
- ✅ Professional documentation

---

## 📞 Project Details

- **Analysis Period:** September 2016 - August 2018
- **Total Records:** 412,000+
- **Queries:** 15 analytical
- **Insights:** All 15 queries analyzed with business recommendations
- **Skills Demonstrated:** SQL, data analysis, business intelligence

---

## 📚 Quick Start

1. **For executives:** Read "Key Insights" section above
2. **For analysts:** Open `4_Business_Insights/Business_Insights.md`
3. **For data scientists:** Check `2_SQL_Queries/` for SQL code
4. **For database folks:** Review `3_ERD_and_Schema/` for design

---

## 🎯 Next Steps

To explore this project:
1. Review the 15 queries summary table above
2. Read detailed findings in `4_Business_Insights/`
3. Examine SQL code in `2_SQL_Queries/`
4. Understand schema in `3_ERD_and_Schema/`

---

**Status:** ✅ Analysis Complete | Ready for Review | Portfolio Quality

---

## 👤 Author

**Raushan Raj**
- Email: raj.raushan9101@gmail.com
- GitHub: https://github.com/raushan1140/
- Project Date: May 18, 2026

---

For detailed analysis, see the [Business Insights](../4_Business_Insights/Business_Insights.md) document.
