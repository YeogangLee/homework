WHERE 1]

SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('1982/01/01', 'YYYY/MM/DD') AND TO_DATE('1983/01/01', 'YYYY/MM/DD');


WHERE 3]

SELECT userid
FROM users
WHERE userid IN ('brown', 'cony', 'sally');
-- userid 컬럼만 조회

SELECT *
FROM users
WHERE userid IN ('brown', 'cony', 'sally');
-- users 테이블의 모든 컬럼 조회


WHERE 4]

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '신%';


WHERE 5]

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%이%';


WHERE 6]

SELECT *
FROM emp
WHERE comm IS NULL;

SELECT *
FROM emp
WHERE mgr IS NULL;


WHERE 7]

SELECT *
FROM emp
WHERE job = 'SALESMAN' AND hiredate >= TO_DATE('1981/01/01', 'YYYY/MM/DD');


WHERE 8]

SELECT *
FROM emp
WHERE deptno != 10 AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');


WHERE 9]

SELECT *
FROM emp
WHERE deptno NOT IN (10) AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');


WHERE 10]

SELECT *
FROM emp
WHERE deptno IN (20, 30) AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');


WHERE 11]

SELECT *
FROM emp
WHERE job = 'SALESMAN' OR hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');


WHERE 12]

SELECT *
FROM emp
WHERE job = 'SALESMAN' OR empno LIKE '78%';


WHERE 13]

SELECT *
FROM emp
WHERE job = 'SALESMAN' OR empno BETWEEN 7800 AND 7899;
