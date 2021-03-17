WHERE 13]

SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR empno BETWEEN 7800 AND 7899
OR empno BETWEEN 780 AND 789
OR empno = 78;


WHERE 14]
논리연산(AND, OR 실습 WHERE14)

- emp 테이블에서
1. job이 SALESMAN이거나
2. 사원번호가 78로 시작하면서 입사일자가 1981년 6월 1일 이후인
직원의 정보를 다음과 같이 조회하세요.
(1번 조건 또는 2번 조건을 만족하는 직원)

SELECT *
FROM emp
WHERE job = 'SALESMAN' 
   OR (empno BETWEEN 7800 AND 7899 OR empno BETWEEN 780 AND 789 OR empno = 78 
   AND hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD'));

-- 선생님 작성
SELECT *
FROM emp
WHERE job = 'SALESMAN' OR (empno LIKE '78%' AND hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD'));


-- // WHERE의 기본적 내용 끝


ORDER BY 1]
데이터 정렬

- dept 테이블의 모든 정보를 부서이름으로 오름차순 정렬로 조회되도록 쿼리를 작성하세요
- dept 테이블의 모든 정보를 부서위치로 내림차순 정렬로 조회되도록 쿼리를 작성하세요
* 컬럼명을 명시하지 않았습니다. 지난 수업시간에 배운 내용으로 올바른 컬럼을 찾아보세요.

DESC dept; 

SELECT *
FROM dept
ORDER BY dname;

SELECT *
FROM dept
ORDER BY loc DESC;


ORDER BY 2]
데이터 정렬

- emp 테이블에서 상여comm 정보가 있는 사람들만 조회하고,
상여를 많이 받는 사람이 먼저 조회되도록 정렬하고,
상여가 같을 경우 사번으로 내림차순 정렬하세요.
(상여가 0인 사람은 상여가 없는 것으로 간주)


SELECT *
FROM emp
WHERE comm IS NOT NULL
  AND comm != 0 
-- AND comm > 0
ORDER BY comm DESC, empno DESC;

ASC - 오름차순
DESC - 내림차순


ORDER BY 3]
데이터 정렬

- emp 테이블에서 관리자가 있는 사람들만 조회하고, 직군job 순으로 오름차순 정렬하고,
직군이 같을 경우 사번이 큰 사원이 먼저 조회되도록 쿼리를 작성하세요.

SELECT *
FROM emp
WHERE mgr IS NOT NULL
ORDER BY job, empno DESC;


-- 지금 하는 내용들은 크게 어렵지 않은 것들이다.


ORDER BY 4]
데이터 정렬

- emp 테이블에서 10번 부서deptno 혹은 30번 부서에 속하는 사람 중
급여sal가 1500이 넘는 사람들만 조회하고 이름으로 내림차순 정렬되도록 쿼리를 작성하세요.

SELECT *
FROM emp
WHERE deptno IN (10, 30) 
  AND sal > 1500
ORDER BY ename DESC;





ROWNUM 1]
- emp 테이블에서 ROWNUM 값이 1~10인 값만 조회하는 쿼리를 작성해보세요.
(정렬없이 진행하세요, 결과는 화면과 다를 수 있습니다.)
-- 정렬없이 진행하려면 뭘 없애야 하는 거지

SELECT ROWNUM rn, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 1 AND 10;


ROWNUM 2]
가상컬럼 ROWNUM

- ROWNUM 값이 11~20(11~14)인 값만 조회하는 쿼리를 작성해보세요. -- emp 테이블은 행이 14개

SELECT *
FROM 
(SELECT ROWNUM rn, empno, ename
FROM emp)
WHERE rn BETWEEN 11 AND 14;


ROWNUM 3]
가상컬럼 ROWNUM

- emp 테이블의 사원 정보를 이름컬럼으로 오름차순 적용했을 때의
11~14번째 행을 다음과 같이 조회하는 쿼리를 작성해보세요.

SELECT *
FROM
(SELECT ROWNUM rn, empno, ename
FROM
(SELECT empno, ename
FROM emp
ORDER BY ename))
WHERE rn BETWEEN 11 AND 14;










