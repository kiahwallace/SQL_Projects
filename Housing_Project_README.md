# Nashville Housing Data Cleaning Project

This project focuses on cleaning a raw dataset from the Nashville housing market using SQL. The goal was to transform the data into a cleaner, more structured, and analysis-ready format.

---

## Tools Used

- **SQL (MySQL / SQL Server)**: Main tool for querying and transforming the data.
- **Workbench**: To run and test queries.
- **Spreadsheet**: For additional duplicate checking or visualization.

---

## Data Cleaning Tasks Performed

### 1. Table Renaming
Renamed the original table `nashville housing data for data cleaning` to `nashvillehousing` for simplicity and easier querying.

### 2. Standardized Date Format
- Created a new column `SaleDateConverted`.
- Converted `SaleDate` from text to proper `DATE` format using the `CONVERT()` function.

### 3. Populated Missing Property Addresses
- Identified null `PropertyAddress` values.
- Matched missing addresses using `ParcelID` from duplicate records.
- Used a self-join to copy existing addresses to null rows.

### 4. Split Property Address into Columns
- Separated `PropertyAddress` into:
  - `PropertySplitAddress` (street address)
  - `PropertyCity` (city)
- Used `SUBSTRING()` and `LOCATE()` functions to split by commas.

### 5. Split Owner Address into Columns
- Broke down `OwnerAddress` into:
  - `Address`
  - `City`
  - `State`
- Used `SUBSTRING_INDEX()` for efficient string splitting.

### 6. Standardized Categorical Values
- Replaced `'Y'` and `'N'` in the `SoldAsVacant` column with `'Yes'` and `'No'` respectively using `CASE WHEN`.

### 7. Removed Duplicates
- Used a CTE (`RowNumCTE`) with `ROW_NUMBER()` to identify duplicates based on key columns.
- Deleted duplicate rows keeping only the first occurrence.

### 8. Dropped Unused Columns
- Removed the original `SaleDate` column after converting and storing it as `SaleDateConverted`.

---

## Final Outcome

The dataset is now:
- Free of duplicates
- Standardized in format
- More readable and analysis-friendly
- Structured with clean, separated columns for addresses and categorical values
