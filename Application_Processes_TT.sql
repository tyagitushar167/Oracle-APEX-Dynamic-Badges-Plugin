/*badge_delete*/
begin
REMOVE_BADGE_DETAILS_TT(apex_Application.g_x01);
apex_json.open_object;        -- {
    apex_json.write('Object Deleted', 'Yes');    --   "a":1
    apex_json.close_all;          --  ]
end;
-----------------------------------------------------------
/*badge_insert*/
begin
UPDATE_BADGE_DETAILS_TT(apex_Application.g_x01);
apex_json.open_object;        -- {
    apex_json.write('Object inserted', 'Yes');    --   "a":1
    apex_json.close_all;          --  ]
end;
-----------------------------------------------------------
/*move_row_down*/
declare
v_max number;
v_sort_orig number;
v_sort_number number;
begin

select SORT_ORDER into v_sort_orig from badge_saved_details_tt where 
	   user_id = V('APP_USER') and app_id = V('APP_ID') and page_id = V('APP_PAGE_ID') and BADGE_ID =  apex_Application.g_x01;

v_sort_number := to_number(v_sort_orig) + 1;

begin
  select max(SORT_ORDER) into v_max from badge_saved_details_tt where USER_ID = V('APP_USER') and app_id = V('APP_ID') and page_id = V('APP_PAGE_ID');
 exception when others then null;
end;

update badge_saved_details_tt
   set SORT_ORDER = v_sort_orig
  where USER_ID = V('APP_USER') and app_id = V('APP_ID') and page_id = V('APP_PAGE_ID')
    and SORT_ORDER = v_sort_number;


update badge_saved_details_tt
  set SORT_ORDER = case when SORT_ORDER = v_max then v_max else SORT_ORDER + 1 end 
  where USER_ID = V('APP_USER') and app_id = V('APP_ID') and page_id = V('APP_PAGE_ID') and badge_id = apex_Application.g_x01;
 
    apex_json.open_object;        -- {
    apex_json.write('Moved down', 'Yes');    --   "a":1
    apex_json.close_all;          --  ]
  
  
end;
--------------------------------------------------------------------
/*move_row_up*/
declare
v_min number;
v_sort_orig number;
v_sort_number number;
begin

select SORT_ORDER into v_sort_orig from badge_saved_details_tt where 
	   user_id = V('APP_USER') and app_id = V('APP_ID') and page_id = V('APP_PAGE_ID') and BADGE_ID =  apex_Application.g_x01;

v_sort_number := to_number(v_sort_orig) - 1;

begin
  select min(SORT_ORDER) into v_min from badge_saved_details_tt where USER_ID = V('APP_USER') and app_id = V('APP_ID') and page_id = V('APP_PAGE_ID');
end;

update badge_saved_details_tt
   set SORT_ORDER = v_sort_orig
  where USER_ID = V('APP_USER') and app_id = V('APP_ID') and page_id = V('APP_PAGE_ID')
    and SORT_ORDER = v_sort_number;

update badge_saved_details_tt
  set SORT_ORDER = case when SORT_ORDER = v_min then v_min else SORT_ORDER - 1 end 
  where USER_ID = V('APP_USER') and app_id = V('APP_ID') and page_id = V('APP_PAGE_ID') and badge_id = apex_Application.g_x01;
 
    apex_json.open_object;        -- {
    apex_json.write('Moved Up', 'Yes');    --   "a":1
    apex_json.close_all;          --  ]
  
  
end;