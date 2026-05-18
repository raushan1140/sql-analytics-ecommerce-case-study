# 📊 Business Insights from 15 SQL Analytics Queries

**Analysis Period:** September 2016 - August 2018  
**Data Source:** Brazilian E-Commerce Database (99,441+ orders)  
**Last Updated:** May 4, 2026

---

## 🎯 Executive Summary

This analysis reveals a business experiencing explosive growth (26,400% in launch month) followed by market maturation. While the platform achieved 7,289 monthly orders by peak (November 2017), it now operates in a plateau phase with **critical retention challenges**. Key findings:

✅ **Strengths:** Exceptional logistics (all states deliver early), strong customer satisfaction (4.0+ stars), diverse product portfolio  
⚠️ **Critical Issues:** Zero repeat customer retention, geographic concentration risk (15% of customers in São Paulo), regional freight burden (17.26% in Northeast)  
📈 **Opportunities:** Premium market expansion, logistics optimization, retention program launch

---

## 📈 Query 1: Revenue by Month

**What it shows:**  
Revenue grew explosively from $143 (Sept 2016) to a peak of $1,153,364 in November 2017 (7,289 orders), then stabilized around $1M monthly in 2018, indicating rapid scaling to market maturity followed by plateau phase.

**Business Action:**  
Investigate root causes of post-November 2017 plateau (market saturation, competitive pressure, seasonality) and replicate November's success formula (likely holiday campaign) for future growth; develop initiatives to break the stabilization plateau and reignite expansion.

**SQL File:** Query_01_Revenue_by_Month.sql

---

## 📊 Query 2: Top 10 Product Categories

**What it shows:**  
Health & Beauty dominates with $1,263,138 revenue (8,836 orders, 4.11⭐ rating), followed by Watches & Gifts ($1,206,075, premium $200 avg price) and Bed & Bath ($1,050,936, highest volume 9,417 orders but lower 3.85⭐ rating). Top 3 categories = 46% of revenue.

**Business Action:**  
Allocate 50% of marketing budget to the Health & Beauty category (proven revenue engine with excellent ratings), investigate quality issues in Bed & Bath (high volume but lowest rating suggests product-market gap), and create bundle promotions linking premium Watches & Gifts with mid-tier Sports & Leisure to increase average order value.

**SQL File:** Query_02_Top_Categories.sql

---

## 🚚 Query 3: Average Delivery Delay by State

**What it shows:**  
Exceptional logistics performance: ALL 27 states deliver ahead of estimated dates on average (ranging from -7.9 days in Alagoas to -19.8 days in Acre). São Paulo leads at scale with 40,494 orders and only 5.9% late delivery rate, while remote states achieve 2.9-4.5% late rates despite extreme distances.

**Business Action:**  
Capitalize on this logistics advantage in marketing (emphasize "early delivery" guarantee), maintain current carrier relationships and performance standards, and use this competitive advantage to expand into geographically dispersed markets where logistics reliability is a key differentiator.

**SQL File:** Query_03_Delivery_Delay_by_State.sql

---

## ⭐ Query 4: Review Score vs Delivery Time

**What it shows:**  
Strong correlation between delivery speed and satisfaction: On-time deliveries average 4.27⭐ (82.2% positive reviews) with 89,936 orders, while 1-5 days late drops to 2.94⭐ (44.5% positive), and 6+ days late collapses to 1.66-1.71⭐ (12% positive). Each delay category = 31-61% satisfaction drop.

**Business Action:**  
Implement strict delivery KPIs (95% on-time target) and create seller incentive programs rewarding early delivery, establish automated alerts when orders approach late status, and justify any logistics investment to executives with this data showing direct impact on customer retention and satisfaction.

**SQL File:** Query_04_Reviews_vs_Delivery.sql

---

## 🔄 Query 5: Customer Retention Rate

**What it shows:**  
CRITICAL FINDING: Zero repeat customers among 96,478 total. 100% of customers are one-time buyers with retention rate of 0.00% and average purchases per customer of exactly 1.00. This applies across all time periods and customer segments.

**Business Action:**  
Launch urgent retention initiatives: implement a loyalty program offering 10% discount on 2nd purchase, create post-delivery email campaigns within 7 days recommending complementary products, conduct customer surveys to understand purchase barriers to repeat buying, and set monthly KPI to move retention from 0% to at least 5% within 6 months.

**SQL File:** Query_05_Retention_Rate.sql

---

## 💳 Query 6: Revenue by Payment Type

**What it shows:**  
Credit card dominates with 75.6% of revenue ($12.1M from 74,304 orders), averaging $162.24 per transaction with 3.50 installment options (EMI). Boleto payments = 17.3% ($2.77M, $144.33 avg), voucher = 2.1%, debit = 1.3%. EMI-enabled credit card drives 12.4% higher average transaction value vs. single-payment boleto.

**Business Action:**  
Negotiate better credit card processing rates leveraging 3/4 revenue volume, expand EMI (buy-now-pay-later) options on larger purchases >$500 to enable higher-value transactions, and test promotional campaigns emphasizing installment payment options to drive higher average order values across customer segments.

**SQL File:** Query_06_Revenue_by_Payment_Type.sql

---

## 🏆 Query 7: Seller Performance Ranking

**What it shows:**  
Top seller (São Paulo) = $249,640 revenue (1,132 orders, 4.09⭐). Extreme geographic concentration: 17 of top 20 sellers from São Paulo, only 4 outside. Quality variance significant (3.33⭐ to 4.43⭐). Premium sellers (high avg price) consistently achieve 78-87% positive reviews vs. volume sellers at 66-75%.

**Business Action:**  
Create tiered seller program with "Premium Seller" status (20% lower commission for 4.2+ rating + $10K monthly GMV) to reward quality, diversify seller base by recruiting quality sellers outside SP with targeted incentives, and provide underperforming mid-tier sellers (#2 seller at 3.33⭐) with customer service and logistics coaching to improve ratings.

**SQL File:** Query_07_Seller_Performance.sql

---

## ❌ Query 8: Return/Cancellation Rate by Category

**What it shows:**  
Cancellation rates remarkably low across portfolio (mostly <1%, only pc_gamer at 11.11%). BUT: high-volume categories show significant quality complaints despite low cancellation—Sports & Leisure (7,720 orders, 86 complaints), Toys (3,886 orders, 41 complaints), Bed & Bath (9,417 orders, 73 complaints). Quality complaints ≠ refunds = customer dissatisfaction without returns.

**Business Action:**  
Audit quality of high-complaint categories (Sports & Leisure, Toys) with supplier reviews, implement enhanced QC for fragile goods (Bed & Bath), and establish maximum complaint rate KPIs by category; investigate low-cancellation categories (Books, Fashion) to replicate their quality standards across portfolio.

**SQL File:** Query_08_Returns_by_Category.sql

---

## ⏰ Query 9: Peak Order Hours/Days

**What it shows:**  
Clear ordering patterns: Tuesday 2 PM peaks at 1,095 orders, with strong performance Monday afternoon-evening (2 PM, 4 PM, 9 PM) and Wednesday afternoon (11 AM-4 PM). Evening hours (8-9 PM) show secondary peaks. Weekends absent from top 20 time slots. Order values consistent $135-147 across all times (no time-based price variation).

**Business Action:**  
Schedule promotional campaigns and flash sales for Tuesday 2 PM and Monday 9 PM to maximize impact, scale server capacity for 2-10 PM window daily, test Sunday morning flash deals to drive engagement on historically slow day, and run targeted email campaigns at peak times when customers are most active.

**SQL File:** Query_09_Peak_Order_Times.sql

---

## 🗺️ Query 10: City-wise Customer Concentration

**What it shows:**  
São Paulo = 15.13% of customers (15,045), Rio = 6.64% (6,601). Top 5 cities = 27.56% of base. Geographic risk: 1/3 of market concentrated in São Paulo + Rio. BUT opportunity: Northeast/North cities show 30-60% higher spending ($150-196 AOV) vs. São Paulo mass market ($121 AOV), despite lower volume.

**Business Action:**  
Develop geographic expansion strategy prioritizing high-AOV Northeast cities (Fortaleza $162, Recife $160) with localized marketing campaigns, optimize logistics to these premium markets to capitalize on spending power, and diversify customer base away from SP/RJ concentration to reduce business risk.

**SQL File:** Query_10_City_Distribution.sql

---

## 💰 Query 11: Average Order Value by State

**What it shows:**  
Inverse relationship: Remote states (Paraíba $235, Alagoas $219) show 89% higher AOV than São Paulo ($124), but with freight burden 2-3x higher ($35-43 vs. $15-22). Paradox: highest AOV states = LOWEST satisfaction expectations (4.0+ stars despite premium prices), while low-AOV Southeast states struggle with satisfaction (3.69⭐ RJ).

**Business Action:**  
Implement regional pricing strategy with freight surcharges in remote areas to recover 2-3x logistics costs, develop premium product catalogs for high-AOV Northeast/North regions, and investigate why remote customers are MORE satisfied despite higher prices—potential competitive advantage in price-sensitive Southeast market.

**SQL File:** Query_11_AOV_by_State.sql

---

## 💵 Query 12: Product Price vs Review Score

**What it shows:**  
SURPRISING: Rating consistency across price ranges (3.89-4.01⭐, only 0.12 point variance). Budget products ($31 avg) and luxury ($1,588 avg) receive virtually identical satisfaction. Mid-range ($50-150) dominates volume (51,481 items = 38% of sales, highest volume). Above $1000 shows slight satisfaction decline (3.89⭐) suggesting unmet premium expectations.

**Business Action:**  
Focus marketing and inventory investment on mid-range ($50-150) segment as volume engine with proven satisfaction, investigate premium product quality (>$1000) showing slight satisfaction decline—potential quality consistency issue, and test aggressive pricing in budget segment (<$50) as satisfaction is equal to premium items.

**SQL File:** Query_12_Price_vs_Reviews.sql

---

## 📦 Query 13: Freight Cost as % of Order Value

**What it shows:**  
Regional freight inequality: Northeast 17.26% of order value, North/Central 16.72%, South 15.03%, Southeast 13.11% (most efficient). Every 1% difference = ~$100K annual margin impact. Northeast pays 4.15% MORE freight than Southeast = 30% higher burden. This directly reduces regional profitability despite Southeast shipping more absolute volume (73,507 items).

**Business Action:**  
Renegotiate carrier contracts with focus on remote region rates (Northeast/North 2-3x worse than SE), consider regional distribution hubs to reduce Northeast/North freight burden, implement regional pricing strategy with freight surcharges transparent to customers, and prioritize logistics optimization for high-AOV remote markets where freight burden is eating profitability.

**SQL File:** Query_13_Freight_Margin.sql

---

## 📈 Query 14: Month-over-Month Growth Rate

**What it shows:**  
Business lifecycle clearly visible: Launch explosion (Oct 2016 +26,400%), rapid scaling (Feb-Mar 2017 +120%, +54%), maturation plateau (Aug-Oct 2017 +8%, -1%, +8%), peak spike (Nov 2017 +62.77% holiday season), post-peak decline (Dec 2017 -24%), then stabilization at 6-7K monthly orders averaging -0.72% to +3.12% growth rate through Aug 2018.

**Business Action:**  
Analyze what drove November 2017 spike (seasonal, campaign, external event) to replicate success; develop new growth initiatives to break plateau—new product categories, geographic expansion, retention programs; investigate competitive landscape changes in mid-2017 that may have triggered slowdown; set aggressive growth target to break 7K monthly order ceiling.

**SQL File:** Query_14_MoM_Growth.sql

---

## 👥 Query 15: Cohort Analysis - First Purchase Month vs Repeat

**What it shows:**  
CRITICAL ISSUE CONFIRMED: All cohorts from Sept 2016 through Aug 2018 show 0.00% repeat purchase rate. Even October 2016 customers (20+ months later) haven't purchased again. Customer lifetime value = single transaction only ($143-175 for early cohorts, declining to $155-167 recent cohorts). No cohort escapes this pattern—universal one-time buyer behavior.

**Business Action:**  
This validates Query 5 finding and signals urgent need for comprehensive retention overhaul: implement customer lifecycle email program beginning Day 1 post-purchase, create win-back campaigns targeting dormant customers 30/60/90 days after purchase, test referral incentives to convert buyers into advocates, and establish retention metrics as key business KPI (target: 5% repeat rate within 12 months).

**SQL File:** Query_15_Cohort_Analysis.sql

---

## 🎯 Key Takeaways & Strategic Recommendations

### Immediate Priorities (0-3 months):
1. **URGENT: Launch retention program** - 0% repeat rate is existential risk to business sustainability
2. **Quality assurance** - High-volume categories (Sports, Toys, Bed & Bath) have significant complaints
3. **Logistics optimization** - Northeast/North freight burden reducing profitability despite high AOV

### Medium-term (3-6 months):
4. **Geographic expansion** - Capitalize on high-AOV Northeast markets (Fortaleza, Recife)
5. **Growth breakout** - Break plateau at 7K monthly orders through new initiatives
6. **Seller network** - Expand outside São Paulo, elevate quality underperformers

### Strategic (6-12 months):
7. **Category optimization** - Health & Beauty is winner, focus on fixing Bed & Bath quality
8. **Regional pricing** - Implement freight-aware pricing in high-cost logistics regions
9. **Customer lifetime value** - Move from $160 one-time value to $500+ repeat customer value through retention

---

## 📊 Analysis Methodology

- **Database:** Brazilian E-Commerce Platform (Supabase PostgreSQL)
- **Tables Analyzed:** customers, orders, order_items, order_payments, order_reviews, products, sellers, category_translation, geolocation
- **Time Period:** September 2016 - August 2018
- **Total Records:** 99,441 orders, 96,478 unique customers, 112,650 order line items
- **Tools:** PostgreSQL SQL queries with aggregation, time-series analysis, cohort analysis, regional analysis

---

