-- MedicalEquipmentSalesTransactionFact --

IF EXISTS(
	SELECT * FROM FilterTimeStamp 
	WHERE TableName = 'MedicalEquipmentSalesTransactionFact'
) BEGIN

SELECT 
	CustomerCode,
	EmployeeCode,
	Equipmentcode,
	TimeCode,
[Total Medical Equipment Sales Earning] =  SUM (Quantity * EquipmentPrice),
[Average Medical Equipment Sold] = AVG(Quantity)
FROM [Bitter Pill Pharmacy]..TrMedicalEquipmentSalesHeader tmh
JOIN [Bitter Pill Pharmacy]..TrMedicalEquipmentSalesDetail tmd
ON tmh.EquipmentSalesId = tmd.EquipmentSalesId
JOIN TimeDimension td
ON td.Date = tmh.EquipmentSalesDate
JOIN EquipmentDimension ed
ON ed.EquipmentId = tmd.EquipmentId
JOIN EmployeeDimension emd
ON emd.EmployeeID = tmh.EmployeeId
JOIN CustomerDimension c
ON c.CustomerID = tmh.CustomerID
WHERE tmh.EquipmentSalesDate > (
	SELECT LastETL FROM FilterTimeStamp
	WHERE TableName = 'MedicalEquipmentSalesTransactionFact'
)
GROUP BY TimeCode, CustomerCode, EmployeeCode, EquipmentCode, TimeCode
	END ELSE BEGIN
SELECT 
	CustomerCode,
	EmployeeCode,
	Equipmentcode,
	TimeCode,
[Total Medical Equipment Sales Earning] =  SUM (Quantity * EquipmentPrice),
[Average Medical Equipment Sold] = AVG(Quantity)
FROM [Bitter Pill Pharmacy]..TrMedicalEquipmentSalesHeader tmh
JOIN [Bitter Pill Pharmacy]..TrMedicalEquipmentSalesDetail tmd
ON tmh.EquipmentSalesId = tmd.EquipmentSalesId
JOIN TimeDimension td
ON td.Date = tmh.EquipmentSalesDate
JOIN EquipmentDimension ed
ON ed.EquipmentId = tmd.EquipmentId
JOIN EmployeeDimension emd
ON emd.EmployeeID = tmh.EmployeeId
JOIN CustomerDimension c
ON c.CustomerID = tmh.CustomerID
GROUP BY TimeCode, CustomerCode, EmployeeCode, EquipmentCode, TimeCode
END

-- MedicinePurchaseTransactionFact --
IF EXISTS(
	SELECT * FROM FilterTimeStamp 
	WHERE TableName = 'MedicinePurchaseTransactionFact'
) BEGIN

SELECT TimeCode, 
	SupplierCode, 
	EmployeeCode, 
	BranchCode,
	MedicineCode,
	[Total Purchase Cost] = SUM(Quantity*MedicinePurchasePrice),
	[Total Purchased Medicine] = SUM(Quantity)

FROM [Bitter Pill Pharmacy]..TrMedicinePurchaseHeader tmph
JOIN  [Bitter Pill Pharmacy]..TrMedicinePurchaseDetail tmpd
ON tmph.MedicinePurchaseId = tmpd.MedicinePurchaseId
JOIN TimeDimension td
ON td.Date = tmph.MedicinePurchaseDate
JOIN MedicineDimension md
ON tmpd.MedicineId = md.MedicineId
JOIN SupplierDimension sd
ON tmph.SupplierId =  sd.SupplierId
JOIN EmployeeDimension ed
ON tmph.EmployeeId = ed.EmployeeId
JOIN BranchDimension bd
ON bd.BranchId = tmph.BranchId

WHERE tmph.MedicinePurchaseDate > (
	SELECT LastETL FROM FilterTimeStamp
	WHERE TableName = 'MedicinePurchaseTransactionFact'
)

GROUP BY TimeCode, SupplierCode, EmployeeCode, BranchCode, MedicineCode 

END ELSE BEGIN

SELECT TimeCode, 
	SupplierCode, 
	EmployeeCode, 
	BranchCode,
	MedicineCode,
	[Total Purchase Cost] = SUM(Quantity*MedicinePurchasePrice),
	[Total Purchased Medicine] = SUM(Quantity)

FROM [Bitter Pill Pharmacy]..TrMedicinePurchaseHeader tmph
JOIN  [Bitter Pill Pharmacy]..TrMedicinePurchaseDetail tmpd
ON tmph.MedicinePurchaseId = tmpd.MedicinePurchaseId
JOIN TimeDimension td
ON td.Date = tmph.MedicinePurchaseDate
JOIN MedicineDimension md
ON tmpd.MedicineId = md.MedicineId
JOIN SupplierDimension sd
ON tmph.SupplierId =  sd.SupplierId
JOIN EmployeeDimension ed
ON tmph.EmployeeId = ed.EmployeeId
JOIN BranchDimension bd
ON bd.BranchId = tmph.BranchId

GROUP BY TimeCode, SupplierCode, EmployeeCode, BranchCode, MedicineCode 	
END


-- MedicineSalesTransactionFact --
IF EXISTS(
	SELECT * FROM FilterTimeStamp 
	WHERE TableName = 'MedicineSalesTransactionFact'
) BEGIN

SELECT CustomerCode,
	EmployeeCode,
	BranchCode,
	MedicineCode,
	TimeCode,
	[Total Medicine Sales Earning] = SUM(Quantity*MedicineSellingPrice),
	[Total Medicine Sold] = SUM(Quantity)
FROM [Bitter Pill Pharmacy]..TrMedicineSalesHeader msh
JOIN [Bitter Pill Pharmacy]..TrMedicineSalesDetail msd
ON msh.MedicineSalesId = msd.MedicineSalesId
JOIN TimeDimension td
ON td.Date = msh.MedicineSalesDate
JOIN MedicineDimension md
ON msd.MedicineId = md.MedicineId
JOIN CustomerDimension c
ON c.CustomerId = msh.CustomerId
JOIN EmployeeDimension e
ON e.EmployeeId = msh.EmployeeId
JOIN BranchDimension b
ON b.BranchId = msh.BranchId
WHERE msh.MedicineSalesDate > (
	SELECT LastETL FROM FilterTimeStamp
	WHERE TableName = 'MedicineSalesTransactionFact'
)
GROUP BY CustomerCode, EmployeeCode, BranchCode, MedicineCode, TimeCode

	END ELSE BEGIN
SELECT CustomerCode,
	EmployeeCode,
	BranchCode,
	MedicineCode,
	TimeCode,
	[Total Medicine Sales Earning] = SUM(Quantity*MedicineSellingPrice),
	[Total Medicine Sold] = SUM(Quantity)
FROM [Bitter Pill Pharmacy]..TrMedicineSalesHeader msh
JOIN [Bitter Pill Pharmacy]..TrMedicineSalesDetail msd
ON msh.MedicineSalesId = msd.MedicineSalesId
JOIN TimeDimension td
ON td.Date = msh.MedicineSalesDate
JOIN MedicineDimension md
ON msd.MedicineId = md.MedicineId
JOIN CustomerDimension c
ON c.CustomerId = msh.CustomerId
JOIN EmployeeDimension e
ON e.EmployeeId = msh.EmployeeId
JOIN BranchDimension b
ON b.BranchId = msh.BranchId
GROUP BY CustomerCode, EmployeeCode, BranchCode, MedicineCode, TimeCode
END

-- ConsulationTransactionFact --
IF EXISTS(
	SELECT * FROM FilterTimeStamp 
	WHERE TableName = 'ConsultationTransactionFact'
) BEGIN

SELECT
	CustomerCode,
	DoctorCode,
	TimeCode,
	[Average consultation price] = AVG(ConsultationPrice),
	[Customer consultation count] = COUNT(ConsultationId)

FROM [Bitter Pill Pharmacy]..TrConsultationHeader tch
JOIN DoctorDimension msd
ON tch.DoctorId = msd.DoctorId
JOIN CustomerDimension msc
ON tch.CustomerId = msc.CustomerId
JOIN TimeDimension td
ON td.Date = tch.ConsultationDate
WHERE tch.ConsultationDate > (
	SELECT LastETL FROM FilterTimeStamp
	WHERE TableName = 'ConsultationTransactionFact'
)
GROUP BY CustomerCode, DoctorCode, TimeCode
	END ELSE BEGIN
SELECT
	CustomerCode,
	DoctorCode,
	TimeCode,
	[Average consultation price] = AVG(ConsultationPrice),
	[Customer consultation count] = COUNT(tch.ConsultationId)
FROM [Bitter Pill Pharmacy]..TrConsultationHeader tch
JOIN DoctorDimension msd
ON tch.DoctorId = msd.DoctorId
JOIN CustomerDimension msc
ON tch.CustomerId = msc.CustomerId
JOIN TimeDimension td
ON td.Date = tch.ConsultationDate
GROUP BY CustomerCode, DoctorCode, TimeCode
END
