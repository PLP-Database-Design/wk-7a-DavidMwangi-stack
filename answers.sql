QUESTION ONE:
WITH RECURSIVE SplitProducts AS (
  -- Anchor query: Initialize splitting
  SELECT 
    OrderID,
    CustomerName,
    TRIM(SUBSTRING_INDEX(Products, ',', 1)) AS Product, -- Extract first product
    SUBSTRING(Products, LENGTH(SUBSTRING_INDEX(Products, ',', 1)) + 2) AS Remainder -- Remainder after first product
  FROM ProductDetail

  UNION ALL

  -- Recursive query: Split remaining products
  SELECT 
    OrderID,
    CustomerName,
    TRIM(SUBSTRING_INDEX(Remainder, ',', 1)), -- Extract next product
    SUBSTRING(Remainder, LENGTH(SUBSTRING_INDEX(Remainder, ',', 1)) + 2) -- Update remainder
  FROM SplitProducts
  WHERE Remainder != '' -- Stop when no more products remain
)

-- Final result (1NF-compliant)
SELECT OrderID, CustomerName, Product
FROM SplitProducts
WHERE Product != '';


QUESTION TWO:
