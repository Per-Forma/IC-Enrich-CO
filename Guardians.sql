
--:SETVAR currentendyear 2016
Set nocount on
SELECT quotename(p.personid, '"') as '"ID"', isnull(quotename(i.firstname, '"'), '""') AS '"FirstName"', isnull(quotename(i.lastname, '"'), '""') as '"LastName"',
	quotename(CASE WHEN a.postofficebox = '0' THEN '' ELSE 'P.O. Box ' END + ISNULL(a.number + ' ','') + ISNULL(a.dir + ' ','') +
	ISNULL(a.prefix + ' ','') + ISNULL(a.street, '') + ISNULL(' ' + a.tag, '') + ISNULL(' ' + 'Apt. ' + a.apt,''), '"') AS '"Street"',
	isnull(quotename(a.city, '"'), '""') AS '"City"', isnull(quotename(a.State, '"'), '""') AS '"State"', isnull(quotename(a.zip, '"'), '""') AS '"ZipCode"',
	isnull(quotename(h.Phone, '"'), '""') as '"HomePhoneNumber"'
FROM Person as p
	INNER JOIN (
		Select i.*, s.firstname as sfn, s.lastname as sln, row_number() over (partition by p.personid order by rp.personid1) as seqnum
		FROM Student as s
			INNER JOIN RelatedPair as rp ON s.personid = rp.personid1
			INNER JOIN Person as P ON rp.personid2 = p.personid
			INNER JOIN [identity] as i ON p.currentidentityid = i.identityid
		WHERE s.endYear = $(currentendyear) AND (s.endDate IS NULL OR NOT EXISTS (SELECT * from student WHERE endDate IS NULL AND endYear = $(currentendyear))) AND
			rp.guardian = '1' AND (s.schoolid >= '2' AND s.schoolid <= '4')) as sti
		
		ON p.personid = sti.personid and seqnum = 1
	INNER JOIN [identity] as i ON p.currentidentityid = i.identityid
	INNER JOIN (Select *, row_number() over (partition BY hhm.personid ORDER BY hhm.startdate ASC) as seqnum
			FROM HouseholdMember AS hhm
			WHERE hhm.enddate IS NULL AND hhm.secondary != '1') AS HM ON p.personid = hm.personid
	INNER JOIN household as h on hm.householdid = h.householdid
	INNER JOIN householdlocation as hl on h.householdid = hl.householdid
	INNER JOIN [address] as a ON hl.addressid = a.addressid
	
WHERE hm.enddate IS NULL AND hm.secondary != '1' AND hl.enddate IS NULL AND hl.secondary != '1' AND hl.mailing = '1' AND hm.seqnum = '1'
ORDER BY '"ID"'