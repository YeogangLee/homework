--실습 OUTER JOIN5 : 고객 이름 컬럼 추가 (4개 비교)
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