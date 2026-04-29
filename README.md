# Transaction Pattern Analysis (Simulated Project)

## Overview
This project analyzes transactional data to detect abnormal patterns such as high-value transactions, frequent users, and multi-location activity using Excel and SQL Server.

## Tools Used
- Microsoft Excel (Pivot Tables, Charts, Conditional Formatting)
- SQL Server (Data querying and anomaly detection)

## Dataset
A simulated dataset of financial transactions containing:
- User_ID
- Transaction_Date
- Transaction_Amount
- Transaction_Type
- Merchant_Category
- Location
- Device_Type

## Key Analysis Performed
- Identification of high-frequency users
- Detection of high-value transaction spikes
- Analysis of daily spending patterns
- Multi-location activity detection
- Category-wise spending distribution

## Excel Work
- Pivot tables for user-wise, category-wise, and daily analysis
- Conditional formatting to highlight high-risk transactions
- Clustered column chart for user spending comparison

## SQL Work
- Data validation (NULL checks, duplicates)
- Aggregation queries for anomaly detection
- Filtering based on thresholds (amount, frequency, location)

## Key Insights
- Certain users show unusually high transaction amounts
- Repeated small transactions detected for some users
- Some users operate from multiple locations in short time
- Clear spending spikes identified above normal thresholds

## Conclusion
This project demonstrates basic fraud/anomaly detection using SQL and Excel through pattern analysis and data visualization.
