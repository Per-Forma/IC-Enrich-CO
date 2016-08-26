
set nocount on
--:SETVAR currentendyear "2015"
SELECT	quotename(s.personID, '"') AS '"StudentID"', quotename(s1.schoolID, '"') AS '"SchoolID"',
		quotename(CONVERT(Char(10),s1.startDate,101), '"') AS '"StartDate"'
		,isnull(quotename(CONVERT(Char(10),s1.endDate,101), '"'),
			CASE WHEN s1.endYear <> $(currentendyear)
				THEN '"6/30/' + convert(char(4),s1.endYear) + '"'
				ELSE '""' END) AS '"EndDate"'

From Student AS s
	INNER JOIN Student as s1 ON s.personid = s1.personid

WHERE s.serviceType = 'P'  AND s1.servicetype = 'P' AND s.endYear = $(currentendyear) AND (s.endDate IS NULL OR NOT EXISTS (SELECT * from student WHERE endDate IS NULL AND endYear = $(currentendyear)))AND (s.schoolid >= '2' AND s.schoolid <= '4')
ORDER BY s.PersonID ASC, s1.grade ASC