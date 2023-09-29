# Bitter-Pill-Pharmacy-DW
Data Warehouse using SSIS ETL Tools

![image](https://github.com/mysecret39/Bitter-Pill-Pharmacy-DW/assets/88777199/58145dd0-55dc-47ad-86be-3bfe2b7e399a)

Overview:

Designed and built a data warehouse for Bitter Pill Pharmacy to analyze operational data for decision making
Requirements Gathering:

Interviewed CEO to understand reporting needs like medicine and equipment sales, consultations, analyzing by customer, employee, etc.
Identified dimensions like customer, employee, doctor, supplier, medicine, equipment, branch
Noted requirements for each dimension attribute to enable analysis like gender, age, location, etc.
Design:

Created a star schema with fact and dimension tables
Fact tables for medicine purchase, medicine sales, equipment sales, consultations
Dimensions for customer, employee, doctor, supplier, medicine, equipment, branch
Identified measures and aggregate functions for facts
ETL Process:

Used SQL Server Integration Services (SSIS) to extract data from OLTP database
Transformed and cleaned data
Loaded data into dimension tables using slowly changing dimensions
Loaded data into fact tables
Analysis:

Built OLAP cubes on top of data warehouse
Created pivot tables in Excel to generate reports for CEO analysis
Enabled slicing and dicing data by different dimensions like customer, product, etc.
This data warehouse enabled powerful analysis of pharmacy operations to support data-driven decisions. The portfolio demonstrates proficiency in requirements gathering, dimensional data warehousing design, ETL, and reporting.


Open the documentation.docx to see the step by step of this project

