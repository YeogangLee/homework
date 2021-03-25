데이터 결합 실습 join2]
- erd 다이어그램을 참고하여 buyer, prod 테이블을 조인하여
buyer별 담당하는 제품 정보를 다음과 같은 결과가 나오도록 쿼리를 작성해보세요.
-- buyer별 @

SELECT b.buyer_id, b.buyer_name, p.prod_id, p.prod_name
FROM buyer b, prod p
GROUP BY b.buyer_id
HAVING b.buyer_id;

-- buyer 별로 그룹 X, alias 전부 없어도 실행 가능
SELECT b.buyer_id, b.buyer_name, p.prod_id, p.prod_name
FROM buyer b, prod p
WHERE b.buyer_id = p.prod_buyer;

-- 인출된 최종의 개수를 보고 싶다면 질의 결과에서 데이터 아무거나 하나 누르고 ctrl End
-- 만약 50개라면 그건 페이징 단위가 50개일 확률이 높다, 실제로 50개일 수 있기도 하고.

-- 웹 프로그래밍 자주하는 예제
-- 게시판, 쇼핑몰


데이터 결합 실습 join3]
- erd 다이어그램을 참고하여 member, cart, prod 테이블을 조인하여
회원별 장바구니에 담은 제품 정보를 다음과 같은 결과가 나오는 쿼리를 작성해보세요.
(핵심** 테이블 3개 조인, 초심자에게는 oracle 표기가 더 편할 것)

SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member, cart, prod
WHERE mem_id = cart_member
  AND cart_prod = prod_id;
  
  
SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member JOIN cart, prod ON (mem_id = cart_member AND cart_prod = prod_id);


join3]
1. FROM 에 테이블 나열
2. 테이블을 연결할 연결고리 컬럼 찾기

-- 없는 컬럼이라 오류, 없는 테이블이라던가 - ERD 다이어그램에서 확인
SELECT *
FROM member, cart
WHERE member.member_id = cart.cart_member;

-- 컬럼명 수정 후 쿼리 작성
-- ORACLE 
SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member, cart, prod
WHERE member.mem_id = cart.cart_member
  AND cart.cart_prod = prod.prod_id;

ANSI 작성법
FROM member JOIN cart ON (....) JOIN 다른 테이블 ON
또는 엔터키로 구분 지어서
FROM member JOIN cart ON (....) 
    JOIN 다른 테이블 ON

-- ANSI
-- 처음부터 테이블 3개를 쓰는 게 아니라,
-- 2개 먼저 써보고 데이터 출력 되면 하나 추가하는 방식으로
SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member JOIN cart ON (member.mem_id = cart.cart_member)
            JOIN prod ON (cart.cart_prod = prod.prod_id); --**




데이터 결합 join4]

-- ORACLE
SELECT cu.cid, cnm, pid, day, cnt
FROM customer cu, cycle cy
WHERE cu.cid = cy.cid
  AND cnm IN ('brown', 'sally');
  
-- ANSI
SELECT cu.cid, cnm, pid, day, cnt
FROM customer cu JOIN cycle cy ON (cu.cid = cy.cid AND cnm IN ('brown', 'sally')); 
  
  
join4]
SELECT *
FROM customer, cycle
WHERE customer.cid = cycle.cid;

SELECT customer.cid, customer.cnm, cycle.pid, cycle.day, cycle.cnt
FROM customer, cycle
WHERE customer.cid = cycle.cid
  AND cnm IN ('brown', 'sally');
  

데이터 결합 join5]
-- ORACLE
SELECT cu.cid, cnm, cy.pid, pnm, day, cnt
FROM customer cu, cycle cy, product p
WHERE cu.cid = cy.cid
  AND cy.pid = p.pid
  AND cnm IN ('brown', 'sally');
  
-- ANSI
SELECT cu.cid, cnm, cy.pid, pnm, day, cnt
FROM customer cu JOIN cycle cy ON (cu.cid = cy.cid) 
                 JOIN product p ON (cy.pid = p.pid)
                 AND cnm IN ('brown', 'sally');  

join5]
SELECT customer.cid, customer.cnm, cycle.pid, product.pnm, cycle.day, cycle.cnt -- 4번에서 여기에 pnm을 추가
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
  AND cycle.pid = product.pid
  AND customer.cnm IN ('brown', 'sally');

-- JOIN이 헷갈리면 엑셀 파일에 색칠하면서 그려봐라.


데이터 결합 join6]


-- ORACLE
SELECT customer.cid, customer.cnm, cycle.pid, product.pnm, SUM(cycle.cnt) cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
  AND cycle.pid = product.pid
  AND customer.cnm IN ('brown', 'sally')
GROUP BY customer.cid, customer.cnm, cycle.pid, product.pnm;
-- GROUP BY 전의 쿼리 결과를 보면 컬럼 4개의 값이 같다, 저걸로 GROUP BY 해줘라

-- // 이걸로 기본형태 잡고, 여기서 필요 없는 정보 날리기

-- @에러, 수정했는데 다시 보기
SELECT customer.cid, customer.cnm, cycle.pid, product.pnm, SUM(cycle.cnt) cnt
FROM cycle, product
WHERE cycle.pid = product.pid
GROUP BY customer.cid, customer.cnm, cycle.pid, product.pnm;



-- ANSI 
SELECT cu.cid, cnm, cy.pid, pnm, cnt
FROM customer cu JOIN cycle cy ON (cu.cid = cy.cid) 
                 JOIN product p ON (cy.pid = p.pid);
-- 테이블 3개 JOIN 
-- 뒤에 ON(조건) 키워드 없을시 오류 발생
-- 오라클 표기에서 WHERE이 없다고 해서, ANSI 표기에서 ON을 없애면 안 된다. 


데이터 결합 join7]
-- ORACLE
SELECT cy.pid, pnm, cnt
FROM cycle cy, product p
WHERE cy.pid = p.pid;

-- ANSI
SELECT cy.pid, pnm, cnt
FROM cycle cy JOIN product p ON (cy.pid = p.pid);




실습 outerjoin 1]

SELECT *
FROM buyprod
WHERE buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD');

- buyprod 테이블에 구매일자가 2005년 1월 25일인 데이터는 3품목 밖에 없다.
모든 품목이 나올 수 있도록 쿼리를 작성해보세요.


outerjoin 1]

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


