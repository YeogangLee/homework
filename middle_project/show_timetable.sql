select a.mv_cd AS mv_cd, mv_name_kor, show_start_time
  from tb_show a, tb_movie b, tb_theater c
 where a.mv_cd = b.mv_cd
   and a.theater_cd = c.theater_cd
   and TO_CHAR(show_date, 'YYYY.MM.DD (DY)') = '2021.06.22 (화)'
   and a.theater_cd IN (select theater_cd
                          from tb_theater
                         where cinema_cd = 'CN001')
order by a.mv_cd, show_start_time;

select theater_cd
  from tb_theater
 where cinema_cd = 'CN001';
 
select to_char(sysdate, 'YYYY-MM-DD (DY)')
  from dual;
  
