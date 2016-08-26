
Set nocount on
set ansi_warnings off
SELECT quotename(s.personID, '"') AS '"ID"', quotename(s.firstName, '"') AS '"FirstName"', isnull(quotename(s.middleName, '"'), '""') AS '"MiddleName"', quotename(s.lastName, '"') AS '"LastName"',
	quotename(s.schoolID, '"') AS '"SchoolID"', isnull(quotename(s.stateID, '"'), '""') AS '"DistrictNumber"', quotename(s.grade, '"') AS '"GradeLevelCode"',
	isnull(quotename(s.stateID, '"'), '""') AS '"StateNumber"', quotename(CONVERT(Char(10),s.birthdate,101), '"') AS '"BirthDate"',
	quotename(s.raceEthnicity, '"') AS '"EthnicityCode"', quotename(CASE WHEN s.hispanicEthnicity = 'Y' THEN 1 ELSE 0 END, '"') AS '"IsHispanic"',
	quotename(s.gender, '"') AS '"GenderCode"', quotename(CASE WHEN a.postofficebox = '0' THEN '' ELSE 'P.O. Box ' END + ISNULL(a.number + ' ','') + ISNULL(a.dir + ' ','') +
	ISNULL(a.prefix + ' ','') + ISNULL(a.street, '') + ISNULL(' ' + a.tag, '') + ISNULL(' ' + 'Apt. ' + a.apt,''), '"') AS '"Street"',
	quotename(a.city, '"') AS '"City"', quotename(a.State, '"') AS '"State"', isnull(quotename(a.zip, '"'), '""') AS '"ZipCode"', isnull(quotename(h.Phone, '"'), '""') as '"PhoneNumber"', isnull(quotename(e.residentDistrict, '"'), '""') AS '"DistrictofResidence"', isnull(quotename(e.residentSchool, '"'), '""') AS '"SchoolofResidence"',
	isnull(quotename(i.homePrimaryLanguage, '"'), '""') AS '"x_HomeLanguage"', isnull(quotename(c.email, '"'), '""') AS '"x_EmailAddress"', isnull(quotename(CASE WHEN c.communicationlanguage = 'en_US' THEN 'eng' WHEN c.communicationlanguage = 'es_MX' THEN 'spa' ELSE NULL END, '"'), '""') AS '"x_PrimaryLanguageID"',
	isnull(quotename(fs.x_SpedFundingStatusID, '"'), '""') AS '"x_SpedFundingStatusID"', isnull(quotename(e.stateaid, '"'), '""') AS '"x_PupilAttendanceInfoID"', isnull(quotename(fs.x_EducationalOrphanID, '"'), '""') AS '"x_EducationalOrphanID"',
	isnull(quotename(c.cellphone, '"'), '""') as '"x_CellPhone"', isnull(quotename(fs.x_ParentallyPlacedInPrivateSchoolID, '"'), '""') AS '"x_ParentallyPlacedInPrivateSchoolID"',
	isnull(quotename(a.State, '"'), '""') AS '"x_ParentResidenceStateID"'

	--CASE WHEN a.postofficebox = '0' THEN 'nope' ELSE 'yep' END AS POBox, a.postofficebox
	--, hm.memberID, h.householdid, hl.locationid, hl.secondary 
From Student AS s INNER JOIN (Select *, row_number() over (partition BY hhm.personid ORDER BY hhm.startdate) as seqnum
	FROM HouseholdMember AS hhm
	WHERE hhm.enddate IS NULL) AS HM ON s.personID = hm.personID
	INNER JOIN Household as H ON hm.HouseholdID = h.HouseholdID
	INNER JOIN HouseholdLocation as hl ON h.householdID = hl.householdID
	INNER JOIN Address AS a on hl.addressID = a.addressID
	INNER JOIN Enrollment AS e on s.enrollmentid = e.enrollmentid
	INNER JOIN [Identity] AS I on s.identityid = i.identityid
	LEFT OUTER JOIN Contact AS c on s.personid = c.personid
	LEFT OUTER JOIN (SELECT 
		max(case when attributeid = '223' then enrollmentid end) enrollmentid,
		max(case when attributeid = '223' then value end) x_SpedFundingStatusID, 
		max(case when attributeid = '110' then value end) x_EducationalOrphanID,
		max(case when attributeid = '222' then value end) x_ParentallyPlacedInPrivateSchoolID
			FROM CustomStudent
			WHERE attributeid = '149' OR attributeid = '58' OR attributeid = '148'
			GROUP BY enrollmentid) AS FS on s.enrollmentid = fs.enrollmentid

WHERE e.servicetype = 'P' AND s.endYear = $(currentendyear) AND hm.secondary != '1' AND hm.endDate IS NULL AND hl.endDate IS NULL 
	AND hl.secondary = '0' AND (s.endDate IS NULL OR NOT EXISTS (SELECT * from student WHERE endDate IS NULL AND endYear = $(currentendyear))) AND hl.mailing = '1' AND 
	(s.schoolid >= '2' AND s.schoolid <= '4') and hm.seqnum = '1'
	ORDER BY '"ID"' ASC