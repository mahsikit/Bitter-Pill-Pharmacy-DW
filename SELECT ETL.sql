--ETL Process--
SELECT 
	CustomerId,
	CustomerName,
	CustomerGender, 
	CustomerDOB,
	CustomerAddress,
	CustomerPhoneNumber,
	CustomerEmail
FROM [Bitter Pill Pharmacy]..MsCustomer

SELECT
	EmployeeId,
	EmployeeName, 
	EmployeeSalary,
	EmployeeGender,
	BranchName,
	CityName 
FROM [Bitter Pill Pharmacy]..MsEmployee me
JOIN [Bitter Pill Pharmacy]..MsBranch mb 
ON me.BranchId = mb.BranchId
JOIN [Bitter Pill Pharmacy]..MsCity mc
ON mb.CityId = mc.CityId


SELECT 
	DoctorId,
	DoctorName,
	DoctorEmail,
	DoctorPhoneNumber
FROM [Bitter Pill Pharmacy]..MsDoctor

SELECT 
	SupplierId, 
	SupplierName, 
	SupplierAddress,
	CityName
FROM [Bitter Pill Pharmacy]..MsSupplier ms
JOIN [Bitter Pill Pharmacy]..MsCity mc
ON ms.CityId = mc.CityId

SELECT 
	MedicineId,
	MedicineName,
	MedicineSellingPrice,
	MedicinePurchasePrice,
	MedicineTypeName
FROM [Bitter Pill Pharmacy]..MsMedicine mm
JOIN [Bitter Pill Pharmacy]..MsMedicineType mt
ON mm.MedicineTypeId = mt.MedicineTypeId

SELECT
	EquipmentId,
	EquipmentName,
	EquipmentPrice,
	EquipmentTypeName
FROM [Bitter Pill Pharmacy]..MsEquipment me 
JOIN [Bitter Pill Pharmacy]..MsEquipmentType mt 
ON me.EquipmentTypeId = mt.EquipmentTypeId

SELECT 
	BranchId,
	BranchName,
	CityName,
	BranchAddress
FROM [Bitter Pill Pharmacy]..MsBranch mb
JOIN [Bitter Pill Pharmacy]..MsCity mc
ON mb.CityId = mc.CityId

--Time Dimension--
SELECT
	AllDate.Date AS [Date],
	DAY(AllDate.Date) AS [Day],
	MONTH(AllDate.Date) AS [Month],
	DATEPART(QUARTER, AllDate.Date) AS [Quarter],
	YEAR(AllDate.Date) AS [Year]
FROM(
	SELECT MedicinePurchaseDate AS [Date]
	FROM [Bitter Pill Pharmacy]..TrMedicinePurchaseHeader
	UNION
	SELECT MedicineSalesDate AS [Date]
	FROM [Bitter Pill Pharmacy]..TrMedicineSalesHeader
	UNION
	SELECT EquipmentSalesDate AS [Date]
	FROM [Bitter Pill Pharmacy]..TrMedicalEquipmentSalesHeader
	UNION
	SELECT ConsultationDate AS [Date]
	FROM [Bitter Pill Pharmacy]..TrConsultationHeader
) AllDate

--ETL Time Dimension--
IF EXISTS(
	SELECT *
	FROM FilterTimeStamp
	WHERE TableName = 'TimeDimension'
)
BEGIN 
	SELECT DISTINCT
		AllDate.Date AS [Date],
		DAY(AllDate.Date) AS [Day],
		MONTH(AllDate.Date) AS [Month],
		DATEPART(QUARTER, AllDate.Date) AS [Quarter],
		YEAR(AllDate.Date) AS [Year]
	FROM(
		SELECT MedicinePurchaseDate AS [Date]
		FROM [Bitter Pill Pharmacy]..TrMedicinePurchaseHeader
		UNION
		SELECT MedicineSalesDate AS [Date]
		FROM [Bitter Pill Pharmacy]..TrMedicineSalesHeader
		UNION
		SELECT EquipmentSalesDate AS [Date]
		FROM [Bitter Pill Pharmacy]..TrMedicalEquipmentSalesHeader
		UNION
		SELECT ConsultationDate AS [Date]
		FROM [Bitter Pill Pharmacy]..TrConsultationHeader
	) AllDate
	WHERE [Date] > (
		SELECT LastETL
		FROM FilterTimeStamp
		WHERE TableName = 'TimeDimension'
	)
END ELSE BEGIN
	SELECT DISTINCT
		AllDate.Date AS [Date],
		DAY(AllDate.Date) AS [Day],
		MONTH(AllDate.Date) AS [Month],
		DATEPART(QUARTER, AllDate.Date) AS [Quarter],
		YEAR(AllDate.Date) AS [Year]
	FROM(
		SELECT MedicinePurchaseDate AS [Date]
		FROM [Bitter Pill Pharmacy]..TrMedicinePurchaseHeader
		UNION
		SELECT MedicineSalesDate AS [Date]
		FROM [Bitter Pill Pharmacy]..TrMedicineSalesHeader
		UNION
		SELECT EquipmentSalesDate AS [Date]
		FROM [Bitter Pill Pharmacy]..TrMedicalEquipmentSalesHeader
		UNION
		SELECT ConsultationDate AS [Date]
		FROM [Bitter Pill Pharmacy]..TrConsultationHeader
	) AllDate
END

--Insert FilterTimeStamp--
IF EXISTS(
	SELECT *
	FROM FilterTimeStamp
	WHERE TableName = 'TimeDimension'
) BEGIN
	UPDATE FilterTimeStamp
	SET LastETL = GETDATE()
	WHERE TableName = 'TimeDimenison'
END ELSE BEGIN
INSERT INTO FilterTimeStamp VALUES
('TimeDimension', GETDATE())
END

SELECT * FROM TimeDimension