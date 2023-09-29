CREATE DATABASE OLAP_Pharmacy
USE OLAP_Pharmacy

--Create Table OLAP--
CREATE TABLE CustomerDimension(
	CustomerCode INT PRIMARY KEY IDENTITY,
	CustomerId CHAR(10),
	CustomerName VARCHAR(100),
	CustomerGender VARCHAR(10),
	CustomerDOB DATE,
	CustomerAddress VARCHAR(100),
	CustomerPhoneNumber VARCHAR(15),
	CustomerEmail VARCHAR(100)
)

--EmployeeDimension--
CREATE TABLE EmployeeDimension(
	EmployeeCode INT PRIMARY KEY IDENTITY,
	EmployeeId CHAR(10),
	EmployeeName VARCHAR(100),
	EmployeeSalary MONEY,
	EmployeeGender VARCHAR(10),
	BranchName VARCHAR(100),
	CityName VARCHAR(100),
	ValidFrom DATETIME,
	ValidTo DATETIME
)

--DoctorDimension--
CREATE TABLE DoctorDimension(
	DoctorCode INT PRIMARY KEY IDENTITY,
	DoctorId CHAR(10),
	DoctorName VARCHAR(100),
	DoctorEmail VARCHAR(100),
	DoctorPhoneNumber VARCHAR(15)
)

--SupplierDimension--
CREATE TABLE SupplierDimension(
	SupplierCode INT PRIMARY KEY IDENTITY,
	SupplierId CHAR(10),
	SupplierName VARCHAR(100),
	SupplierAddress VARCHAR(100),
	CityName VARCHAR(100)
)

--MedicineDimension--
CREATE TABLE MedicineDimension(
	MedicineCode INT PRIMARY KEY IDENTITY,
	MedicineId CHAR(10),
	MedicineName VARCHAR(100),
	MedicineSellingPrice MONEY,
	MedicinePurchasePrice MONEY,
	MedicineTypeName VARCHAR(100),
	ValidFrom DATETIME,
	ValidTo DATETIME
)

--EquipmentDimension--
CREATE TABLE EquipmentDimension(
	EquipmentCode INT PRIMARY KEY IDENTITY,
	EquipmentId CHAR(10),
	EquipmentName VARCHAR(100),
	EquipmentPrice MONEY,
	EquipmentTypeName VARCHAR(100),
	ValidFrom DATETIME,
	ValidTo DATETIME
) 

--BranchDimension--
CREATE TABLE BranchDimension(
	BranchCode INT PRIMARY KEY IDENTITY,
	BranchId CHAR(10),
	BranchName VARCHAR(100),
	CityName VARCHAR(100),
	BranchAddress VARCHAR(100)
)


--TimeDimension--
CREATE TABLE TimeDimension(
	TimeCode INT PRIMARY KEY IDENTITY,
	[Date] DATE,
	[Day] INT,
	[Month] INT,
	[Quarter] INT,
	[Year] INT
)

--FilterTimeStamp--
CREATE TABLE FilterTimeStamp(
	TableName VARCHAR(50),
	LastETL DATETIME 
)

--MedicineSalesFact--

CREATE TABLE MedicinePurchaseTransactionFact(
	SupplierCode INT,
	EmployeeCode INT,
	BranchCode INT,
	MedicineCode INT,
	TimeCode INT,
	[Total Purchase Cost] BIGINT,
	[Total Purchased Medicine] BIGINT
)

CREATE TABLE MedicineSalesTransactionFact(
	CustomerCode INT, 
	EmployeeCode INT,
	BranchCode INT,
	MedicineCode INT,
	TimeCode INT,
	[Total Medicine Sales Earning] BIGINT,
	[Total Medicine Sold] BIGINT
)

CREATE TABLE MedicalEquipmentSalesTransactionFact(
	CustomerCode INT,
	EmployeeCode INT,
	EquipmentCode INT,
	TimeCode INT,
	[Total Medical Equipment Sales Earning] BIGINT,
	[Average Medical Equipment Sold] BIGINT
)

CREATE TABLE ConsultationTransactionFact(
	CustomerCode INT,
	DoctorCode INT,
	TimeCode INT,
	[Average consultation price] BIGINT,
	[Customer consultation count] BIGINT
)
