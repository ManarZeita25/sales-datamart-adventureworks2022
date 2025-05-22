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
### ⭐ Project Workflow

Meticulously crafted a star schema that forms the backbone of our data mart.  
This design includes:

- A **central Fact Table** (`FactSales`) that stores key performance indicators such as sales amount and quantity, along with foreign keys to dimension tables.
- Four **Dimension Tables**:
  - `DimProduct`: Contains product details like name, category, and subcategory.
  - `DimCustomer`: Holds customer information including name and geographic details.
  - `DimTerritory`: Stores regional sales data.
  - `DimDate`: A time dimension that enables flexible date-based analysis (day, month, quarter, year).

This structure enables efficient querying, simplified reporting, and supports historical trend analysis.
![Star Schema Diagram](https://github.com/ManarZeita25/sales-datamart-adventureworks2022/blob/main/images/Schema.png)

### 🛠️ SQL Scripts

SQL scripts are provided to create the schema and metadata/control tables.

[📂 View SQL Scripts Folder](https://github.com/ManarZeita25/sales-datamart-adventureworks2022/tree/main/script)

## 🚀 SSIS Packages

To automate the ETL process and populate the Sales Data Mart, I have developed the following SSIS packages:

### 🧱 Dimension Loads
- **ETL_Dim_Product**: Extracts and loads product data into `DimProduct`.
- **ETL_Dim_Customer**: Extracts and loads customer data into `DimCustomer`.
- **ETL_Dim_Territory**: Extracts and loads territory data into `DimTerritory`.
- **ETL_Dim_Date**: Generates and loads date dimension data into `DimDate`.

### 📦 Fact Table Loads
- **Fact_Sales_Full_Load**: Performs a full load of sales data into `FactSales`.
- **Fact_Sales_Incremental_Load**: Loads only new or changed sales records using incremental logic based on `last_load_date` from the control table.

Each package is designed for reliability, data quality validation, and performance efficiency using best practices in SSIS.

![SSIS Packages](https://github.com/ManarZeita25/sales-datamart-adventureworks2022/blob/main/images/SSIS%20Packages.png)
### 🧩 Product Dimension – First Load

The initial load for the `DimProduct` table was performed using a **Slowly Changing Dimensions (SCD)** strategy:

- **SCD Type 1**: Used to overwrite non-historical attribute changes (e.g., product name corrections).
- **SCD Type 2**: Implemented to track historical changes (e.g., product category changes over time) by inserting new rows with versioning and effective dates.

Since this is the **first load**, all records were inserted directly into the destination without triggering any historization logic or change detection. Future loads will detect changes and apply the appropriate SCD logic (Type 1 or 2) as needed.

![Product Dimension - SCD Load](https://github.com/ManarZeita25/sales-datamart-adventureworks2022/blob/main/images/dim_product.png)
### 🔄 Product Dimension – After Making Changes

Following the initial load of our `DimProduct` table, we moved into the enhancement phase where we applied **Slowly Changing Dimensions (SCD)** techniques to manage updates and changes in product data.

- **SCD Type 1** was used to overwrite non-historical changes, such as correcting product names or descriptions.
- **SCD Type 2** was applied to track historical changes, such as modifications in product categories or subcategories, by creating new versioned records.

📌 **Result**:  
As illustrated in the image below, this phase reflects the updated state of the Product dimension after implementing the necessary changes. It highlights our commitment to:

- Maintaining **data accuracy**
- Ensuring **historical tracking**
- Supporting **business evolution** through a responsive data model

These enhancements guarantee that our data mart remains a reliable source for analytical insights and supports informed business decision-making.

![Product Dimension - After SCD Changes](https://github.com/ManarZeita25/sales-datamart-adventureworks2022/blob/main/images/dim_product%202.png)


### 👥 Customer Dimension – Load Process Summary

#### 🟢 First Load
The initial load of the `DimCustomer` table involved populating it with essential customer data for the first time.  
All records were inserted directly into the destination without applying any change-tracking logic (i.e., no SCD Type 1 or Type 2 at this stage).

![Customer Dim – First Load](https://github.com/ManarZeita25/sales-datamart-adventureworks2022/blob/main/images/dim_customer.png)

---

#### 🔄 After Applying Changes
In the enhancement phase, updates and corrections were applied to existing customer records using **Slowly Changing Dimensions (SCD)** techniques:

- **Type 1** for non-historical corrections (e.g., customer name fixes)
- **Type 2** for tracking historical changes (e.g., region or status updates)

This ensures the dimension accurately reflects real-world changes in customer data.

![Customer Dim – After Changes](https://github.com/ManarZeita25/sales-datamart-adventureworks2022/blob/main/images/dim_customer%202.png)

### 🌍 Territory Dimension 

In the `AdventureWorks2022` database, the `CountryRegionCode` is stored as two-letter country codes (e.g., "US", "CA", "FR").  
To enhance readability and improve reporting clarity, a custom lookup table `dbo.lookup_country` was created to map these codes to full country names (e.g., "United States", "Canada", "France").  
This mapping is used during ETL to enrich the `DimTerritory` table with meaningful country names.

![Territory Dim ](https://github.com/ManarZeita25/sales-datamart-adventureworks2022/blob/main/images/dim_Territory.png)


---

### 📅 Date Dimension

The `DimDate` table is populated by extracting data from a pre-defined Excel sheet that contains the full date range and related attributes.  
This static date table is imported into the data mart to support time-based analysis (Year, Month, Quarter, Day).

📄 You can find the load script in the [Scripts](https://github.com/ManarZeita25/sales-datamart-adventureworks2022/blob/main/script/dim_date_populate_table.xls) folder.

![Date Dim ](https://github.com/ManarZeita25/sales-datamart-adventureworks2022/blob/main/images/dim%20date.png)



