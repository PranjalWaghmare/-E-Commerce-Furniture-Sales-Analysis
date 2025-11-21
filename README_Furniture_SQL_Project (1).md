# 🪑 Furniture Sales SQL Analysis

## 📘 Project Overview
This project performs **SQL-based exploratory data analysis (EDA)** on an e-commerce furniture dataset named  
`ecommerce_furniture_dataset_2024 (2).csv`.  

The goal is to derive business insights such as:
- Discounts and pricing trends  
- Best-selling products  
- Revenue and sales distribution  
- Tag-wise product analysis  

The analysis was implemented using **SQLite/MySQL-style queries** and visualized in structured report formats (DOCX and PDF).

---

## 🧾 Dataset Description

| Column Name     | Description |
|-----------------|-------------|
| `productTitle`  | Name of the furniture item. |
| `originalPrice` | Original MRP of the product before discount. |
| `price`         | Current selling price after discount. |
| `sold`          | Number of units sold. |
| `tagText`       | Tags or labels like “Free Shipping”, “Discounted”, etc. |

---

## 🧠 SQL Tasks Performed

### 1. Preview Input Data
```sql
SELECT * FROM furniture_sales LIMIT 10;
```

### 2. Calculate Discount Percentage
```sql
SELECT productTitle, originalPrice, price,
       ROUND(((originalPrice - price) / originalPrice) * 100, 2) AS discount_percent
FROM furniture_sales;
```

### 3. Top 10 Best-Selling Products
```sql
SELECT productTitle, sold, price, (sold * price) AS total_revenue
FROM furniture_sales
ORDER BY sold DESC
LIMIT 10;
```

### 4. Count Products by Tag
```sql
SELECT tagText, COUNT(*) AS total_products
FROM furniture_sales
GROUP BY tagText
ORDER BY total_products DESC;
```

### 5. Average Discount Across All Products
```sql
SELECT ROUND(AVG((originalPrice - price) / NULLIF(originalPrice,0) * 100), 2) AS avg_discount_percent
FROM furniture_sales;
```

### 6. Total Revenue and Total Units Sold
```sql
SELECT SUM(sold) AS total_units_sold,
       SUM(sold * price) AS total_revenue
FROM furniture_sales;
```

### 7. Products with No Discount
```sql
SELECT productTitle, originalPrice, price
FROM furniture_sales
WHERE originalPrice = price;
```

### 8. Top 10 Highest Discounted Products
```sql
SELECT productTitle, originalPrice, price,
       ROUND(((originalPrice - price) / originalPrice) * 100, 2) AS discount_percent
FROM furniture_sales
ORDER BY discount_percent DESC
LIMIT 10;
```

### 9. Group Products by Price Range
```sql
SELECT CASE
         WHEN price < 5000 THEN 'Below 5K'
         WHEN price BETWEEN 5000 AND 10000 THEN '5K–10K'
         WHEN price BETWEEN 10001 AND 20000 THEN '10K–20K'
         ELSE 'Above 20K'
       END AS price_range,
       COUNT(*) AS total_products
FROM furniture_sales
GROUP BY price_range;
```

### 10. Revenue by Tag
```sql
SELECT tagText, SUM(sold * price) AS total_revenue
FROM furniture_sales
GROUP BY tagText
ORDER BY total_revenue DESC;
```

---

## 📊 Outputs

- **DOCX Report:** `furniture_sql_report.docx`  
- **PDF Report:** `furniture_sql_report.pdf`

Each report includes:
- Input dataset preview  
- All SQL queries and their corresponding outputs  
- Summary metrics (total revenue, units sold, average discount, top-selling product)

---

## 🧩 Summary Insights

From the analysis:
- The total units sold and revenue were aggregated from the `sold` and `price` fields.  
- Average discounts were computed to assess pricing strategies.  
- Tag-based revenue and product distribution revealed performance of special categories (like *Free Shipping* or *Discounted*).  
- The top-selling product and top discounted items were identified using SQL ranking and aggregation.

---

## ⚙️ Tools & Technologies

- **SQL (SQLite / MySQL compatible)**
- **Python** (for automation & document generation)
- **Pandas**, **SQLite3**, **python-docx**, **ReportLab**
- **Dataset Source:** E-commerce Furniture Sales Dataset (2024)

---

## 📁 Project Files

| File Name | Description |
|------------|-------------|
| `ecommerce_furniture_dataset_2024 (2).csv` | Input dataset used for SQL analysis |
| `furniture_sql_report.docx` | Detailed SQL analysis report in Word format |
| `furniture_sql_report.pdf` | Final polished PDF report |
| `README.md` | Project documentation and SQL details |

---

## 📌 Author Notes

- All data and results are for educational and analytical purposes.  
- No personally identifiable information or brand data is included.  
- This project is anonymized as requested.  

---
