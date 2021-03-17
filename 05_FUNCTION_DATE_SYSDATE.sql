FUNCTION DATE 실습 fn1]
1. 2019년 12월 31일을 date형으로 표현
2. 2019년 12월 31일을 date형으로 표현하고 5일 이전 날짜
3. 현재 날짜
4. 현재 날짜에서 3일 전 값

위 4개 컬럼을 생성하여 다음과 같이 조회하는 쿼리를 작성하세요.
(PT 예시는 현재 날짜가 2019/10/24)

SELECT TO_DATE('19/12/31', 'YYYY/MM/DD') LASTDAY,
       TO_DATE('19/12/31', 'YYYY/MM/DD') - 5 LASTDAY_BEFORE5,
       SYSDATE NOW,
       SYSDATE - 3 NOW_BEFORE3
FROM dual;




Function date 실습 fn2]

오늘 날짜를 다음과 같은 포맷으로 조회하는 쿼리를 작성하시오.
1. 년-월-일
2. 년-월-일 시간(24)-분-초
3. 일-월-년

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') DT_DASH,
       TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') DT_DASH_WITH_TIME,
       TO_CHAR(SYSDATE, 'DD-MM-YYYY') DT_DD_MM_YYYY
FROM dual;




'2021-03-17' ==> '2021-03-17 12:41:00'

SELECT TO_DATE('2021-03-17', 'YYYY-MM-DD')
FROM dual;

SELECT TO_CHAR(TO_DATE('2021-03-17', 'YYYY-MM-DD'), 'YYYY-MM-DD HH24:MI:SS')
FROM dual;
-- 중복해서 사용, 일종의 저번의 CONCAT 개념

SELECT SYSDATE
FROM dual; -- 현재 날짜 + 시각 같이 출력

SELECT SYSDATE, TO_DATE(TO_CHAR(SYSDATE-5, 'YYYYMMDD'), 'YYYYMMDD')
FROM dual; -- 시분초 시간 0처리


