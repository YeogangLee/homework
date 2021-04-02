-- 2021_03_17
SELECT *
FROM 
(SELECT ROWNUM rn, empno, ename
FROM (SELECT empno, ename 
      FROM emp
      ORDER BY ename))
WHERE rn BETWEEN (:page-1)*:pageSize + 1 AND :page*:pageSize ;
-- :page, :pageSize -> 바인드 변수

--2021_03_17 날짜 함수 연습1] 복습 0402
-- 날짜 자리에 바인드변수 적용 불가 ㅠㅠ
SELECT TO_CHAR(TO_DATE('20210506', 'YYYYMMDD')) || ' ' || TO_CHAR(SYSDATE, 'HH24:MI:SS')
FROM dual;

