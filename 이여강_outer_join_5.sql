-- 틀린 코드
SELECT product.*, :cid, NVL(cycle.day,0) day, NVL(cycle.cnt,0) cnt, cnm
FROM product, cycle, customer
WHERE product.pid = cycle.pid(+)
  AND cid(+) = :cid
  AND customer.cid(+) = product.cid;