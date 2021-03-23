grp3]
SELECT
    CASE
    WHEN deptno = 10 THEN 'ACCOUNTING'
    WHEN deptno = 20 THEN 'RESEARCH'
    WHEN deptno = 30 THEN 'SALES'
    WHEN deptno = 40 THEN 'OPERATIONS'
    ELSE 'DDIT'
  END dname, sal
FROM emp;
--GROUP BY deptno;

deptno, MAX(sal), MIN(sal), ROUND(AVG(sal), 2), SUM(sal), COUNT(sal), COUNT(mgr), COUNT(*)
FROM emp


grp4]
- emp 테이블을 이용하여 다음을 구하시오
직원의 입사 년월별로 몇명의 직원이 입사했는지 조회하는 쿼리를 작성

SELECT TO_CHAR(hiredate, 'yyyymm') hire_yyyymm, COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'yyyymm')
ORDER BY TO_CHAR(hiredate, 'yyyymm');


grp5]
SELECT TO_CHAR(hiredate, 'yyyy') hire_yyyy, COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'yyyy')
ORDER BY TO_CHAR(hiredate, 'yyyy');


grp6]
SELECT COUNT(*)
FROM dept;

grp7]
- 직원이 속한 부서의 개수를 조회하는 쿼리, emp 테이블 사용

SELECT COUNT(*)
FROM
(SELECT deptno
FROM emp
GROUP BY deptno);
-- 인라인 뷰를 사용하면 안에 있는 데이터들은 궁금해하지 않는다.




데이터 결합 실습 join0]
- emp, dept 테이블을 이용하여 다음과 같이 조회되도록 쿼리를 작성하세요
SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e JOIN dept d ON (e.deptno = d.deptno)
ORDER BY deptno;

                     -- deptno 가 정확히 어디 테이블에 소속됐는지 모호해서 에러
SELECT empno, ename, emp.deptno, dname -- emp. 한정자를 적어주면 에러 X
FROM emp, dept
WHERE emp.deptno = dept.deptno;


데이터 결합 실습 join0_1]
- emp, dept 테이블을 이용하여 다음과 같이 조회되도록 쿼리를 작성
부서번호가 10, 30인 데이터만 조회

SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.deptno IN (10, 30)
AND dept.deptno IN (10,30); -- 조건 하나만 작성해도 문제 없다


데이터 결합 실습 join0_2]
- emp, dept 테이블을 이용하여 다음과 같이 조회되도록 쿼리 작성
급여가 2500 초과

SELECT empno, ename, sal, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.sal > 2500;


데이터 결합 실습 join0_3]
- emp, dept 테이블을 이용하여 다음과 같이 조회되도록 쿼리 작성
급여 2500 초과, 사번이 7600보다 큰 직원

SELECT empno, ename, sal, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND sal > 2500 
AND empno > 7600
ORDER BY empno;


데이터 결합 실습 join0_4]
- emp, dept 테이블을 이용하여 다음과 같이 조회되도록 쿼리 작성
급여 2500 초과, 사번이 7600보다 크고, RESEARCH 부서에 속하는 직원

SELECT empno, ename, sal, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND sal > 2500 
AND empno > 7600
AND dname = 'RESEARCH'
-- AND emp.deptno = 20; -- 같은 결과
