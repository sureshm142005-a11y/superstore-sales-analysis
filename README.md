# 🛒 Superstore Sales Analysis
## End-to-End SQL Data Cleaning & Business Intelligence Project

> **Author:** M SureshKumar  
> **Role:** SQL / Data Analyst Candidate  
> **Date:** June 2024  
> **Tools:** PostgreSQL, pgAdmin, Advanced SQL (CTEs, Window Functions)

---

## 📄 Full Project Report
👉 **[Download the Complete PDF Report Here](./Superstore_Sales_Analysis_SQL_Project.pdf)**
*(Contains full methodology, data validation steps, detailed analysis, and strategic recommendations)*

---

## 🎯 Project Objective
Analyzed 9,994 retail transactions to identify profitability drivers and root causes of losses using advanced SQL techniques. The goal was to transform raw data into actionable business intelligence.

---

## 🔍 Key Insights Discovered
- **Total Revenue:** ₹22.96 Lakhs with **12.46% Profit Margin**.
- **Critical Finding:** The **Central Region** underperformed significantly due to excessive discounting (24%) on high-cost items.
- **Root Cause:** "Tables" sub-category lost money (**-8.56% margin**) despite moderate discounts because **product costs were too high**.
- **State-Level Issue:** **Texas** was the biggest driver of losses (-15.14% margin) with a 37% average discount.

---

## 💡 Strategic Recommendations
1. **Reduce Discounts in Central Region:** Target Texas specifically; reduce discounts from 37% to <15%.
2. **Product Strategy:** Stop aggressive promotion of "Tables" without price adjustments. Maintain higher discounts only on low-cost items (Paper/Labels).
3. **Policy Change:** Implement product-specific discount policies instead of uniform regional discounts.

---

## 🛠️ Technical Skills Demonstrated
- **Data Modeling:** Schema design, Data Types (`DECIMAL`, `VARCHAR`), Constraints.
- **Data Cleaning:** NULL handling, Duplicate removal, Validation logic.
- **Advanced SQL:** 
  - Common Table Expressions (CTEs)
  - Window Functions (`RANK`, `PARTITION BY`)
  - Nested Subqueries
  - Conditional Logic (`CASE WHEN`)

---

## 📂 File Structure
| File Name | Description |
| :--- | :--- |
| `01_schema_and_loading.sql` | Database creation and initial data loading scripts. |
| `02_validation_cleaning.sql` | Data quality checks, NULL validation, and duplicate removal. |
| `03_analysis_queries.sql` | Business analysis queries including CTEs and Window Functions. |
| `Superstore_Sales_Analysis_SQL_Project.pdf` | **The full detailed project report containing analysis, findings, and recommendations.** |

---

*Project completed by M SureshKumar | [Link to LinkedIn Profile]*
