CREATE TABLE  "BADGE_SAVED_DETAILS_TT" 
   (	"USER_ID" VARCHAR2(255 CHAR), 
	"APP_ID" VARCHAR2(255 CHAR), 
	"PAGE_ID" VARCHAR2(255 CHAR), 
	"BADGE_ID" VARCHAR2(255 CHAR), 
	"SORT_ORDER" NUMBER, 
	"ISDELETED" NUMBER DEFAULT 0
   );
 /  
   
CREATE OR REPLACE PROCEDURE REMOVE_BADGE_DETAILS_TT (
    badge_id_in IN VARCHAR
)
    IS
BEGIN
    UPDATE badge_saved_details_tt
    SET
        isdeleted = 1
    WHERE
        user_id = v('APP_USER')
        AND app_id = v('APP_ID')
        AND page_id = v('APP_PAGE_ID')
        AND badge_id = badge_id_in;

END;
 /

CREATE OR REPLACE PROCEDURE UPDATE_BADGE_DETAILS_TT (
    badge_id_in IN VARCHAR
)
    IS
BEGIN
    UPDATE badge_saved_details_tt
    SET
        isdeleted = 0
    WHERE
        user_id = v('APP_USER')
        AND app_id = v('APP_ID')
        AND page_id = v('APP_PAGE_ID')
        AND badge_id = badge_id_in;

END;
 /