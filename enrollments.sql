--USE Cheyenne
set nocount on
SELECT	
		--quotename(CONCAT(r.rosterid, sp.termid, sp.periodid), '"') 
		quotename( cast(r.rosterid AS varchar) + cast(sp.termid AS varchar) + cast(sp.periodid AS varchar) , '"') AS '"ID"' , quotename(s.personID, '"') AS '"StudentID"', quotename(sec.sectionid, '"') AS '"CourseID"',
		quotename(isnull(CONVERT(Char(10),r.startDate,101), CONVERT(Char(10),t.startdate,101)), '"') AS '"StartDate"', 
		quotename(isnull(CONVERT(Char(10),r.enddate,101), CONVERT(Char(10),t.enddate,101)), '"') AS '"EndDate"'

From Student AS s
	--INNER JOIN Student as s1 ON s.personid = s1.personid
	INNER JOIN Roster as r ON s.personid = r.personid
	INNER JOIN Trial as Tr ON r.trialid = tr.trialid AND s.calendarid = tr.calendarid
	INNER JOIN Section as sec ON r.sectionid = sec.sectionid
	INNER JOIN Course as c ON sec.courseid = c.courseid
	INNER JOIN Calendar as cal ON c.calendarid = cal.calendarid
	INNER JOIN SectionPlacement AS sp on sec.sectionid = sp.sectionid
	INNER JOIN Term as T ON sp.termid = t.termid

WHERE tr.active = '1' AND cal.endyear = $(currentendyear) AND s.endYear = $(currentendyear) AND (s.endDate IS NULL OR NOT EXISTS (SELECT * from student WHERE endDate IS NULL AND endYear = $(currentendyear)))AND (s.schoolid >= '2' AND s.schoolid <= '4')-- AND s.personid = '3407'
ORDER BY '"ID"' ASC