
--:SETVAR currentendyear 2016
Set nocount on
Select	quotename(rp.relatedpairguid, '"') AS '"ID"', quotename(rp.personid1, '"')AS '"StudentID"', quotename(rp.personid2, '"')AS '"GuardianID"',
			quotename(rt.typeid, '"') AS '"RelationshipID"'
		FROM Student as s
			INNER JOIN RelatedPair as rp ON s.personid = rp.personid1
			INNER JOIN RelationshipType AS rt on rp.name = rt.name
			INNER JOIN Person as P ON rp.personid2 = p.personid
			--INNER JOIN [identity] as i ON p.personid = i.personid
		WHERE s. servicetype = 'P' AND s.endYear = $(currentendyear) AND (s.endDate IS NULL OR NOT EXISTS (SELECT * from student WHERE endDate IS NULL AND endYear = $(currentendyear))) 
			AND rp.guardian = '1' AND rp.guardian = '1' AND (s.schoolid >= '2' AND s.schoolid <= '4')
ORDER BY rp.personid1