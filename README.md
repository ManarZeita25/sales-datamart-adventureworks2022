# 📊 Building a Sales Data Mart Using ETL (SSIS)

## 🔍 Overview
This project uses the **AdventureWorks2022** database to build a **Sales Data Mart** using **SQL Server Integration Services (SSIS)**. The goal is to extract, transform, and load (ETL) online sales data into a star schema optimized for analytics and reporting.

## 🛠️ Technologies Used
- Visual Studio  
- SQL Server Integration Services (SSIS)  
- SQL Server Management Studio (SSMS)  
- Slowly Changing Dimensions (SCD Type 1 & 2)

> ⚠️ **Note:** This Data Mart is focused on **online sales data** only.

## 🚀 Project Stages

1. **Source Selection**  
   Selected AdventureWorks2022 OLTP database as the primary source.

2. **Data Extraction**  
   Used SSIS to extract relevant tables and fields for online sales.

3. **Data Cleansing**  
   Removed duplicates, handled missing values, and standardized data.

4. **Star Schema Design**  
   Designed a fact table with multiple dimension tables to support analytical queries.

5. **ETL Development**  
   Built and tested SSIS packages to perform ETL operations efficiently.

6. **Data Mart Population**  
   Loaded cleansed data into the final schema, enabling structured analysis.

---


