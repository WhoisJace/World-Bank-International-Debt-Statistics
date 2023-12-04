--- The initial code line establishes a connection to my personal database, where the "international_debt" table is located. 
--- From here I can take a glance and see what data I am working with and what questions can be answered. 

SELECT *
FROM international_debt

--- Examining the rows reveals each countries debt across various debt indicators. 
--- However, as the table may contain repeated country names due to the likelihood of a country having debt in multiple indicators, it is essential to determine the total number of distinct countries. 
--- Without a count of unique countries, comprehensive statistical analyses cannot be conducted.

SELECT COUNT(DISTINCT(country_name)) AS total_distinct_countries
FROM international_debt;

--- I required information about the specific countries with debt. 
--- Knowing the count of distinct countries is valuable, but having the actual names of these countries is equally important. 
--- This information will be beneficial for both my understanding and for creating visualizations.

SELECT DISTINCT(country_name) AS distinct_countries
FROM international_debt
ORDER BY country_name

--- Familiarizing ourselves with these diverse debt indicators will enhance our comprehension of the potential areas for which a country might have incurred debt.

SELECT DISTINCT(indicator_code) AS distinct_debt_indicators
FROM international_debt
ORDER BY distinct_debt_indicators

--- I shifted my focus away from the debt indicators and determined the aggregate amount of debt (in USD) owed by various countries. 
--- This exploration will provide insights into the overall economic standing of the world as a whole.

SELECT SUM(debt) AS Total_Debt
FROM international_debt

--- Now that I have the precise total of debts owed by various countries, I then identify the country with the highest debt and determine the corresponding amount. 
--- It's important to note that this debt encompasses the sum of various obligations across multiple categories. 
--- This analysis will contribute to a better understanding of the country's socio-economic circumstances.

SELECT 
    country_name, 
    ROUND(SUM(debt),2) AS total_debt
FROM international_debt
GROUP BY country_name
ORDER BY total_debt DESC;

--- I now have a brief overview of the dataset and a few of its summary statistics. 
--- We already have an idea of the different debt indicators in which the countries owe their debts. 
--- We can dig even further to find out on an average how much debt a country owes. 
--- This will give us a better sense of the distribution of the amount of debt across different indicators.

SELECT TOP 10
    indicator_code AS debt_indicator,
    indicator_name,
    ROUND(AVG(debt),2) AS average_debt
FROM international_debt
GROUP BY indicator_code, indicator_name
ORDER BY average_debt DESC;

--- The indicator DT.AMT.DLXF.CD stands out as the leader in average debt, representing the repayment of long-term debts. 
--- Nations often incur long-term debt to secure immediate capital. An intriguing observation from this discovery is the significant disparity in amounts between the top two indicators and the subsequent ones. 
--- This suggests that the first two indicators may represent the most substantial categories in which countries accumulate their debts.

SELECT 
    country_name, 
    indicator_name
FROM international_debt
WHERE debt = (SELECT 
                MAX(debt)
             FROM international_debt
             WHERE indicator_code = 'DT.AMT.DLXF.CD');

--- China holds the highest long-term debt amount in the DT.AMT.DLXF.CD category, as confirmed by The World Bank. 
--- It is advisable to validate our analyses through external sources, ensuring the accuracy of our investigations.
--- While we observed that long-term debt dominates in terms of average debt amounts, the question arises: is it the most prevalent indicator among countries for incurring debt?

SELECT TOP 20 
indicator_code, COUNT(indicator_code) AS indicator_count
FROM international_debt
GROUP BY indicator_code
ORDER BY indicator_count DESC, indicator_code DESC

--- All the countries in our dataset have incurred debt across a total of six debt indicators, and the DT.AMT.DLXF.CD indicator is among them. 
--- This suggests a shared economic concern among these nations. However, this revelation is just one aspect of the larger narrative.
--- Shifting my focus from debt indicators, I revisit the debt amounts. 
--- I then explore the maximum debt amount for each country, providing us with insights into other potential economic challenges a country might be experiencing

SELECT TOP 10 
country_name, MAX(debt) AS maximum_debt
FROM international_debt
GROUP BY country_name
ORDER BY maximum_debt DESC





