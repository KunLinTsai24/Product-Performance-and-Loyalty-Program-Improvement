# Project Background
TechStore E-commerce, established in 2012, focuses on selling electronics such as smartphones, laptops, and tablets, as well as accessories and extended warranties. This project analyzed customer transactions and product data to identify specific factors affecting revenue, customer loyalty, and operational efficiency. The findings and recommendations from this analysis are designed to benefit the marketing team, by providing strategies to optimize customer engagement and loyalty; the sales team, by identifying opportunities to enhance product performance and increase revenue; and the operations team, by addressing inefficiencies impacting order fulfillment and customer satisfaction.

The project focused on two key objectives:

*   **Improving Product Performance:** Metrics such as total sales, product ratings, cancellation rates, and add-on purchases were analyzed to identify products driving revenue and those requiring improvement. Operational inefficiencies, like recurring cancellations, were also examined.
*   **Evaluating the Loyalty Program**: Customer data was analyzed to compare loyalty members and non-members on metrics such as Average Order Value (AOV), transaction frequency, and add-on purchases. Differences between demographics were used to assess program effectiveness.

This analysis identified measurable issues in product performance and customer engagement, providing actionable recommendations to address these challenges.

<br/>

The original dataset for this analysis is available here \[[link](https://github.com/KunLinTsai24/Product-Performance-and-Loyalty-Program-Improvement/tree/main/data)\]. 

The SQL script used to inspect and clean the data for this analysis can be found here \[[link](https://github.com/KunLinTsai24/Product-Performance-and-Loyalty-Program-Improvement/tree/main/script)\].

The Power BI dashboard used for data visualization can be found here \[[link](https://github.com/KunLinTsai24/Product-Performance-and-Loyalty-Program-Improvement/tree/main/dashboard)\].

# Data Structure & Initial Checks

The company’s database consists of 20K records, capturing customer, transaction, and product-level details. Key fields include:

*   **Customer ID:** Unique identifier for each customer.
*   **Loyalty Member:** Membership status (Yes/No), with values changing over time.
*   **Product Details:** Includes product type (e.g., Smartphone, Tablet), SKU, and unit price.
*   **Transaction Details:** Covers order status (Completed/Cancelled), payment method, total price, and add-on purchases.
*   **Demographics:** Customer age and gender.
*   **Purchase Behavior:** Quantity, purchase date, and shipping type.

# Executive Summary

### Overview of Findings

The analysis uncovered opportunities for improvement in both product performance and the loyalty program. On the product side, top-performing products like **SMP1004** and **TBL1002** drive significant sales and add-on purchases, while SMP1002, despite high sales, poses risks due to low customer ratings. Recurring cancellation spikes every three months indicate potential operational inefficiencies. Regarding loyalty, members contribute significantly **less in sales and transactions** compared to non-members, with **lower repurchase rates** and no added value in Average Order Value (AOV) or add-on purchases. These findings call for targeted improvements to maximize customer satisfaction and revenue potential.

# Insights Deep Dive
### Product Performance:

*   **SMP1002 - High Sales but Low Ratings:** Despite generating $9M in sales, SMP1002 has a low customer rating of 2/5, placing it among the lowest-rated products. This suggests unresolved issues impacting customer satisfaction, which could reduce repeat purchases.
*   **Top 5 Products Drive 73% of Total Sales:** The top five products—SMP1004, SWT1001, TBL1002, SMP1002, and LTP1001—account for nearly three-quarters of revenue. SMP1004 alone contributed $12M. This reliance on a small product group increases risk if these products underperform.
*   **Seasonal Cancellation Spikes:** Cancellation spikes occur every three months, contributing to a 32.8% overall cancellation rate. These spikes are not linked to specific products, payment methods, or shipping types, suggesting systemic operational issues like inventory shortages or fulfillment delays.
*   **Add-On Sales Contribution:** Add-ons generated $1.2M in revenue, with TBL1002 contributing $169.99K and SMP1004 $166.7K. This reliance on top-performing SKUs for add-on sales suggests potential for increasing revenue by expanding add-on offerings to other products.
<br/>

![]()

### Loyalty Program:

*   **Loyalty Program’s Poor Performance:** Loyalty members contributed only $9.1M in sales and completed 2.9K transactions, while non-members generated $33.5M and completed 10.5K transactions. This represents a 72.87% revenue gap and a 72.23% transaction gap, indicating low loyalty program effectiveness.
*   **Minimal Impact on Add-On Purchases:** Add-on purchase rates and AOVs for members and non-members were nearly identical (75% vs. 76% and $83 vs. $82), showing that the program does not incentivize incremental purchases.
*   **Gender-Based AOV Disparities:** Female non-members had the highest AOV at $3,229, exceeding female members’ AOV of $3,082. Male non-members also outperformed male members, with AOVs of $3,152 and $3,153, respectively.
*   **AOV Gap Across Age Groups:** Non-members had higher AOVs in all but the 21-30 age group, where members slightly outperformed ($3,280 vs. $3,102). The largest non-member advantage was in the 71-80 age group ($3,163 vs. $3,022).
<br/>

![]()

# Recommendations:

### Product Performance

*   **Improve SMP1002 Quality:** Analyze customer feedback to identify and address product defects or dissatisfaction. Relaunch with improved features or incentives like discounts to regain trust.
*   **Diversify Product Portfolio:** Expand mid-tier offerings to reduce reliance on the top five products. Develop new products targeting gaps in the market based on customer demand.
*   **Address Cancellation Spikes:** Investigate inventory management and fulfillment processes to identify inefficiencies. Use real-time communication to inform customers of delays and reduce cancellations.
*   **Boost Add-On Sales:** Introduce targeted cross-selling strategies and bundle discounts for underperforming products to increase add-on revenue beyond top SKUs.
  
### Loyalty Program
*   **Revamp Membership Incentives:** Implement tiered rewards like free shipping, early access to products, or cashback for higher spending to increase member engagement.
*   **Encourage Member Add-On Purchases:** Create exclusive add-on discounts or loyalty-specific bundles to encourage additional purchases.
*   **Close the AOV Gap:** Use personalized promotions targeting demographics like the 21-30 age group, who show potential for higher spending. Offer cashback or limited-time discounts to incentivize spending among other age groups.
*   **Expand Membership Base:** Simplify the membership process and offer sign-up benefits such as welcome discounts to attract high-value non-members.

# Assumptions and Caveats:

Throughout the analysis, multiple assumptions were made to manage challenges with the data. These assumptions and caveats are noted below:

*   **Data Removed During Cleaning:** Rows with “#N/A” gender values and inconsistencies between “addons purchased” and “addons total” were excluded for accuracy.
*   **Loyalty Membership Dates:** Missing data on start and end dates for membership made it challenging to track customer behavior over time.
*   **Add-On Attribution:** Add-on revenue was attributed to the primary product purchased, without accounting for promotions or other external factors.
