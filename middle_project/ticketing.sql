INSERT INTO tb_ticket_detail (
    ticket_cd,
    seat_cd,
    audience_type_cd,
    ticket_price
) VALUES (
    'T000002',
    'ST000144',
    '03',
    5000
);
INSERT INTO tb_ticket_detail (
    ticket_cd,
    seat_cd,
    audience_type_cd,
    ticket_price
) VALUES (
    'T000002',
    'ST000145',
    '03',
    5000
);
INSERT INTO tb_ticket_detail (
    ticket_cd,
    seat_cd,
    audience_type_cd,
    ticket_price
) VALUES (
    'T000002',
    'ST000146',
    '03',
    5000
);
SELECT 'T01', 'A02', '03', '5000' FROM DUAL; 

SELECT SEAT_CD 
  FROM TB_SEAT
 WHERE THEATER_CD = 'TH0003'
   AND SEAT_NO = 'D01'
   AND SEAT_TYPE_CD = '02'
   
UNION

SELECT SEAT_CD 
  FROM TB_SEAT
 WHERE THEATER_CD = 'TH0003'
   AND SEAT_NO = 'D02'
   AND SEAT_TYPE_CD = '02'

UNION

SELECT SEAT_CD 
  FROM TB_SEAT
 WHERE THEATER_CD = 'TH0003'
   AND SEAT_NO = 'D03'
   AND SEAT_TYPE_CD = '02';
   
   
SELECT SEAT_CD FROM TB_SEAT   WHERE THEATER_CD = 'TH0003'    AND SEAT_NO = 'C13'    AND SEAT_TYPE_CD = '01'UNION  SELECT SEAT_CD FROM TB_SEAT   WHERE THEATER_CD = 'TH0003'    AND SEAT_NO = 'D13'    AND SEAT_TYPE_CD = '02'UNION  SELECT SEAT_CD FROM TB_SEAT   WHERE THEATER_CD = 'TH0003'    AND SEAT_NO = 'E13'    AND SEAT_TYPE_CD = '02';