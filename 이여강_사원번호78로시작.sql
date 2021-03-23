where 13]
- emp 테이블에서 job이 SALESMAN이거나 사원번호가 78로 시작하는
직원의 정보를 다음과 같이 조회하세요. (LIKE 연산자 사용 금지)


WHERE 13]

SELECT *
FROM emp
WHERE job = 'SALESMAN' OR empno BETWEEN 7800 AND 7899;


WHERE 13]

SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR empno BETWEEN 7800 AND 7899
OR empno BETWEEN 780 AND 789
OR empno = 78;