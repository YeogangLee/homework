sub6]
cycle 테이블을 이용하여 cid=1인 고객이 애음하는 제품 중 
cid=2인 고객도 애음하는 제품의 애음정보를 조회하는 쿼리를 작성하세요

SELECT *
FROM cycle;

SELECT pid
FROM cycle
WHERE cid = 1;
-- 100, 400


SELECT pid
FROM cycle
WHERE cid = 2;
-- 100, 200


-- 2번 고객이 먹는 제품에 대해서만 1번 고객이 먹는 애음 정보조회
sub6]
SELECT *
FROM cycle
WHERE cid = 1
  AND pid IN (SELECT pid
                FROM cycle
                WHERE cid = 2);



sub7]
customer, cycle, product 테이블을 이용하여
cid = 1인 고객이 애음하는 제품 중
cid = 2인 고객도 애음하는 제품의 애음정보를 조회하고
고객명과 제품명까지 포함하는 쿼리 작성

+ pnm, cnm
SELECT *
FROM cycle, customer, product
WHERE cycle.cid = 1 -- 위에 3행만 실행 -> 조건 없는 크로스 조인 5 * 3 * 4 = 60
  AND cycle.cid = customer.cid -- 5 * 4 
  AND cycle.pid = product.pid
--AND product.pid IN (SELECT pid
  AND cycle.pid IN (SELECT pid
                FROM cycle
                WHERE cid = 2);

연습? => 스프레드 시트에 직접 그려보기, 행 색칠



EXISTS 키워드
-- 매니저가 존재하는 직원
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

SELECT *
FROM emp e
WHERE EXISTS (SELECT empno
              FROM  emp m
              WHERE e.mgr = m.empno);
              -- WHERE 7902 = m.empno); 조회 가능 -> 참, 값에 상관없이 참, 거짓 판단