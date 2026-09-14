# 🛒 End-to-End Business Intelligence Solution — Olist E-Commerce

An end-to-end **Business Intelligence project** built using the **Olist Brazilian E-Commerce dataset**.

This project demonstrates a complete BI workflow — from **Python-based ETL and data transformation** to **MySQL data warehousing, SQL analysis, star-schema data modeling, DAX, and interactive Power BI dashboards**.

---

## 📌 Project Overview

The goal of this project is to transform raw e-commerce data into a structured Business Intelligence solution that helps analyze:

* Sales performance
* Customer behavior
* Product performance
* Product categories
* Geographic revenue distribution
* Revenue trends
* Business KPIs

### Business Questions

* What is the total revenue and how does it change over time?
* Which products and categories generate the most revenue?
* Which customers contribute the most revenue?
* Which customer states generate the highest revenue?
* What is the Average Order Value?
* How does customer purchasing behavior vary?
* Which products and customers perform above average?

---

## 🔄 End-to-End BI Workflow

```text
Raw Olist CSV Files
        ↓
Python ETL & Data Cleaning
        ↓
Star Schema Design
        ↓
MySQL Data Warehouse
        ↓
SQL Analysis
        ↓
DAX Measures
        ↓
Power BI Dashboard
        ↓
Business Insights
```

---

## 🛠️ Tech Stack

| Area                | Technology            |
| ------------------- | --------------------- |
| Data Cleaning & ETL | Python, Pandas, NumPy |
| Data Warehouse      | MySQL                 |
| Data Loading        | SQLAlchemy, PyMySQL   |
| Data Analysis       | SQL                   |
| Data Modeling       | Star Schema           |
| Calculations        | DAX                   |
| Visualization       | Power BI              |
| Version Control     | Git & GitHub          |

---

# 🗂️ Dataset

The project uses the **Olist Brazilian E-Commerce dataset**, containing information about:

* Customers
* Orders
* Order Items
* Products
* Product Categories
* Payments
* Reviews
* Sellers
* Geolocation

The required datasets were transformed into a structured analytical model for BI reporting.

---

# 🐍 Python ETL

Python was used to prepare and transform the raw Olist data before loading it into MySQL.

## ETL Process

### 1. Extract

Loaded the required Olist CSV files using Pandas.

### 2. Inspect

Performed initial inspection of:

* Dataset dimensions
* Column names
* Data types
* Summary statistics

### 3. Data Quality Checks

Checked for:

* Missing values
* Duplicate records
* Referential integrity
* Relationships between orders, customers, products, and order items

### 4. Clean

Handled data-quality issues and prepared consistent values for analytical use.

### 5. Transform

Performed transformations including:

* Joining order items with orders and products
* Creating `sales_amount`
* Extracting `year` and `month`
* Preparing fact and dimension tables

### 6. Validate

Validated:

* Dimension keys
* Foreign-key relationships
* Sales calculations
* Fact and dimension relationships

### 7. Load

Loaded the final analytical tables into MySQL using **SQLAlchemy and PyMySQL**.

---

# ⭐ Data Warehouse — Star Schema

The final analytical model follows a **Star Schema** design.

```text
                    dim_date
                       |
                       |
dim_customer ---- fact_sales ---- dim_product
```

## Fact Table

### `fact_sales`

Contains sales transaction information:

```text
order_id
product_id
customer_id
order_purchase_timestamp
product_category_name
price
freight_value
sales_amount
year
month
```

## Dimension Tables

### `dim_customer`

```text
customer_id
customer_unique_id
customer_zip_code_prefix
customer_city
customer_state
```

### `dim_product`

```text
product_id
product_category_name
```

### `dim_date`

```text
date
year
month
```

---

# 🗄️ MySQL Data Warehouse

The transformed data was loaded into the MySQL database:

```text
olist_bi
```

The database contains the star-schema tables used for SQL analysis and Power BI reporting.

---

# 🔎 SQL Analysis

SQL was used to analyze business performance and generate analytical insights.

## 📊 KPI Analysis

* Total Revenue
* Total Orders
* Total Customers
* Average Order Value
* Total Freight Cost

## 📈 Trend Analysis

* Monthly Revenue
* Yearly Revenue
* Previous Month Revenue
* Revenue Difference
* Revenue Growth %

## 🛍️ Product Analysis

* Top Products by Revenue
* Revenue by Product Category
* Product Ranking within Category
* Average Product Price by Category

## 👥 Customer Analysis

* Top Customers by Revenue
* Average Revenue per Customer
* Orders per Customer
* Above-Average Customers

## 🌎 Geographic Analysis

* Revenue by Customer State
* Orders by Customer State

## SQL Concepts Used

* `SELECT`
* `WHERE`
* `GROUP BY`
* Aggregate Functions
* `ORDER BY`
* Subqueries
* CTEs
* Correlated Subqueries
* Window Functions
* `RANK()`
* `PARTITION BY`
* `LAG()`

---

# 📊 Power BI Dashboard

The final Power BI report contains **three interactive pages**.

## 1. Executive Overview

Provides a high-level overview of overall business performance.

### Includes

* Total Revenue
* Total Orders
* Total Customers
* Average Order Value
* Monthly Revenue Trend
* Top 10 Products by Revenue
* Revenue by Customer State
* Revenue by Product Category
* Interactive slicers for:

  * Year
  * Month
  * Product Category
  * Customer State

---

## 2. Customer Insights

Focuses on customer performance and purchasing behavior.

### Includes

* Average Revenue per Customer
* Orders per Customer
* Top Customers by Revenue
* Customer performance comparisons
* Customer-level analysis

---

## 3. Product Performance

Focuses on product and category performance.

### Includes

* Revenue by Product Category
* Orders by Product Category
* Top 10 Products by Revenue
* Average Product Price by Category
* Product performance comparisons

---

# 🧮 DAX Measures

Key DAX measures created for the Power BI model include:

```text
Total Revenue
Total Orders
Total Customers
Total Products
Average Order Value
Average Revenue per Customer
Orders per Customer
Previous Month Revenue
Revenue Growth %
```

These measures support KPI cards, trend analysis, customer analysis, and business performance comparisons.

---

# 💡 Business Insights

The analysis provides insights into:

* Revenue performance over time
* Top-performing products and categories
* High-value customers
* Customer purchasing behavior
* Geographic revenue distribution
* Average order value
* Month-over-month revenue performance
* Product and customer contribution to overall revenue

---

# 📁 Project Structure

```text
End-to-End-BI-Solution/
│
├── etl/
│   └── end_to_end_business_solution.ipynb
│
├── sql/
│   └── end_to_end_bi_project.sql
│
├── dashboard/
│   ├── end_to_end_bi.pbix
│   └── screenshots/
│
├── README.md
└── .gitignore
```

---

# 🚀 How to Run

## 1. Clone the Repository

```bash
git clone <repository-url>
```

## 2. Prepare the Dataset

Download the Olist dataset and place the required CSV files in the project directory.

## 3. Run the Python ETL

Open:

```text
etl/end_to_end_business_solution.ipynb
```

Run the notebook to:

* Load the raw data
* Clean and transform the data
* Build the star-schema tables
* Validate the transformed data
* Load the tables into MySQL

## 4. Run SQL Analysis

Open:

```text
sql/end_to_end_bi_project.sql
```

Run the queries against the:

```text
olist_bi
```

database.

## 5. Open Power BI

Open:

```text
dashboard/end_to_end_bi.pbix
```

Connect Power BI to your local MySQL database and refresh the data.

---

# 🔐 Security

Database credentials are **not stored directly in the notebook**.

Use environment variables or a local `.env` file for database credentials.

Make sure `.env` is included in `.gitignore` and is **never uploaded to GitHub**.

Example:

```text
.env
*.env
__pycache__/
.ipynb_checkpoints/
```

---

# 🎯 Skills Demonstrated

This project demonstrates practical experience in:

* Python ETL
* Data Cleaning
* Data Transformation
* Data Validation
* SQL
* MySQL
* Data Warehousing
* Star Schema
* Data Modeling
* DAX
* Power BI
* Business Analysis
* Data Visualization
* Git & GitHub

---

# 👤 Author

**Nouman Anjum**

BSCS Student | Aspiring Data Analyst

---

⭐ If you find this project useful, feel free to explore the repository and Power BI dashboard.
