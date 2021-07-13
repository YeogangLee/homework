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
 WHERE THEATER_CD = ''
   AND SEAT_NO = ''
   AND SEAT_TYPE_CD = ''
   ; 
 