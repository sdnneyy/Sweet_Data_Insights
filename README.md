# Chocolate Sales Database Analysis

This project documents the process of transforming a raw, denormalized sales file into a structured, relational database optimized for analysis and reporting. The underlying schema follows a Star Schema model, ensuring data integrity and efficient querying of key business metrics.

## Project Goals

* **Data Normalization:** Convert the initial flat file data into a Third Normal Form (3NF) compliant structure.
* **Schema Design:** Establish a robust Star Schema with distinct dimension tables and one fact table.
* **Data Integrity:** Implement Primary and Foreign Key constraints to define relationships and maintain data consistency across the database.
* **Analytical Reporting:** Develop and execute SQL queries to extract meaningful business insights from the normalized data.

## Repository Structure

The project is organized into the following files:

* **`Chocolate Sales.csv`**: The original, denormalized source data file containing all sales transactions.
* **`schema.sql`**: Contains the complete SQL code to create and populate all database tables, including the dimension tables (`Customers`, `Products`) and the fact table (`Sales`). This file handles the data cleaning, type casting (especially for the `Amount` and `Date` columns), and linking records using Foreign Keys.
* **`analysis_queries.sql`**: Contains the final set of analytical SQL queries used to answer key business questions, such as total revenue, customer purchasing behavior, and sales over time.
* **`README.md`**: This document, providing an overview of the project and its components.

## Database Schema Overview

The database uses three tables:

1.  **Customers (Dimension Table):** Stores unique salesperson names (which serve as the customer dimension). It is identified by the `Customer_ID` primary key.
2.  **Products (Dimension Table):** Stores unique chocolate product names. It is identified by the `Product_ID` primary key.
3.  **Sales (Fact Table):** This is the central table containing all transactional metrics. It is identified by the `Sale_ID` primary key and links to the dimension tables using the `Customer_ID` and `Product_ID` foreign keys.

The `Amount` column in the `Sales` table represents the **Total Revenue** for that transaction and is stored as a precise numeric type (`DECIMAL(10, 2)`).

## Key Analytical Insights

The SQL queries in `analysis_queries.sql` are designed to answer the following questions:

* **Total Revenue per Month Over Time:** Calculates the aggregated revenue over the project period, grouped by Year-Month to show trends.
* **Top 5 Customers by Total Spending:** Identifies the customers (salespersons) who generated the highest total revenue overall.
* **Average Amount per Sale:** Determines the single average value of a sales transaction across the entire dataset.
* **Most Frequent Product per Customer:** Uses ranking window functions to determine which product each individual customer purchased the highest number of times.
* **High-Value Sales:** Filters transactions to identify all sales with an amount greater than a specified threshold (e.g., $500).
