연습 1]
1-1. SMITH 가 속한 부서에 있는 직원들을 조회하기
=> 20번 부서에 속하는 직원들 조회하기 

1. 부서번호 = 20
SELECT deptno
FROM emp
WHERE ename = 'SMITH';

2. 같은 부서 직원 조회
SELECT *
FROM emp
WHERE deptno = 20;


서브쿼리
: 쿼리의 결과를 다른 쿼리에 들고와서 사용
=>
SELECT *
FROM emp
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE ename = 'SMITH');


+조건 추가
1-2. SMITH 나 ALLEN이 속한 부서에 있는 직원들을 조회

SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                FROM emp
                WHERE ename = 'SMITH' OR ename = 'ALLEN');



서브쿼리 실습 sub1]
-- 평균 급여보다 높은 급여를 받는 직원의 수를 조회하세요.

SELECT AVG(sal)
FROM emp;

SELECT *
FROM emp
WHERE sal >= 2073;
    
SELECT COUNT(*)
FROM emp
WHERE sal >= 2073;

SELECT COUNT(*)
FROM emp
WHERE sal >= (SELECT AVG(sal)
              FROM emp);

              
    
서브쿼리 실습 sub2]
-- 평균 급여보다 높은 급여를 받는 직원의 정보를 조회

-- sub2]
SELECT *
FROM emp
WHERE sal >= (SELECT AVG(sal)
                FROM emp);



요구사항] : ALLEN 또는 CLARK 의 소속 부서번호와 같으면서 상사도 같은 직원들을 조회

-- 서브쿼리
SELECT mgr, deptno
FROM emp
WHERE ename IN ('ALLEN', 'CLARK');
=>
mgr	deptno
7698	30
7839	10

-- ORACLE
SELECT mgr, deptno
FROM emp
WHERE (mgr, deptno) IN (SELECT mgr, deptno
                        FROM emp
                        WHERE ename IN ('ALLEN', 'CLARK'));



서브쿼리 실습 sub3]
- SMITH 와 WARD 사원이 속한 부서의 모든 사원 정보를 조회하는 쿼리를 다음과 같이 작성하세요

SELECT *
FROM emp m
WHERE m.deptno IN (SELECT s.deptno
                  FROM emp s
                  WHERE s.ename IN ('SMITH', 'WARD'));

-- 별칭 안 써도 실행 가능
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                  FROM emp
                  WHERE ename IN ('SMITH', 'WARD'));


-- 서브쿼리에 null 값이 조회가 되는 행이 있는 경우 조회 불가
-- ==> null 값 처리 함수로 서브쿼리 작성

-- 2번째 시험 문제 연습2]
-- 직원들 중 매니저가 아닌 직원들의 조회 쿼리
SELECT *
FROM emp
WHERE empno NOT IN (SELECT NVL(mgr, 9999)
                    FROM   emp);    

-- 직원들 중 매니저인 직원들의 조회 쿼리
SELECT *
FROM emp
WHERE empno IN (SELECT NVL(mgr, 9999)
                FROM   emp);    



-- 아까의 sub2]와 비슷한 실습 문제
아래 쿼리는 전체 직원의 급여 평균보다 높은 급여를 받는 직원을 조회하는 쿼리

SELECT *
FROM emp
WHERE sal >= (SELECT AVG(sal)
                FROM emp);

연습3]
-- 상호 연관, 비상호 연관 개념을 알기 위한 좋은 예제]
이제는, 직원이 속한 부서의 급여 평균보다 높은 급여를 받는 직원을 조회

비교 대상은 동일하다

SELECT empno, ename, sal, deptno
FROM emp;

일단 20번 부서의 급여 평균을 구해야 한다
-- 이게 올바른 방식
SELECT AVG(sal)
FROM emp
WHERE deptno = 20;

-- 이렇게 꼬는(불필요한 데이터까지 조회하는) 방식을 사용하지 마세요
SELECT deptno, AVG(sal)
FROM emp
GROUP BY deptno;

20번 부서의 급여 평균 (2175)
SELECT AVG(sal)
FROM emp
WHERE deptno = 20;

SELECT empno, ename, sal, deptno
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp
             WHERE deptno = 20 ); -- 메인, 서브 같은 emp 테이블을 조회 -> 한정자 emp.deptno 소용X -> 별칭 사용

-- 별칭 사용
SELECT empno, ename, sal, deptno
FROM emp e
WHERE e.sal > (SELECT AVG(sal)
             FROM emp a
             WHERE a.deptno = e.deptno );

-- 서브쿼리의 컬럼을 메인쿼리에 가져가서 사용할 수 없다
SELECT e.empno, e.ename, e.sal, e.deptno, a.avg_sal -- a는 FROM 절에 사용된 테이블이 아니므로 오류
FROM emp e
WHERE e.sal > (SELECT AVG(sal) avg_sal
             FROM emp a
             WHERE a.deptno = e.deptno );
  
-- 데이터 확인 해보기, 정말 30번 부서는 1600보다 평균 급여가 낮은지                
SELECT AVG(sal)
FROM emp
WHERE deptno = 30;



서브쿼리 실습 sub4]
- dept 테이블에는 신규 등록된 99번 부서에 속한 사람은 없음
직원이 속하지 않은 부서를 조회하는 쿼리를 작성해 보세요.

-- 여기서 시작
SELECT *
FROM dept
WHERE ???;

직원이 속하지 않은 부서 ==> 우리가 알 수 있는 건 직원이 속한 부서

-- 직원이 속한 부서
SELECT deptno
FROM emp;

sub4]
SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                     FROM emp);



서브쿼리 실습 5]
- cycle, product 테이블을 이용하여 
cid = 1인 고객이 애음하지 않는 제품을 조회하는 쿼리를 작성하세요.


sub5]
-- 여기서 시작
SELECT *
FROM product;

-- 고객이 안 먹는 제품을 가지고 있지는 않지만 알 수는 있다
-- => 전체 제품 목록 - 고객이 먹는 제품
-- 고객이 먹는 제품 구하기 : pid 구하기
SELECT *
FROM cycle
WHERE cid = 1;

-- 하드 코딩
SELECT *
FROM product
WHERE pid NOT IN (100, 100, 400, 400);

-- 서브쿼리 이용
-- sub5]
SELECT *
FROM product
WHERE pid NOT IN (SELECT pid
                    FROM cycle
                   WHERE cid = 1);
