SELECT product.*, :cid, NVL(cycle.day,0) day, NVL(cycle.cnt,0) cnt, customer.cnm
FROM product, cycle, customer
WHERE product.pid = cycle.pid(+)
  AND cycle.cid(+) = :cid
  AND cycle.cid = customer.cid
  AND customer.cid = :cid;