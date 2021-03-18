조건분기 실습

직원들의 급여를 인상하려고 한다
job이 SALESMAN 이면 현재 급여에서 5%를 인상
job이 MANAGER 이면 현재 급여에서 10%를 인상
job이 PRESIDENT 이면 현재 급여에서 20%를 인상

그 이외의 직군은 현재 급여를 유지

SELECT ename, job, sal, 인상된 급여
FROM emp;

SELECT ename, job, sal, 
-- 인상된 급여
-- CASE END 컬럼 한 개의 표현
    CASE
        WHEN job = 'SALESMAN' THEN sal * 1.05
        WHEN job = 'MANAGER' THEN sal * 1.10
        WHEN job = 'PRESIDENT' THEN sal * 1.20
        ELSE sal -- sal * 1.0
    END raised_sal_CASE,
    DECODE(job, 
            'SALESMAN',sal * 1.05,
            'MANAGER', sal * 1.10,
            'PRESIDENT', sal * 1.20,
            sal * 1.0) raised_sal_DECODE
            -- defalt 값으로 쓰인 sal * 1.0을 작성하지 않으면
            -- null 값이 나온다.
FROM emp;


cond1]
- emp 테이블을 이용하여 deptno에 따라 부서명으로 변경해서
다음과 같이 조회되는 쿼리를 작성하세요


SELECT empno, ename, deptno, 
       CASE
        WHEN deptno = 10 THEN 'ACCOUNTING'
        WHEN deptno = 20 THEN 'RESEARCH'
        WHEN deptno = 30 THEN 'SALES'
        WHEN deptno = 40 THEN 'OPERATIONS'
        ELSE 'DDIT'
       END dname,
       DECODE(deptno, 
                10, 'ACCOUNTING', 
                20, 'RESEARCH', 
                30, 'SALES', 
                40, 'OPERATIONS', 
                'DDIT') dname_decode
FROM emp;





condition 실습 cond2]
- emp 테이블을 이용하여 hiredate에 따라 올해 건강보험 검진 대상자인지
조회하는 쿼리를 작성하세요. (생년을 기준으로 하나 여기서는 입사년도를 기준으로 한다)
검진 대상자 : 홀수년도 - 홀수해 출생자 / 짝수년도 - 짝수해 출생자


cond2]
SELECT MOD(, 2)
FROM dual;

SELECT empno, ename, hiredate, 
        CASE
            WHEN
                MOD(TO_CHAR(hiredate, 'yyyy'), 2) =
                MOD(TO_CHAR(SYSDATE, 'yyyy'), 2) THEN '건강검진 대상자'
            ELSE '건강검진 비대상자'
        END CONTACT_TO_DOCTOR,
        DECODE( MOD(TO_CHAR(hiredate, 'yyyy'), 2), 
                            MOD(TO_CHAR(SYSDATE, 'yyyy'), 2), '건강검진 대상자',
                                                                    '건강검진 비대상자') CONTACT_TO_DOCTOR_DECODE
                
FROM emp;


condition 실습 cond3]
- users 테이블을 이용하여 reg_dt에 따라 
올해 건강보험 검진 대상자인지 조회하는 쿼리를 작성하세요.
(생년을 기준으로 하나 여기서는 reg_dt를 기준으로 한다)


cond3]
SELECT userid, usernm, reg_dt, 
        CASE
            WHEN
                MOD(TO_CHAR(reg_dt, 'yyyy'), 2) =
                MOD(TO_CHAR(SYSDATE, 'yyyy'), 2) THEN '건강검진 대상자'
            ELSE '건강검진 비대상자'
        END CONTACT_TO_DOCTOR
FROM users
WHERE userid IN ('brown', 'cony', 'james', 'moon', 'sally');




Function group function 실습 grp1]
- emp 테이블을 이용하여 다음을 구하시오
    직원 중 가장 높은 급여
    직원 중 가장 낮은 급여
    직원의 급여 평균 (소수점 두 자리까지 나오도록 반올림)
    직원의 급여 합
    직원 중 급여가 있는 직원의 수 null 제외
    직원 중 상급자가 있는 직원의 수 null 제외
    전체 직원의 수


grp1]
SELECT  MAX(sal), MIN(sal), ROUND(AVG(sal), 2), SUM(sal), COUNT(sal), COUNT(mgr), COUNT(*)
FROM emp;


grp2]
SELECT  deptno, MAX(sal), MIN(sal), ROUND(AVG(sal), 2), SUM(sal), COUNT(sal), COUNT(mgr), COUNT(*)
FROM emp
GROUP BY deptno;
