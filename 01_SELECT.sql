================================================================

SELECT 실습 select1
- lprod 테이블에서 모든 데이터를 조회하는 쿼리를 작성하세요

- buyer 테이블에서 buyer_id, buyer_name 컬럼만 조회하는 쿼리를 작성하세요

- cart 테이블에서 모든 데이터를 조회하는 쿼리 작성하세요

- member 테이블에서 mem_id, mem_pass, mem_name 컬럼만 조회하는 쿼리 작성하세요

------------------------------------------------------------------

SELECT *
FROM lprod;

SELECT buyer_id, buyer_name
FROM buyer;

SELECT *
FROM cart;

SELECT mem_id, mem_pass, mem_name
FROM member;

=================================================================
=================================================================

column alias 실습 SELECT2
- prod 테이블에서 prod_id, prod_name 두 컬럼을 조회하는 쿼리를 작성하시오.
(단 prod_id -> id, prod_name -> name으로 컬럼 별칭을 지정)

- lprod 테이블에서 lprod_gu, lprod_nm 두 컬럼을 조회하는 쿼리를 작성하시오.
(단 lprod_gu -> gu, lprod_nm -> nm으로 컬럼 별칭을 지정)

- buyer 테이블에서 buyer_id, buyer_name 두 컬럼을 조회하는 쿼리를 작성하시오.
(단 buyer_id -> 바이어아이디, buyer_name -> 이름으로 컬럼 별칭을 지정)

-------------------------------------------------------------------------

SELECT prod_id "id", prod_name "name"
FROM prod;

SELECT lprod_gu AS "gu", lprod_nm AS "nm"
FROM lprod;

SELECT buyer_id 바이어아이디, buyer_name 이름
FROM buyer;


==================================================================