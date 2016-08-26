
set nocount on
SELECT  quotename(schoolID, '"') AS '"ID"', quotename(name, '"') AS '"Name"', quotename(number, '"') AS '"Number"', isnull(quotename(physicalAddress, '"'), '""') AS '"Street"',
		isnull(quotename(physicalCity, '"'), '""') AS '"City"', isnull(quotename(physicalState, '"'), '""') AS '"State"', isnull(quotename(physicalZip, '"'), '""') AS '"ZipCode"',
		isnull(quotename(phone, '"'), '""') AS '"PhoneNumber"'
FROM         School AS sc
WHERE sc.schoolid >= '2' AND sc.schoolid <= '4'