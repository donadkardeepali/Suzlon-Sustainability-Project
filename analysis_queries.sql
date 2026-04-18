CREATE DATABASE Suzlon_Green_Campus;
USE Suzlon_Green_Campus;
CREATE TABLE Utility_Logs (
    Log_ID INT PRIMARY KEY,
    Building_Name VARCHAR(50),
    Month_Year DATE,
    Energy_Type VARCHAR(20), -- Wind, Solar, or Grid
    Units_Consumed FLOAT,
    Cost_INR FLOAT
);
CREATE TABLE Space_Utilization (
    Floor_ID VARCHAR(10) PRIMARY KEY,
    Department VARCHAR(50),
    Total_Desks INT,
    Occupied_Desks INT,
    Last_Audit_Date DATE
);
INSERT INTO Utility_Logs VALUES 
(1, 'Pearl Building', '2026-03-01', 'Wind', 8500, 0),
(2, 'Pearl Building', '2026-03-01', 'Grid', 1500, 12000),
(3, 'Diamond Building', '2026-03-01', 'Solar', 7000, 0),
(4, 'Diamond Building', '2026-03-01', 'Grid', 500, 4000);
INSERT INTO Space_Utilization VALUES 
('L1-East', 'Finance', 100, 85, '2026-04-10'),
('L1-West', 'Operations', 150, 145, '2026-04-10');

SELECT 
    Building_Name,
    SUM(CASE WHEN Energy_Type != 'Grid' THEN Units_Consumed ELSE 0 END) AS Green_Units,
    SUM(CASE WHEN Energy_Type = 'Grid' THEN Units_Consumed ELSE 0 END) AS Grid_Units,
    ROUND(SUM(Cost_INR), 2) AS Total_Electricity_Cost
FROM Utility_Logs
GROUP BY Building_Name;

SELECT 
    Department, 
    Total_Desks, 
    Occupied_Desks,
    (Total_Desks - Occupied_Desks) AS Vacant_Desks,
    ROUND((Occupied_Desks * 100.0 / Total_Desks), 2) AS Occupancy_Percentage
FROM Space_Utilization
WHERE (Occupied_Desks * 100.0 / Total_Desks) > 90; 
