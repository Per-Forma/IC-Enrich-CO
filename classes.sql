--USE cheyenne
set nocount on
SELECT	quotename(sec.sectionid, '"') AS '"ID"', quotename(cal.schoolid, '"') AS '"SchoolID"', quotename(sec.teacherpersonid, '"') AS '"TeacherID"',
		quotename(c.name, '"') AS '"CourseName"', quotename(sec.number, '"') AS '"SectionName"'

From Section as sec
	INNER JOIN Course as c ON sec.courseid = c.courseid
	INNER JOIN Calendar as cal ON c.calendarid = cal.calendarid

WHERE cal.endYear = $(currentendyear) AND (cal.schoolid >= '2' AND cal.schoolid <= '4') AND c.active = 'True'