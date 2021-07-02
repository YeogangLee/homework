insert into tb_product_type values('P01', '팝콘');
COMMIT;

INSERT INTO tb_product (
    prod_cd,
    prod_name,
    prod_price,
    prod_desc
--    atch_file_cd
) VALUES (
    'P01',
    '고소팝콘(M)',
    4500,
    '옥수수 본연의 맛을 즐길 수 있는 짭짜름한 클래식 고소팝콘!'
--    :v5
);

commit;
