with my_query as
(
  select '1' Badge_name , 'First badge' AREA from dual
   union
  select '2' Badge_name , 'Second badge' AREA from dual
   union
  select '3' Badge_name , 'Third badge' AREA from dual
   union
  select '4' Badge_name , 'Fourth badge' AREA from dual
   union
  select '5' Badge_name , 'Fifth badge' AREA from dual
   union
  select '6' Badge_name , 'Sixth badge' AREA from dual
)
select myq.Badge_name,
       myq.AREA,
	   nvl(bs.SORT_ORDER,rownum) SORT_ORDER
	from 
my_query myq,
badge_saved_details_tt bs 
where 
myq.Badge_name = bs.BADGE_ID(+) and
bs.USER_ID(+) = V('APP_USER') and
bs.APP_ID(+) = V('APP_ID') and
bs.PAGE_ID(+) = V('APP_PAGE_ID')
order by nvl(bs.SORT_ORDER,999999999999)