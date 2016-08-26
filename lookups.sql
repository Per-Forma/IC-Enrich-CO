
Set nocount on
--:SETVAR currentendyear 2016
SELECT '"REL"' AS '"Type"', quotename(fq.typeid, '"') AS '"Code"', '""' AS '"StateCode"', isnull(quotename(fq.name, '"'), '""') AS '"Label"', quotename(fq.Sequence, '"') AS '"Sequence"'

FROM(

Select DISTINCT ort.typeid, ort.name, Sequence = ROW_NUMBER() OVER (Order BY (SELECT 1))
FROM Relationshiptype AS ort
	LEFT OUTER JOIN(	
		Select DISTINCT	rt.typeid, rt.name
				FROM Relationshiptype as rt
					INNER JOIN RelatedPair as rp ON rt.name = rp.name
					INNER JOIN Student as s on rp.personid1 = s.personid
					INNER JOIN Person as P ON rp.personid2 = p.personid
					--INNER JOIN [identity] as i ON p.personid = i.personid
				WHERE s. servicetype = 'P' AND s.endYear = $(currentendyear) AND (s.endDate IS NULL OR NOT EXISTS (SELECT * from student WHERE endDate IS NULL AND endYear = $(currentendyear))) 
					AND rp.guardian = '1' AND rp.guardian = '1'
					) AS SQ on ort.typeid = sq.typeid
) AS FQ

UNION
SELECT '"ETH"' AS '"Type"', '"01"' AS '"Code"', '"01"' AS '"StateCode"', '"American Indian or Alaska Native"' AS '"Label"', '"1"' AS '"Sequence"'
UNION
SELECT '"ETH"' AS '"Type"', '"02"' AS '"Code"', '"02"' AS '"StateCode"', '"Asian"' AS '"Label"', '"2"' AS '"Sequence"'
UNION
SELECT '"ETH"' AS '"Type"', '"03"' AS '"Code"', '"03"' AS '"StateCode"', '"Black or African American"' AS '"Label"', '"3"' AS '"Sequence"'
UNION
SELECT '"ETH"' AS '"Type"', '"04"' AS '"Code"', '"04"' AS '"StateCode"', '"Hispanic or Latino"' AS '"Label"', '"4"' AS '"Sequence"'
UNION
SELECT '"ETH"' AS '"Type"', '"05"' AS '"Code"', '"05"' AS '"StateCode"', '"White"' AS '"Label"', '"5"' AS '"Sequence"'
UNION
SELECT '"ETH"' AS '"Type"', '"06"' AS '"Code"', '"06"' AS '"StateCode"', '"Native Hawaiian or Other Pacific Islander"' AS '"Label"', '"6"' AS '"Sequence"'
UNION
SELECT '"ETH"' AS '"Type"', '"07"' AS '"Code"', '"07"' AS '"StateCode"', '"Multiple Races"' AS '"Label"', '"7"' AS '"Sequence"'