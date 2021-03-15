where 1]
- emp 테이블에서 입사 일자가 1982년 1월 1일 이후부터 1983년 1월 1일 이전인 사원의
ename, hiredate 데이터를 조회하는 쿼리를 작성하시오. (단, 연산자는 between을 사용한다)

SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('1982/01/01', 'YYYY/MM/DD') AND TO_DATE('1983/01/01', 'YYYY/MM/DD');


where 3]
- users 테이블에서 userid가 brown, cony, sally인 데이터를 다음과 같이 조회하시오. (IN 연산자 사용)

SELECT *
FROM users
WHERE userid IN ('brown', 'cony', 'sally');

SELECT userid 아이디, usernm 이름, alias 별명
FROM users
WHERE userid IN ('brown', 'cony', 'sally');
-- WHERE userid 'brown' OR userid 'cony' OR userid 'sally'


where 4]
- member 테이블에서 회원의 성이 [신]씨인 사람의 mem_id, mem_name을 조회하는 쿼리를 작성하시오.

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '신%';


where 5]
- member 테이블에서 회원의 이름에 [이]가 들어가는 모든 사람의
mem_id, mem_name을 조회하는 쿼리를 작성하시오.

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%이%';


where 6]
- emp 테이블에서 comm 컬럼의 값이 NULL인 사람만 조회

SELECT *
FROM emp
WHERE comm IS NULL; -- IS NULL <-> IS NOT NULL

- emp 테이블에서 매니저가 없는 직원만 조회

SELECT *
FROM emp
WHERE mgr IS NULL;


where 7]
- emp 테이블에서 job이 SALESMAN 이고 입사일자가 1981년 6월 1일 이후인
직원의 정보를 다음과 같이 조회하세요.

SELECT *
FROM emp
WHERE job LIKE 'SALESMAN' AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD'); -- 주의. LIKE는 정식 리터럴 표기가 아님
-- WHERE job = 'SALESMAN' AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');
-- 이후는 날짜 포함!!


where 8]
- emp 테이블에서 부서번호가 10번이 아니고
입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회하세요
(IN, NOT IN 연산자 사용 금지)

SELECT *
FROM emp
WHERE deptno != 10
AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');


where 9]
- emp 테이블에서 부서번호가 10번이 아니고
입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회하세요
(NOT IN 연산자 사용)

SELECT *
FROM emp
WHERE deptno NOT IN (10)
AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');


where 10] 
- emp 테이블에서 부서번호가 10번이 아니고 입사일자가 
입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회하세요
(부서는 10, 20, 30만 있다고 가정하고 IN 연산자를 사용)

SELECT *
FROM emp
WHERE deptno IN (20, 30) 
AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');


where 11]
- emp 테이블에서 job이 SALESMAN이거나 입사일자가 1981년 6월 1일 이후인
직원의 정보를 다음과 같이 조회하세요.

SELECT *
FROM emp
WHERE job = 'SALESMAN' OR hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');


where 12]
논리연산 (AND, OR 실습 WHERE12)
- emp 테이블에서 job이 SALESMAN이거나 사원번호가 78로 시작하는
직원의 정보를 다음과 같이 조회하세요.

SELECT *
FROM emp
WHERE job = 'SALESMAN' OR empno LIKE '78%';  
-- 암묵적 형변환, empno는 숫자인데 문자열 비교를 통한 연산


where 13]
- emp 테이블에서 job이 SALESMAN이거나 사원번호가 78로 시작하는
직원의 정보를 다음과 같이 조회하세요. (LIKE 연산자 사용 금지)

SELECT *
FROM emp
WHERE job = 'SALESMAN' OR empno BETWEEN 7800 AND 7899;
