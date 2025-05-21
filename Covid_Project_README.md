# COVID-19 Data Analysis Project

This project focuses on analyzing raw COVID-19 data using SQL. The goal was to clean and structure the data, calculate key metrics such as death percentages, analyze the relationship between cases and population, and investigate vaccination trends to understand the global impact of the pandemic.

---

## Tools Used

- **SQL (MySQL / SQL Server)**: Main tool for querying and transforming the data.
- **Workbench**: Used to run and test SQL queries.
- **Spreadsheet**: For additional duplicate checking or visualization.

---

## Data Cleaning and Analysis Tasks Performed

### 1. Filtered Out Invalid Data
- Removed records where `continent` values were null to ensure accurate regional analysis.
- Focused on clean, consistent rows for all core queries.

### 2. Verified and Ordered Raw Tables
- Queried and sorted both the deaths and vaccinations datasets by location and date for proper alignment and chronological tracking.

### 3. Calculated Death Rate as a Percentage of Total Cases
- Derived `DeathPercentage = (total_deaths / total_cases) * 100` to understand severity across different locations.

### 4. Compared COVID Cases to Population
- Calculated what percentage of a country’s population was infected using `PercentPopulation = (total_cases / population) * 100`.
- Focused particularly on countries like the United States to highlight high-impact areas.

### 5. Identified Countries with Highest Infection and Death Counts
- Used `MAX()` and `GROUP BY` to find:
  - Highest number of cases.
  - Countries with the greatest death tolls.
  - Regions with the most deaths relative to population size.

### 6. Aggregated Data by Continent
- Grouped data by continent to visualize and compare COVID’s impact across global regions.
- Cleaned missing or invalid continent labels to ensure groupings were accurate.

### 7. Summarized Global COVID Statistics
- Calculated total global cases and deaths.
- Derived global `DeathPercentage` from cumulative numbers using `SUM()` and proper null handling to avoid division errors.

### 8. Analyzed Vaccination Rollout Using CTE
- Created a Common Table Expression (CTE) to calculate rolling totals of vaccinations per country over time.
- Joined vaccination data with population data to compute the percentage of people vaccinated.
- Enabled time-series tracking of how vaccination efforts progressed globally.

---

## Final Outcome

After cleaning and transformation, the data now:
- Excludes irrelevant or incomplete records.
- Contains meaningful metrics like infection and death percentages.
- Allows for both country-specific and continent-wide comparisons.
- Offers insights into how vaccinations progressed over time and their relationship to population.
- Is structured and analysis-ready for dashboards, reports, or further modeling.
