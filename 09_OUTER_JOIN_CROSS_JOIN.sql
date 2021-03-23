실습 outerjoin 1]

SELECT *
FROM buyprod
WHERE buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD');

- buyprod 테이블에 구매일자가 2005년 1월 25일인 데이터는 3품목 밖에 없다.
모든 품목이 나올 수 있도록 쿼리를 작성해보세요.


-- ANSI
SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM buyprod RIGHT OUTER JOIN prod ON (buyprod.buy_prod = prod.prod_id AND buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD'));

-- ORACLE
SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM buyprod, prod 
WHERE buyprod.buy_prod(+) = prod.prod_id 
AND buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD');

-- 한 행으로 다 합하면 모든 행수를 구할 수 있다, 이것과 아우터 조인했을 때의 값이 같아야 한다.
SELECT COUNT(*)
FROM prod;



outerjoin2]
outerjoin1에서 작업 시작, buy_date 컬럼이 null인 항목이 안 나오도록
다음처럼 데이터를 채워지도록 쿼리 작성, outerjoin 1번을 참고

outerjoin2] + 3] null 값 0 처리
SELECT TO_DATE(:yyyymmdd, 'YYYY/MM/DD'), buy_prod, prod_id, prod_name, NVL(buy_qty, 0)
FROM buyprod, prod
WHERE buyprod.buy_prod(+) = prod.prod_id 
  AND buy_date(+) = TO_DATE(:yyyymmdd, 'YYYY/MM/DD');



outerjoin4] 
- cycle, product 테이블을 이용해 고객이 애음하는 제품 명칭을 표현하고,
애음하지 않는 제품도 다음과 같이 조회되도록 쿼리를 작서하세요
(고객은 cid=1인 고개만 나오도록 제한, null 처리)


-- 바인딩 변수 사용 -> SELECT 절과 ON 절의 cid가 같은 값이라는 의미 지시
SELECT product.*, :cid, cycle.day, cycle.cnt
FROM product LEFT JOIN cycle ON (product.pid = cycle.pid AND cid = :cid);

-- ANSI
SELECT product.*, :cid, NVL(cycle.day,0) day, NVL(cycle.cnt,0) cnt
FROM product LEFT JOIN cycle ON (product.pid = cycle.pid AND cid = :cid);

-- ORACLE
SELECT product.*, :cid, NVL(cycle.day,0) day, NVL(cycle.cnt,0) cnt
FROM product, cycle
WHERE product.pid = cycle.pid(+)
  AND cid(+) = :cid;



-- 과제@
outerjoin5] 
outerjoin4를 바탕으로 고객 이름 컬럼 추가하기
-> customer 테이블에 있는 고객 이름을 어떻게 들고올 것인가



데이터 결합 cross join 실습 1]
- customer, product 테이블을 이용하여 고객이 애음 가능한 모든 제품의 정보를 결합하여
다음과 같이 조회되도록 쿼리 작성

SELECT *
FROM customer, product;