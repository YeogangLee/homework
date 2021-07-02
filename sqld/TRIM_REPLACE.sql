-- TRIM 되는 경우
SELECT TRIM('  SQL  ')
      ,TRIM('X' FROM 'XXSQLXX')
      ,TRIM(BOTH 'X' FROM 'XXSQLXX')
      ,LTRIM('XXSQL', 'X')
      ,RTRIM('SQLXX', 'X')
FROM DUAL;

-- TRIM 안되는 경우
TRIM('XXSQLXX', 'X')
TRIM('XXSQLXX' FROM 'X')

-- REPLACE
SELECT REPLACE('XXSQLXX', 'X')
FROM DUAL;


--SELECT TRIM(' 테스트입니다 ') AS TRIM_ONE 
--           ,TRIM('다' FROM '다는 테스트입니다') AS TRIM_TWO
--           ,TRIM(BOTH '다' FROM '다는 테스트입니다') AS TRIM_THREE 
--           ,TRIM(LEADING '다' FROM '다는 테스트입니다') AS TRIM_FOUR
--           ,TRIM(TRAILING '다' FROM '다는 테스트입니다') AS TRIM_FIVE
--FROM DUAL
--
--출처: https://devjhs.tistory.com/92 [키보드와 하루]