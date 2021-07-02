SELECT COUNT(*)
FROM TB_CHARGE
WHERE AUDIENCE_CD = '01';

SELECT COUNT(*)
FROM TB_CHARGE
GROUP BY(AUDIENCE_CD);

--
SELECT *
FROM TB_CHARGE
WHERE WEEKEND_YN = 'N'
  AND AUDIENCE_CD = '01'
  AND TB_CHARGE.TIME_CD = (SELECT CD
                              FROM TB_CODE
                             WHERE GROUP_CD = 'A03'
                               AND CD = '01');
                               
SELECT TRUNC(AVG(PRICE))
FROM TB_CHARGE
WHERE WEEKEND_YN = 'N'
  AND AUDIENCE_CD = '01'
  AND TB_CHARGE.TIME_CD = (SELECT CD
                              FROM TB_CODE
                             WHERE GROUP_CD = 'A03'
                               AND CD = '01')
GROUP BY (SEAT_CD);


SELECT
    CASE
        WHEN MOD(TRUNC(AVG(PRICE)),500) > 0
        THEN TRUNC(AVG(PRICE)) - MOD(TRUNC(AVG(PRICE)),500) + 500
        ELSE AVG(PRICE)
    END PRICE
FROM TB_CHARGE
WHERE WEEKEND_YN = 'N'
  AND AUDIENCE_CD = '01'
  AND TB_CHARGE.TIME_CD = (SELECT CD
                              FROM TB_CODE
                             WHERE GROUP_CD = 'A03'
                               AND CD = '01')
GROUP BY (SEAT_CD);

--
SELECT DECODE(WEEKEND_YN, 'N', '주중', 'Y', '주말', '0') AS WEEKEND_YN, TB_CHARGE.AUDIENCE_CD, TB_CHARGE.SEAT_CD
  FROM TB_CHARGE,
  
  (SELECT SEAT_CD,
    CASE
        WHEN MOD(TRUNC(AVG(PRICE)),500) > 0
        THEN TRUNC(AVG(PRICE)) - MOD(TRUNC(AVG(PRICE)),500) + 500
        ELSE AVG(PRICE)
    END PRICE
FROM TB_CHARGE
WHERE WEEKEND_YN = 'N'
  AND AUDIENCE_CD = '01'
  AND TB_CHARGE.TIME_CD = (SELECT CD
                              FROM TB_CODE
                             WHERE GROUP_CD = 'A03'
                               AND CD = '01')
GROUP BY (SEAT_CD)
ORDER BY SEAT_CD) SEAT_PRICE
  
  
 WHERE TB_CHARGE.SEAT_CD = SEAT_PRICE.SEAT_CD
   AND WEEKEND_YN = 'N'
   AND AUDIENCE_CD = '01'
   AND TIME_CD = (SELECT CD
                    FROM TB_CODE
                   WHERE GROUP_CD = 'A03'
                     AND CD = '01')
GROUP BY (WEEKEND_YN, AUDIENCE_CD, TB_CHARGE.SEAT_CD)
ORDER BY SEAT_CD;

--
SELECT SEAT_CD,
    CASE
        WHEN MOD(TRUNC(AVG(PRICE)),500) > 0
        THEN TRUNC(AVG(PRICE)) - MOD(TRUNC(AVG(PRICE)),500) + 500
        ELSE AVG(PRICE)
    END PRICE
FROM TB_CHARGE
WHERE WEEKEND_YN = 'N'
  AND AUDIENCE_CD = '01'
  AND TB_CHARGE.TIME_CD = (SELECT CD
                              FROM TB_CODE
                             WHERE GROUP_CD = 'A03'
                               AND CD = '01')
GROUP BY (SEAT_CD)
ORDER BY SEAT_CD;
                               