CREATE OR REPLACE VIEW `northwind`.`vwCustomerOrders` AS
SELECT 
 `northwind`.`orders`.`OrderID`,
 `northwind`.`customers`.`CompanyName`,
 `northwind`.`products`.`ProductName`,
 `northwind`.`order_details`.`Quantity`,
 `northwind`.`order_details`.`UnitPrice` AS `Price`,
 `northwind`.`orders`.`ShippedDate`,
 `northwind`.`shippers`.`CompanyName` AS `ShipperCompany`
FROM 
  `northwind`.`customers`
JOIN 
  `northwind`.`orders`
ON 
  `northwind`.`customers`.`CustomerID`=`northwind`.`orders`.`CustomerID`
JOIN 
  `northwind`.`order_details`
ON 
  `northwind`.`orders`.`OrderID`=`northwind`.`order_details`.`OrderID`
JOIN
  `northwind`.`shippers`
ON
  `northwind`.`orders`.`ShipVia`=`northwind`.`shippers`.`ShipperID`
JOIN 
  `northwind`.`products`
ON
  `northwind`.`order_details`.`ProductID`=`northwind`.`products`.`ProductID`
ORDER BY Quantity;

SELECT * FROM vwCustomerOrders;