# **SWIGGY DATA PIPELINE PROJECT IN SNOWFLAKE**

 ![logo](https://github.com/codeSavvy-ln/Snowflake/blob/main/Swiggy%20Data%20Pipeline/End-to-End%20data%20flow%20architecture.png)


## **Project Overview**

 - Real world ETL pipeline for a food‑delivery platform (Swiggy) using Snowflake as the core data warehouse platform.
 - It Covers the full lifecycle from ingestion of raw data to analytics-ready models and a visual interface using Streamlit.
 - It follows the Madellion Architecture like concept where Stage, clean and consumption schema behave as bronze, Silver and Consumtption layer respectively. 

**Source Data in the form of ER Model (in Postgree Table)**
 ![logo](https://github.com/codeSavvy-ln/Snowflake/blob/main/Swiggy%20Data%20Pipeline/ER-Source%20data.png) 

**Final Data in the form of Dimenional Modelling (in Consumption layer in snowflake)**
 ![logo](https://github.com/codeSavvy-ln/Snowflake/blob/main/Swiggy%20Data%20Pipeline/Dimesional%20modeling%20-%20Loaded%20data.png)

## **Project Breakdown**
1. **Data Extraction**
   - Data is extracted from Postgree Database in the form of CSV file which is initial load.
   - Uploaded these CSV files in Staging on Snowflake
   - Data is then loaded into tables in staging schema first.
   - Data in delta load csv files are processed in a batch praocessing manner.

2. **Data Transformation**
   - Data is then merged into another tables in Cleaned Schema.
   - Data is cleaned and transformed here
     - Data type is converted into appropriate form
     - Addtional columns are added like state, state_code and city_tier etc.
    
3. **Data Loading**
   - Store the cleaned data into another tables under Consumption Schema.
   - Dimension and Fact tables are created in this scehma.
     
5. **Data Analysis**
   - Multiple KPI's are created to visualized on the Streamlit
      ![logo](https://github.com/codeSavvy-ln/Snowflake/blob/main/Swiggy%20Data%20Pipeline/Streamlit%20Visual.png)

## **How to run this Project**
 - Upload the data into your snowflake under the CSV Stages [Sample_data](https://github.com/codeSavvy-ln/Snowflake/tree/main/Swiggy%20Data%20Pipeline/Sample%20Data)
 - Run These Scripts on your Snowflake worksheets [Snowflake Scripts](https://github.com/codeSavvy-ln/Snowflake/tree/main/Swiggy%20Data%20Pipeline/Snowflake%20Scripts)
   
