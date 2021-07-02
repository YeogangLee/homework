select * from tb_code;

-- 이용자, 가격
select a.cd_name, b.price
from tb_code a, tb_charge b
where a.cd = b.audience_cd
  and a.group_cd = 'A02';
  
-- 시간 구분, 이용자, 가격
select c.cd_name, a.cd_name, b.price
from tb_code a, tb_charge b, tb_code c
where a.cd = b.audience_cd
  and c.cd = b.time_cd
  and a.group_cd = 'A02'
  and c.group_cd = 'A03';
  
  
-- 이용요일, 이용자, 시간, 좌석, 스크린, 가격
SELECT A.WEEKEND_YN, B.CD_NAME, C.CD_NAME, D.CD_NAME, E.CD_NAME, A.PRICE
FROM TB_CHARGE A, TB_CODE B, TB_CODE C, TB_CODE D, TB_CODE E
WHERE A.AUDIENCE_CD = B.CD
  AND A.TIME_CD = C.CD
  AND A.SEAT_CD = D.CD
  AND A.SCREEN_CD = E.CD
  AND B.GROUP_CD = 'A02'
  AND C.GROUP_CD = 'A03'
  AND D.GROUP_CD = 'A04'
  AND E.GROUP_CD = 'A05'
ORDER BY WEEKEND_YN;


-- 자바 페이징 이해, 함수X
select SS.*
		from
		(select S.*, rownum as rnum
            from 
            (SELECT A.WEEKEND_YN, B.CD_NAME, C.CD_NAME, D.CD_NAME, E.CD_NAME, A.PRICE
                FROM TB_CHARGE A, TB_CODE B, TB_CODE C, TB_CODE D, TB_CODE E
                WHERE A.AUDIENCE_CD = B.CD
                  AND A.TIME_CD = C.CD
                  AND A.SEAT_CD = D.CD
                  AND A.SCREEN_CD = E.CD
                  AND B.GROUP_CD = 'A02'
                  AND C.GROUP_CD = 'A03'
                  AND D.GROUP_CD = 'A04'
                  AND E.GROUP_CD = 'A05') S) SS
 where SS.rnum between 1 AND 5;
 
 
 -- 자바 페이징 이해, 함수 O
select SS.*
		from
		(select S.*, rownum as rnum
            from 
            (SELECT DECODE(WEEKEND_YN, 'N', '주중', 'Y', '주말', '0') AS WEEKEND_YN
		     , FN_GETCODENAME('A02', AUDIENCE_CD) AS CD_NAME1
		     , FN_GETCODENAME('A03', TIME_CD) AS CD_NAME2
		     , FN_GETCODENAME('A04', SEAT_CD) AS CD_NAME3
		     , FN_GETCODENAME('A05', SCREEN_CD) AS CD_NAME4
		     , PRICE
		  FROM TB_CHARGE) S) SS
 where SS.rnum between 1 AND 5;
 
 
 -- 자바 페이징 이해, 함수 O, 코드 추가
select SS.*
		from
		(select S.*, rownum as rnum
            from 
            (SELECT CHARGE_CD
             , DECODE(WEEKEND_YN, 'N', '주중', 'Y', '주말', '0') AS WEEKEND_YN
		     , FN_GETCODENAME('A02', AUDIENCE_CD) AS CD_NAME1
		     , FN_GETCODENAME('A03', TIME_CD) AS CD_NAME2
		     , FN_GETCODENAME('A04', SEAT_CD) AS CD_NAME3
		     , FN_GETCODENAME('A05', SCREEN_CD) AS CD_NAME4
		     , PRICE
		  FROM TB_CHARGE) S) SS
 where SS.rnum between 1 AND 5;
 
 
 SELECT GROUP_CD
			 , GROUP_CD_NAME
			 , CD
			 , CD_NAME
			 , CD_DESC
			 , DELETE_YN
		FROM TB_CODE
		WHERE GROUP_CD = 'A05';

SELECT CONCAT('CHG', TO_CHAR(SUBSTR(MAX(CHARGE_CD), 4) + 1)) AS CHARGE_CD
FROM TB_CHARGE;
