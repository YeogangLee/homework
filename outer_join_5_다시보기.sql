SELECT cu.cid, cnm, cy.pid, pnm, day, cnt
FROM customer cu, cycle cy, product p
WHERE cu.cid = cy.cid
  AND cy.pid = p.pid
  AND cnm IN ('brown', 'sally')
  ORDER BY cu.cid, p.pid;
  
SELECT cu.cid, cnm, cy.pid, pnm, day, cnt
FROM customer cu JOIN cycle cy ON (cu.cid = cy.cid) 
                 JOIN product p ON (cy.pid = p.pid)
                 AND cnm IN ('brown', 'sally')
ORDER BY cu.cid, p.pid;
                 
SELECT customer.cid, customer.cnm, cycle.pid, product.pnm, cycle.day, cycle.cnt -- 4번에서 여기에 pnm을 추가
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
  AND cycle.pid = product.pid
  AND customer.cnm IN ('brown', 'sally')
  ORDER BY customer.cid, product.pid;        

-- 제출
SELECT product.*, :cid, NVL(cycle.day,0) day, NVL(cycle.cnt,0) cnt, customer.cnm
FROM product, cycle, customer
WHERE product.pid = cycle.pid(+)
  AND cycle.cid(+) = :cid
  AND cycle.cid = customer.cid
  AND customer.cid = :cid;
  
--답
SELECT product.pid, pnm, :cid, cnm, NVL(day, 0) AS day, NVL(cnt, 0) AS cnt
FROM product LEFT OUTER JOIN cycle ON (product.pid = cycle.pid AND cycle.cid = :cid)
    LEFT OUTER JOIN customer ON (:cid = customer.cid);
    
SELECT product.pid, pnm, :cid, cnm, NVL(day, 0) AS day, NVL(cnt, 0) AS cnt
FROM product LEFT OUTER JOIN cycle ON (product.pid = cycle.pid AND cycle.cid = :cid)
    JOIN customer ON (:cid = customer.cid);

--cnm > null
SELECT product.pid, pnm, :cid, cnm, NVL(day, 0) AS day, NVL(cnt, 0) AS cnt
FROM product LEFT OUTER JOIN cycle ON (product.pid = cycle.pid AND cycle.cid = :cid)
    LEFT OUTER JOIN customer ON (cycle.cid = customer.cid);

--행 제한
SELECT product.pid, pnm, :cid, cnm, NVL(day, 0) AS day, NVL(cnt, 0) AS cnt
FROM product LEFT OUTER JOIN cycle ON (product.pid = cycle.pid AND cycle.cid = :cid)
    JOIN customer ON (cycle.cid = customer.cid);