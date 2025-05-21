
SELECT * FROM housing.`nashville housing data for data cleaning`;

/* Renaming table*/

RENAME TABLE `nashville housing data for data cleaning` to nashvillehousing;

select * from housing.nashvillehousing;

/* Standardize Date Format*/
SELECT SaleDateConverted, convert(Date,SaleDate)
FROM housing.nashvillehousing;

Alter table nashvillehousing
Add SaleDateConverted Date

Update nashvillehousing
set SaleDateConverted = Convert(Date,SaleDate);


/* Populate Property Address data*/

SELECT *
FROM housing.nashvillehousing
-- where PropertyAddress is null
order by ParcelID;


SELECT a.parcelid, a.propertyaddress, b.parcelid, b.propertyaddress, ifnull(a.propertyaddress,b.propertyaddress)
FROM housing.nashvillehousing a
JOIN housing.nashvillehousing b
ON a.parcelid = b.parcelid
AND a.uniqueid <> b.uniqueid
where a.propertyaddress is null;

SET SQL_SAFE_UPDATES = 0;

Update housing.nashvillehousing a
JOIN housing.nashvillehousing b
ON a.parcelid = b.parcelid
AND a.uniqueid <> b.uniqueid
set a.propertyaddress = ifnull(a.propertyaddress,b.propertyaddress)
where a.propertyaddress is null;

/* Breaking out Address into Individual Colums (Address, City, State) -> Hard way*/
SELECT propertyaddress
FROM housing.nashvillehousing
-- where PropertyAddress is null
-- order by ParcelID;

SELECT SUBSTRING(PropertyAddress, 1, LOCATE(',', PropertyAddress) - 1) AS Address,
SUBSTRING(PropertyAddress, LOCATE(',', PropertyAddress) + 2) AS Area
FROM housing.nashvillehousing;

ALTER TABLE nashvillehousing
ADD COLUMN PropertyCity VARCHAR(255);

UPDATE nashvillehousing
SET PropertyCity = SUBSTRING(PropertyAddress, LOCATE(',', PropertyAddress) +1);

ALTER TABLE nashvillehousing
ADD COLUMN PropertySplitAddress VARCHAR(255); 

Update nashvillehousing
set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, LOCATE(',', PropertyAddress) - 1)

select *
from housing.nashvillehousing



/* Seperating owner address details*/


select owneraddress
from housing.nashvillehousing

SELECT 
  SUBSTRING_INDEX(OwnerAddress, ',', -1) AS Part1
FROM housing.nashvillehousing;

/* This one is super important and useful : Seperate the data into different columns seperated by comma, the easier way*/

SELECT 
  SUBSTRING_INDEX(OwnerAddress, ',', 1) AS Address,                      -- First part (before the first comma)
  SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2), ',', -1) AS City, -- Second part (between the first and second comma)
  SUBSTRING_INDEX(OwnerAddress, ',', -1) AS State                       -- Last part (after the last comma)
FROM housing.nashvillehousing;

ALTER TABLE housing.nashvillehousing
ADD COLUMN Address VARCHAR(255),
ADD COLUMN City VARCHAR(255),
ADD COLUMN State VARCHAR(255);

UPDATE housing.nashvillehousing
SET 
  Address = SUBSTRING_INDEX(OwnerAddress, ',', 1),                      -- Extract first part (before the first comma)
  City = SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2), ',', -1), -- Extract second part (between the first and second comma)
  State = SUBSTRING_INDEX(OwnerAddress, ',', -1);                        -- Extract last part (after the last comma)

SET SQL_SAFE_UPDATES = 0;

select *
from housing.nashvillehousing;


/* Change Y and N to Yes and No in " Sold as Vacant" field */

SELECT SoldAsVacant, COUNT(SoldAsVacant)
FROM housing.nashvillehousing
GROUP BY SoldAsVacant
Order by 2;

Select SoldAsVacant
, CASE when SoldAsVacant = 'Y' then 'Yes'
when SoldAsVacant = 'N' then 'No'
else SoldAsVacant
End 
FROM housing.nashvillehousing;


Update nashvillehousing
set SoldAsVacant = CASE when SoldAsVacant = 'Y' then 'Yes'
when SoldAsVacant = 'N' then 'No'
else SoldAsVacant
End ;


/* Remove duplicates, I prefer Excel but this is a demonstration*/

WITH RowNumCTE AS (
    SELECT 
        UniqueID,
        ROW_NUMBER() OVER (
            PARTITION BY ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
            ORDER BY UniqueID
        ) AS row_num
    FROM housing.nashvillehousing
)

DELETE FROM housing.nashvillehousing
WHERE UniqueID IN (
    SELECT UniqueID
    FROM RowNumCTE
    WHERE row_num > 1
);

select *
from housing.nashvillehousing;

-- order by PropertyAddress;


/* Delete unused columns*/

select *
from housing.nashvillehousing

ALTER TABLE housing.nashvillehousing 
DROP COLUMN SaleDate;

