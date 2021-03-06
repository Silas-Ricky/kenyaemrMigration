/****** Object:  UserDefinedFunction [dbo].[fn_ARTRegimenORDER]    Script Date: 5/4/2020 9:25:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[fn_ARTRegimenORDER]( @list VARCHAR(max))
RETURNS   varchar(max)

AS
BEGIN 


DECLARE @str VARCHAR(150) = ''
declare @rET VARCHAR(150)
DECLARE @t table(Txt VARCHAR(150))
SET @list = @list + '+'
SET @list = REPLACE (@list,',','+')
SET @list = REPLACE(@list,' ','')
;WITH cte AS 
(
	SELECT SUBSTRING(@list,1,PATINDEX('%+%',@list)-1) AS fchar,SUBSTRING(@list,PATINDEX('%+%',@list)+1,LEN(@list)) AS rem
	UNION ALL
	SELECT SUBSTRING(rem,1,PATINDEX('%+%',rem)-1),SUBSTRING(rem,PATINDEX('%+%',rem)+1,LEN(rem)) FROM cte
	WHERE PATINDEX('%+%',rem) <> 0
)
INSERT @t 
SELECT fchar FROM cte ORDER BY fchar ASC

SELECT 
	@str = @str + COALESCE (Txt,'')+ '+' 
FROM 
(SELECT TOP 100 PERCENT txt FROM @T 
GROUP BY Txt 
) AS X


--INSERT @TBL (col)
set @rET =  SUBSTRING (@str,1,LEN(@str)-1)

--SELECT Col FROM  @TBL
IF LEN (@Ret) = 0 SET @rET= NULL 


RETURN  @rET
	
END 


