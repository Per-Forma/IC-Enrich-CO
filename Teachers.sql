
set nocount on
SELECT quotename(sp.personid, '"') as '"ID"', quotename(sp.schoolid, '"') as '"SchoolID"', quotename(sp.firstName, '"') as '"FirstName"', quotename(sp.LastName, '"') as '"LastName"',
	ISNULL(quotename(sp.email, '"'), '""') AS '"EmailAddress"', isnull(quotename(sp.gender, '"'), '""') AS '"GenderCode"', isnull(quotename(sp.stateraceethnicity, '"'), '""') as '"EthnicityCode"',
	isnull(quotename(sp.ssn, '"'), '""') AS '"SSN"', quotename(CASE WHEN sp.postofficebox = '0' THEN '' ELSE 'P.O. Box ' END + ISNULL(sp.number + ' ','') + ISNULL(sp.dir + ' ','') +
	ISNULL(sp.prefix + ' ','') + ISNULL(sp.street, '') + ISNULL(' ' + sp.tag, '') + ISNULL(' ' + 'Apt. ' + sp.apt,''), '"') AS '"Street"',
	ISNULL(quotename(sp.city, '"'), '""') AS '"City"', ISNULL(quotename(sp.zip, '"'), '""') AS '"ZipCode"', ISNULL(quotename(sp.phone, '"'), '""') AS '"PhoneNumber"' 
FROM (
		SELECT *, row_number() over (partition BY ssp.personid ORDER BY ssp.schoolid) as seqnum  
		FROM sif_staffPersonal AS ssp
		WHERE (ssp.schoolid >= '2' AND ssp.schoolid <= '4'))
		as sp
	INNER JOIN UserAccount as ua ON sp.personid = ua.personid
WHERE ua.disable = '0' AND (sp.schoolid >= '2' AND sp.schoolid <= '4') AND sp.seqnum = '1'
AND (ua.homepage != 'portal/main.xsl' OR ua.homepage IS NULL)