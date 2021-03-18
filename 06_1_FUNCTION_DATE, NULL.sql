FIRST DAY 구하기]
-- SYSDATE를 이용하여 SYSDATE가 속한 월의 첫 번째 날짜 구하기
       

=> SYSDATE로 년, 월까지 문자로 구하기 || '01'
     '202103' || '01' ==> '20210301'

SELECT TO_DATE('20210301', 'YYYYMMDD'),
          TO_DATE(TO_CHAR(SYSDATE, 'YYYYMM') || '01', 'YYYYMMDD') FIRST_DAY
FROM emp;
       


Function date 종합 실습 fn3]
- 파라미터로 yyyymm 형식의 문자열을 사용해서 (ex. yyyymm = 201912)
해당 년월에 해당하는 일자 수를 구해보세요

yyyymm = 201912 -> 31
yyyymm = 201911 -> 30
yyyymm = 201602 -> 29 (2016년은 윤년)

SELECT :yyyymm --여기서부터 시작
FROM dual;

-
SELECT :yyyymm, 
마지막 날짜 -> LAST_DAY(날짜)
SELECT :YYYYMM, LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM'))
FROM dual;
날짜에서 원하는 부분만 빼내기
SELECT :YYYYMM,
       TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')), 'DD') DT
FROM dual;
-- 입력값에 따라 바뀌는 유연한 모델 완성




FUNCTION null 실습 fn4]
- emp 테이블의 정보를 다음과 같이 조회되도록 쿼리를 작성하세요
(nvl,nvl2,coalesce) 표그림 - 널값에 9999 채워넣기

SELECT empno, ename, mgr, NVL(mgr, 9999) ngr_n, NVL2(mgr, mgr, 9999) mgr_n_1, COALESCE(mgr, 9999) mgr_n_2
FROM emp

SELECT empno, ename, mgr, NVL(mgr, 9999) ngr_n, NVL2(mgr, mgr, 9999) mgr_n_1, COALESCE(mgr, null, 9999) mgr_n_2
FROM emp -- COALESCE 함수가 두 번째 인자 null을 인식 후 세 번째 인자 9999를 값으로 반환했다, 따라서 위 아래 쿼리문 결과는 같다




FUNCTION null 실습 fn5]
- users 테이블의 정보를 다음과 같이 조회되도록 쿼리를 작성하세요
  reg_dt가 null일 경우 sysdate를 적용

SELECT userid, usernm, reg_dt, NVL(reg_dt, SYSDATE) n_reg_dt
FROM users
WHERE userid in ('cony','sally','james','moon'); -- 행이 4행으로 제한되어 있으므로 WHERE 절을 써줘야겠죠

