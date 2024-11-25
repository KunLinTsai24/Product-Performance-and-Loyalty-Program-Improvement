# Project Background
GlobalStyle E-commerce, a global e-commerce company founded in 2010, specializes in selling electronics, wellness products, accessories, and home decor items. In collaboration with the marketing team, I conducted an in-depth analysis to extract actionable insights and deliver strategic recommendations aimed at improving ad campaign performance, optimizing marketing budgets, and identifying lookalike audiences for targeted growth.

The project focused on two key objectives:

*   **Identifying the Best-Performing Campaign:** Key metrics—Conversion Rate (CR), Click-Through Rate (CTR), and Cost Per Click (CPC)—were analyzed to determine the most effective audience combinations. Statistical Testing validated that Campaign Effectiveness differences were statistically significant and actionable.
*   **Refined User Segmentation**: The findings provided a deeper understanding of audience preferences, enabling the company to further segment user groups and deliver highly targeted and personalized advertising.

There are three campaigns in this project:

*   **916 (Tech Enthusiasts):** Target individuals with a strong interest in technology, gadgets, and innovative tools. This campaign focuses on promoting tech-related products such as smart devices, accessories, and electronics.
*   **936 (Fitness Goals):** Appeal to individuals interested in fitness, health, and wellness products. This campaign promotes items like gym equipment, activewear, and nutritional supplements.
*   **1178 (Home Renovators):** Attract DIY enthusiasts, homeowners, and individuals looking to improve their living spaces. The campaign focuses on promoting home renovation products such as tools, furniture, and decor items.

<br/>

The original dataset for this analysis is available here \[[link](https://github.com/KunLinTsai24/Ad-Campaign-Optimization/blob/main/data/ad_campaign.csv)\].  
The Python code used to inspect and clean the data for this analysis can be found here \[[link](https://github.com/KunLinTsai24/Ad-Campaign-Optimization/blob/main/script/Campaign%20Optimization.ipynb)\].

# Data Structure & Initial Checks

The company’s main database structure is shown below, with a total row count of 1,143 records. A description of the table is as follows:

*   **ad\_id**: A unique ID for each ad.
*   **company\_campaign\_id**: An ID associated with each ad campaign of the company.
*   **fb\_campaign\_id**: An ID associated with how Facebook tracks each campaign.
*   **age**: Age of the person to whom the ad is shown.
*   **gender**: Gender of the person to whom the ad is shown.
*   **interest**: A code specifying the category to which the person’s interest belongs.
*   **impressions**: The number of times the ad was shown.
*   **clicks**: Number of clicks for that ad.
*   **spent**: Amount paid by the company to Facebook to show that ad.
*   **total\_conversion**: Total number of people who enquired about the product after seeing the ad.
*   **approved\_conversion**: Total number of people who bought the product after seeing the ad.

# Executive Summary

### Overview of Findings

The analysis revealed that the **Tech Enthusiasts** campaign performed exceptionally well, achieving the highest Conversion Rate (CR) and Click-Through Rate (CTR) while maintaining the lowest Cost Per Click (CPC), making it the most efficient campaign overall. The **Fitness Goals** campaign demonstrated strong engagement with a high CTR and moderate CR, offering a balanced performance that could be further optimized. In contrast, the **Home Renovators** campaign underperformed, with the lowest CR and CTR and the highest CPC, indicating significant room for improvement in targeting and cost efficiency. Additionally, the findings highlight that **30-34-year-old males** in both the **Tech Enthusiasts** and **Fitness Goals** campaigns had the best CR, emphasizing this demographic as a critical high-value audience segment.

# Insights Deep Dive
### Campaign: Tech Enthusiasts:

*   **High Conversion Efficiency**: CR (0.000120) is the highest among the three campaigns, showing that the Tech Enthusiasts campaign converts impressions to conversions more effectively than the others.
*   **Low Scale**: With only 482,925 impressions and 54 ads, this campaign operates at a significantly smaller scale compared to the others, which limits its overall impact despite high efficiency.
*   **Cost Efficiency**: The CPC (1.13) is the lowest among the campaigns, making it the most cost-efficient in generating clicks.

### Campaign: Fitness Goals:

*   **Balanced Performance**: CR (0.000066) is moderate compared to the Tech Enthusiasts campaign but better than the Home Renovators campaign. This indicates that while the campaign is not as efficient as the Tech Enthusiasts campaign, it still performs relatively well in converting impressions.
*   **Significant Scale**: With 8,128,187 impressions and 464 ads, this campaign reaches a much broader audience, providing an opportunity for high absolute conversion numbers.
*   **Moderate Cost Efficiency**: The CPC (1.36) is higher than the Tech Enthusiasts campaign but still lower than the Home Renovators campaign, making it relatively cost-efficient given its scale.

### Campaign: Home Renovators:

*   **Large Scale but Low Efficiency**: With over 20 million impressions and 625 ads, this campaign has the largest scale but the lowest CR (0.000013), indicating inefficiency in converting impressions into meaningful actions.
*   **High Engagement Challenges**: CTR (0.000176) is the lowest among all campaigns, indicating that the ads are not resonating well with the audience, leading to poor click engagement.
*   **Cost Inefficiency**: CPC (1.54) is the highest, suggesting that the campaign is spending more to generate clicks compared to the others, which could be driving up costs without corresponding returns.

![](https://github.com/KunLinTsai24/Ad-Campaign-Optimization/blob/main/img/Campaign.png)

### Target Audience Segmentation:

*   **30-34-Year-Old Males**: 30-34-year-old males are the top-performing segment across the Tech Enthusiasts campaign (CR = 0.000189) and the Fitness Goals campaign (CR = 0.000178), making them a critical high-value audience to target with tailored content and increased ad spend.
*   **CR Declines with Age**: The Fitness Goals campaign shows a clear CR drop with age for both genders (e.g., males: 0.000178 → 0.000063), highlighting younger audiences (30-34, 35-39) as significantly more responsive and higher ROI potential.
*   **Competitive Performance**: 30-34-year-old females show strong CR in the Fitness Goals campaign (CR = 0.000110), presenting an opportunity for targeted campaigns with tailored messaging and creative strategies to further enhance engagement and conversions.

![](https://github.com/KunLinTsai24/Ad-Campaign-Optimization/blob/main/img/Segmentation.png)

# Recommendations:

### Campaign Optimization

*   **Redesign Ad Creatives for the Home Renovators Campaign**: Include compelling visuals, stronger CTAs, and clear value propositions that align with audience needs (e.g., benefits of the product/service).
*   **Simplify Landing Pages for the Fitness Goals Campaign**: Ensure mobile optimization and include persuasive elements like testimonials or urgency triggers (e.g., limited-time offers).
*   **Reallocate Budget Across Campaigns**: Increase budget allocation to the Tech Enthusiasts campaign and reduce spend on the Home Renovators campaign. Focus the remaining budget on testing new targeting and creative strategies.
  
### Target Audience Optimization
*   **Expand 30-34-Year-Old Male Audience**: Use lookalike audience features on platforms like Facebook Ads or Google Ads to target similar users.
*   **Target 30-34-Year-Old Females**: Design gender-specific campaigns with tailored messaging and creatives to align with this demographic’s preferences and behaviors.
*   **Reduce Targeting of 40+ Age Groups**: Shift focus away from low-performing segments (40+) to prioritize younger demographics (30-39) with higher conversion potential.

# Assumptions and Caveats:

Throughout the analysis, multiple assumptions were made to manage challenges with the data. These assumptions and caveats are noted below:

*   **Data Imputation**: Illogical or missing entries were handled using the KNN imputer with 2 nearest neighbors to infer and impute missing values, ensuring continuity and minimizing bias in the dataset.
*   **Campaign Attribution**: The analysis assumes that conversions and engagement metrics are solely attributed to the campaign being assessed, without considering potential overlaps with other campaigns or external factors like seasonality.
*   **CTR and CR Correlation**: It was assumed that higher CTR would generally lead to higher CR, although there may be cases where high click engagement does not translate to conversions due to other factors like landing page quality.
