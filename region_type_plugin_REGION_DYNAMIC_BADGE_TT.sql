prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_190200 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2019.10.04'
,p_release=>'19.2.0.00.18'
,p_default_workspace_id=>1047331805647092
,p_default_application_id=>1570
,p_default_id_offset=>0
,p_default_owner=>'WEBCRM'
);
end;
/
 
prompt APPLICATION 1570 - Test App tushar
--
-- Application Export:
--   Application:     1570
--   Name:            Test App tushar
--   Date and Time:   06:47 Wednesday April 15, 2020
--   Exported By:     TUSHAR
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 222103607274329877
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     63123356010078
--

begin
  -- replace components
  wwv_flow_api.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/region_type/REGION_DYNAMIC_BADGE_TT
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(222103607274329877)
,p_plugin_type=>'REGION TYPE'
,p_name=>'REGION_DYNAMIC_BADGE_TT'
,p_display_name=>'Dynamic Badges Plugin TT'
,p_supported_ui_types=>'DESKTOP'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'FUNCTION render_region(p_region              IN apex_plugin.t_region,',
'                         p_plugin              IN apex_plugin.t_plugin,',
'                         p_is_printer_friendly IN BOOLEAN)',
'  RETURN apex_plugin.t_region_render_result IS',
'  l_return_column1    p_region.attribute_01%TYPE := p_region.attribute_01;',
'  l_return_column2    p_region.attribute_02%TYPE := p_region.attribute_02;',
'  l_return_column3    p_region.attribute_03%TYPE := p_region.attribute_03;',
'  l_return_column6    p_region.attribute_06%TYPE := p_region.attribute_06;',
'  l_return_column7    p_region.attribute_07%TYPE := p_region.attribute_07;',
'  l_return_col_no1 pls_integer;',
'  l_return_col_no2 pls_integer;',
'  l_return_val1 varchar2(4000);',
'  l_return_val2 varchar2(4000);',
'  l_column_value_list      apex_plugin_util.t_column_value_list2;',
'  l_count number := 0;',
'  l_color_bg1 varchar2(25);',
'  l_count_existing_badge number;',
'  l_main_badge_class varchar2(255);',
'  l_checkbox_checked varchar2(255);',
'  ',
'  begin',
'  ',
'  APEX_CSS.ADD_FILE (',
'    p_name => ''badge_plugin_css'',',
'    p_directory => p_plugin.FILE_PREFIX );',
'	',
'  APEX_JAVASCRIPT.ADD_LIBRARY(',
'        P_NAME        => ''badge_plugin_js'',',
'        P_DIRECTORY   => P_PLUGIN.FILE_PREFIX',
'    );',
'	',
'  ',
'	if l_return_column7 = ''Y'' then',
'	',
'      APEX_JAVASCRIPT.ADD_ONLOAD_CODE (',
'        p_code   => ''setfirstactivetab()''',
'	  );',
'	 ',
'	end if;',
'  ',
'  if l_return_column1 is null or l_return_column2 is null then',
'	',
'	htp.p(''Please select all the values from Region attributes'');',
'	',
'	else',
'  ',
'  l_column_value_list := apex_plugin_util.get_data2(p_sql_statement  => p_region.source,',
'                                                    p_min_columns    => 1,',
'                                                    p_max_columns    => 5,',
'                                                    p_component_name => p_region.name,',
'													p_first_row      => 1);',
'                                                ',
'  l_return_col_no1 := apex_plugin_util.get_column_no(p_attribute_label   => ''Return Column1'',',
'                                                     p_column_alias      => l_return_column1,',
'                                                     p_column_value_list => l_column_value_list,',
'                                                     p_is_required       => False,',
'                                                     p_data_type         => apex_plugin_util.c_data_type_varchar2);',
'  l_return_col_no2 := apex_plugin_util.get_column_no(p_attribute_label   => ''Return Column2'',',
'                                                     p_column_alias      => l_return_column2,',
'                                                     p_column_value_list => l_column_value_list,',
'                                                     p_is_required       => False,',
'                                                     p_data_type         => apex_plugin_util.c_data_type_varchar2);',
'													 ',
'    select count(*) into l_count_existing_badge from BADGE_SAVED_DETAILS_TT',
'      where user_id = V(''APP_USER'') and app_id = V(''APP_ID'') and page_id = V(''APP_PAGE_ID''); ',
'	  if l_count_existing_badge = 0 then',
'	    for l_row_num in 1..l_column_value_list(1).value_list.count LOOP',
'		l_return_val1 := apex_plugin_util.get_value_as_varchar2(p_data_type => l_column_value_list(l_return_col_no1)',
'                                                                                .data_type,',
'                                                                 p_value     => l_column_value_list(l_return_col_no1)',
'                                                                                .value_list(l_row_num));',
'		  insert into BADGE_SAVED_DETAILS_TT',
'		    (user_id,app_id,page_id,badge_id,SORT_ORDER)',
'			  values',
'			(V(''APP_USER''),V(''APP_ID''),V(''APP_PAGE_ID''),l_return_val1,l_row_num);',
'		end loop;',
'	  end if;',
'													 ',
'  htp.p(''<body>'');',
'  htp.p(''<div style="width: 100%; overflow: hidden;">'');',
'  htp.p(''<div class="badge-edit-section"> <button class="t-Button t-Button--hot" onclick="javascript:myclasstoggle();" type="button"><span class="t-Icon t-Icon--left fa fa-tools" aria-hidden="true"></span><span class="t-Button-label">Click Here to Ed'
||'it Badges</span></button></div> '');',
'  htp.p(''<div class="badge_selection badge_selection_hid">'');',
'  htp.p(''<table class="admin_table">'');',
'    for l_row_num in 1..l_column_value_list(1).value_list.count LOOP',
'	     l_return_val1 := apex_plugin_util.get_value_as_varchar2(p_data_type => l_column_value_list(l_return_col_no1)',
'                                                                                .data_type,',
'                                                                 p_value     => l_column_value_list(l_return_col_no1)',
'                                                                                .value_list(l_row_num));',
'		 l_return_val2 := apex_plugin_util.get_value_as_varchar2(p_data_type => l_column_value_list(l_return_col_no2)',
'                                                                                .data_type,',
'                                                                 p_value     => l_column_value_list(l_return_col_no2)',
'                                                                                .value_list(l_row_num));',
'         ',
'    select count(*) into l_count_existing_badge from BADGE_SAVED_DETAILS_TT',
'      where user_id = V(''APP_USER'') and app_id = V(''APP_ID'') and page_id = V(''APP_PAGE_ID'') and BADGE_ID =  l_return_val1 and isdeleted = 0;',
'	  if l_count_existing_badge > 0 then',
'	       l_checkbox_checked := ''checked'';',
'	   else',
'	       l_checkbox_checked := '''';',
'	  end if;',
'	   ',
'	   htp.p(''<tr class="admin_table_row">'');',
'	   htp.p(''<td class="admin_table_cell_1">'');',
'	   htp.p(''<input type="checkbox" onclick="javascript:checkboxaction(this);" id="'' || l_return_val1 ||''" name="'' || l_return_val1 ||''" value="'' || l_return_val1 ||''" ''|| l_checkbox_checked ||''>'');',
'	   htp.p(''</td>'');',
'	   htp.p(''<td class="admin_table_cell_2">'');',
'	   htp.p(''<label for="'' || l_return_val1 ||''">'' || l_return_val1 || '' - '' || l_return_val2 || ''</label><br>'');',
'	   htp.p(''</td>'');',
'	   htp.p(''<td class="admin_table_cell_3" onclick="javascript:moverowup(this,'' || l_return_val1 ||'');" class="up"><span class="fa fa-arrow-up-alt"></span></td>',
'	          <td class="admin_table_cell_4" onclick="javascript:moverowdown(this,'' || l_return_val1 || '');" class="down"><span class="fa fa-arrow-down-alt"></span></td>'');',
'	   htp.p(''</tr>'');',
'	end loop;',
'  htp.p(''</table>'');',
'  htp.p(''<button class="t-Button t-Button--hot" onclick="javascript: location.reload(true);" type="button"><span class="t-Icon t-Icon--left fa fa-refresh" aria-hidden="true"></span><span class="t-Button-label">Click Here to Refresh Badges</span></but'
||'ton>'');',
'  htp.p(''</div>'');',
'  ',
'  FOR l_row_num IN 1 .. l_column_value_list(1).value_list.count LOOP',
'  l_count := l_count + 1;',
'  ',
'  if l_return_column3 = ''Color Theme'' then',
'  ',
'		if MOD( l_count, 6 ) = 1 then l_color_bg1 := ''first_bgcolor_1''; elsif',
'		   MOD( l_count, 6 ) = 2 then l_color_bg1 := ''second_bgcolor_1'';  elsif',
'		   MOD( l_count, 6 ) = 3 then l_color_bg1 := ''third_bgcolor_1'';   elsif',
'		   MOD( l_count, 6 ) = 4 then l_color_bg1 := ''fourth_bgcolor_1'';   elsif',
'		   MOD( l_count, 6 ) = 5 then l_color_bg1 := ''fifth_bgcolor_1'';   elsif',
'		   MOD( l_count, 6 ) = 0 then l_color_bg1 := ''sixth_bgcolor_1'';  end if;',
'    ',
'	else',
'	    ',
'		l_color_bg1 := ''apx_theme_ut'';',
'		',
'  end if;',
'  ',
' l_return_val1 := apex_plugin_util.get_value_as_varchar2(p_data_type => l_column_value_list(l_return_col_no1)',
'                                                                                .data_type,',
'                                                                 p_value     => l_column_value_list(l_return_col_no1)',
'                                                                                .value_list(l_row_num));',
' l_return_val2 := apex_plugin_util.get_value_as_varchar2(p_data_type => l_column_value_list(l_return_col_no2)',
'                                                                                .data_type,',
'                                                                 p_value     => l_column_value_list(l_return_col_no2)',
'                                                                                .value_list(l_row_num));',
'																				',
'    select count(*) into l_count_existing_badge from BADGE_SAVED_DETAILS_TT',
'      where user_id = V(''APP_USER'') and app_id = V(''APP_ID'') and page_id = V(''APP_PAGE_ID'') and BADGE_ID =  l_return_val1 and isdeleted = 0;',
'	        ',
'	    if l_return_column3 = ''Color Theme'' then',
'			',
'			if l_count_existing_badge = 0 then ',
'			  l_main_badge_class := ''ripple main_badge_hid'';',
'			 else',
'			  l_main_badge_class := ''ripple'';',
'			end if;',
'			',
'		else',
'		',
'		    if l_count_existing_badge = 0 then ',
'			  l_main_badge_class := ''ripple_ut main_badge_hid'';',
'			 else',
'			  l_main_badge_class := ''ripple_ut'';',
'			end if;',
'			',
'		end if;',
'																				',
'                  htp.p(''',
'	<div name="'' || l_return_val2 ||''" value="'' || l_return_val1 || ''" class="mainbadge '' || l_main_badge_class || '' '' || l_color_bg1 || ''" onclick="javascript:'' || l_return_column6 || '';" id="my_badge_'' || l_return_val1 || ''">      ',
'    ',
'        <div class="subbadge1"> <b>'' || l_return_val1 || ''<br>'' || l_return_val2 || ''</b> </div>',
'	',
'    </div>'');',
' end loop;',
' htp.p(''</div></body>'');',
' ',
' end if;',
'  return null;',
'  ',
'  end;'))
,p_api_version=>2
,p_render_function=>'render_region'
,p_standard_attributes=>'SOURCE_LOCATION'
,p_substitute_attributes=>false
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'1.0'
,p_files_version=>52
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(222103822328329885)
,p_plugin_id=>wwv_flow_api.id(222103607274329877)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Badge Primary Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>false
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(222104247769329891)
,p_plugin_id=>wwv_flow_api.id(222103607274329877)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Value'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>false
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(222113447095716282)
,p_plugin_id=>wwv_flow_api.id(222103607274329877)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Badge Theme'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'Color Theme'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(222114233224720338)
,p_plugin_attribute_id=>wwv_flow_api.id(222113447095716282)
,p_display_sequence=>10
,p_display_value=>'Color Theme'
,p_return_value=>'Color Theme'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(222114698481723730)
,p_plugin_attribute_id=>wwv_flow_api.id(222113447095716282)
,p_display_sequence=>20
,p_display_value=>'APEX UT'
,p_return_value=>'APEX UT'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(222105880153329891)
,p_plugin_id=>wwv_flow_api.id(222103607274329877)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_prompt=>'JS Callback Functiion'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(223205300624239446)
,p_plugin_id=>wwv_flow_api.id(222103607274329877)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_prompt=>'First Active Tab'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'Y'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(223205939292240314)
,p_plugin_attribute_id=>wwv_flow_api.id(223205300624239446)
,p_display_sequence=>10
,p_display_value=>'Y'
,p_return_value=>'Y'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(223486362998148843)
,p_plugin_attribute_id=>wwv_flow_api.id(223205300624239446)
,p_display_sequence=>20
,p_display_value=>'N'
,p_return_value=>'N'
);
wwv_flow_api.create_plugin_std_attribute(
 p_id=>wwv_flow_api.id(222106539129329899)
,p_plugin_id=>wwv_flow_api.id(222103607274329877)
,p_name=>'SOURCE_LOCATION'
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2E62616467655F73656C656374696F6E7B646973706C61793A626C6F636B3B7D0D0A0D0A2E62616467655F73656C656374696F6E5F6869647B646973706C61793A6E6F6E653B7D0D0A0D0A2E6D61696E5F62616467655F6869647B646973706C61793A6E';
wwv_flow_api.g_varchar2_table(2) := '6F6E653B7D0D0A0D0A2E6D61696E62616467657B0D0A0977696474683A203239253B0D0A09666C6F61743A206C6566743B0D0A096D617267696E3A2031253B0D0A09626F782D736861646F773A203570782035707820236365636563653B0D0A09637572';
wwv_flow_api.g_varchar2_table(3) := '736F723A20706F696E7465723B0D0A7D0D0A0D0A2E7375626261646765317B0D0A09626F726465723A2031707820736F6C696420236365636563653B200D0A0970616464696E672D746F703A323570783B200D0A0970616464696E672D626F74746F6D3A';
wwv_flow_api.g_varchar2_table(4) := '323570783B200D0A09746578742D616C69676E3A63656E7465723B0D0A7D0D0A0D0A2E66697273745F6267636F6C6F725F317B0D0A096261636B67726F756E642D636F6C6F723A20233133623663663B0D0A7D0D0A0D0A2E7365636F6E645F6267636F6C';
wwv_flow_api.g_varchar2_table(5) := '6F725F317B0D0A096261636B67726F756E642D636F6C6F723A20234642434534413B0D0A7D0D0A0D0A2E74686972645F6267636F6C6F725F317B0D0A096261636B67726F756E642D636F6C6F723A20234539354235343B0D0A7D0D0A0D0A2E666F757274';
wwv_flow_api.g_varchar2_table(6) := '685F6267636F6C6F725F317B0D0A096261636B67726F756E642D636F6C6F723A20234544383133453B0D0A7D0D0A0D0A2E66696674685F6267636F6C6F725F317B0D0A096261636B67726F756E642D636F6C6F723A20233664623332663B0D0A7D0D0A0D';
wwv_flow_api.g_varchar2_table(7) := '0A2E73697874685F6267636F6C6F725F317B0D0A096261636B67726F756E642D636F6C6F723A20236666313566663B0D0A7D0D0A0D0A2E726970706C65207B0D0A20206261636B67726F756E642D706F736974696F6E3A2063656E7465723B0D0A202074';
wwv_flow_api.g_varchar2_table(8) := '72616E736974696F6E3A206261636B67726F756E6420322E31733B0D0A20207472616E736974696F6E3A207472616E73666F726D202E32733B0D0A7D0D0A0D0A2E726970706C653A686F766572207B0D0A20206261636B67726F756E643A202330303735';
wwv_flow_api.g_varchar2_table(9) := '62652072616469616C2D6772616469656E7428636972636C652C207472616E73706172656E742031252C2023303037356265203125292063656E7465722F3135303030253B0D0A20206261636B67726F756E642D636F6C6F723A20233030373562653B0D';
wwv_flow_api.g_varchar2_table(10) := '0A20206261636B67726F756E642D73697A653A20313030253B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A0D0A2E726970706C655F7574207B0D0A20206261636B67726F756E642D706F736974696F6E3A2063656E7465723B0D0A202074';
wwv_flow_api.g_varchar2_table(11) := '72616E736974696F6E3A206261636B67726F756E6420322E31733B0D0A20207472616E736974696F6E3A207472616E73666F726D202E32733B0D0A7D0D0A0D0A2E726970706C655F75743A686F766572207B0D0A20206261636B67726F756E643A202366';
wwv_flow_api.g_varchar2_table(12) := '30663066302072616469616C2D6772616469656E7428636972636C652C207472616E73706172656E742031252C2023663066306630203125292063656E7465722F3135303030253B0D0A20206261636B67726F756E642D636F6C6F723A20236630663066';
wwv_flow_api.g_varchar2_table(13) := '303B0D0A20206261636B67726F756E642D73697A653A20313030253B0D0A2020636F6C6F723A20233030373562653B0D0A7D0D0A0D0A2E636C69636B65645F636C6173735F6261646765207B0D0A20206261636B67726F756E642D636F6C6F723A202330';
wwv_flow_api.g_varchar2_table(14) := '30373562652021696D706F7274616E743B0D0A20206261636B67726F756E642D73697A653A20313030252021696D706F7274616E743B0D0A2020636F6C6F723A20236666666666662021696D706F7274616E743B0D0A7D0D0A0D0A2E636C69636B65645F';
wwv_flow_api.g_varchar2_table(15) := '636C6173735F62616467653A686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A20233031373763352021696D706F7274616E743B0D0A20206261636B67726F756E642D73697A653A20313030252021696D706F7274616E743B0D0A20';
wwv_flow_api.g_varchar2_table(16) := '20636F6C6F723A20236536653665362021696D706F7274616E743B0D0A7D0D0A0D0A2E61646D696E5F7461626C657B0D0A0977696474683A313030253B0D0A7D0D0A0D0A2E61646D696E5F7461626C655F726F777B0D0A09626F726465722D7374796C65';
wwv_flow_api.g_varchar2_table(17) := '3A2067726F6F76653B0D0A0977696474683A313030253B0D0A09666F6E742D73697A653A20696E697469616C3B0D0A096865696768743A333070783B0D0A096261636B67726F756E642D636F6C6F723A20616C696365626C75653B0D0A7D0D0A0D0A2E61';
wwv_flow_api.g_varchar2_table(18) := '646D696E5F7461626C655F63656C6C5F337B0D0A09636F6C6F723A233030373562652021696D706F7274616E743B0D0A7D0D0A0D0A2E61646D696E5F7461626C655F63656C6C5F347B0D0A09636F6C6F723A233030373562652021696D706F7274616E74';
wwv_flow_api.g_varchar2_table(19) := '3B0D0A7D0D0A0D0A2E61646D696E5F7461626C655F63656C6C5F33202E66612D6172726F772D75702D616C747B0D0A09637572736F723A20706F696E7465723B0D0A7D0D0A0D0A2E61646D696E5F7461626C655F63656C6C5F34202E66612D6172726F77';
wwv_flow_api.g_varchar2_table(20) := '2D646F776E2D616C747B0D0A09637572736F723A20706F696E7465723B0D0A7D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(222106939942329904)
,p_plugin_id=>wwv_flow_api.id(222103607274329877)
,p_file_name=>'badge_plugin_css.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2428222E6D61696E626164676522292E636C69636B2866756E6374696F6E28297B0D0A092428222E6D61696E626164676522292E72656D6F7665436C6173732822636C69636B65645F636C6173735F626164676522293B0D0A092428222E6D61696E6261';
wwv_flow_api.g_varchar2_table(2) := '64676522292E616464436C6173732822726970706C655F757422293B0D0A09242874686973292E72656D6F7665436C6173732822726970706C655F757422293B0D0A09242874686973292E616464436C6173732822636C69636B65645F636C6173735F62';
wwv_flow_api.g_varchar2_table(3) := '6164676522293B0D0A7D293B0D0A0D0A66756E6374696F6E20736574666972737461637469766574616228297B0D0A092428222E6D61696E62616467653A666972737422292E636C69636B28293B0D0A7D0D0A0D0A66756E6374696F6E206D6F7665726F';
wwv_flow_api.g_varchar2_table(4) := '777570287265662C62616467655F6964297B0D0A20202020616C65727428226D6F76696E6720757022202B2062616467655F6964293B0D0A202020207661722024656C656D656E74203D207265663B0D0A0976617220726F77203D20242824656C656D65';
wwv_flow_api.g_varchar2_table(5) := '6E74292E706172656E7473282274723A666972737422293B0D0A09726F772E696E736572744265666F726528726F772E707265762829293B0D0A09617065782E7365727665722E70726F63657373202820226D6F76655F726F775F7570222C207B0D0A20';
wwv_flow_api.g_varchar2_table(6) := '207830313A2062616467655F69640D0A20207D2C207B0D0A20737563636573733A2066756E6374696F6E2820704461746120297B0D0A202020616C65727428224261646765206D6F76656422293B0D0A207D0D0A20207D293B0D0A7D3B0D0A0D0A66756E';
wwv_flow_api.g_varchar2_table(7) := '6374696F6E206D6F7665726F77646F776E287265662C62616467655F6964297B0D0A20202020616C65727428226D6F76696E6720646F776E22202B2062616467655F6964293B0D0A202020207661722024656C656D656E74203D207265663B0D0A097661';
wwv_flow_api.g_varchar2_table(8) := '7220726F77203D20242824656C656D656E74292E706172656E7473282274723A666972737422293B0D0A09726F772E696E73657274416674657228726F772E6E6578742829293B0D0A09617065782E7365727665722E70726F63657373202820226D6F76';
wwv_flow_api.g_varchar2_table(9) := '655F726F775F646F776E222C207B0D0A20207830313A2062616467655F69640D0A20207D2C207B0D0A20737563636573733A2066756E6374696F6E2820704461746120297B0D0A202020616C65727428224261646765206D6F76656422293B0D0A207D0D';
wwv_flow_api.g_varchar2_table(10) := '0A20207D293B0D0A7D3B0D0A0D0A66756E6374696F6E206D79636C617373746F67676C6528297B202428222E62616467655F73656C656374696F6E22292E746F67676C65436C617373282262616467655F73656C656374696F6E5F68696422293B207D3B';
wwv_flow_api.g_varchar2_table(11) := '0D0A0D0A66756E6374696F6E20636865636B626F78616374696F6E28726566297B200D0A09092020766172206C5F7374617465203D202428222322202B207265662E6964292E70726F702822636865636B656422293B0D0A09092020696628216C5F7374';
wwv_flow_api.g_varchar2_table(12) := '617465290D0A090920207B0D0A0909092020242822236D795F62616467655F222B7265662E6964292E746F67676C65436C61737328226D61696E5F62616467655F68696422293B0D0A0909092020617065782E7365727665722E70726F63657373202820';
wwv_flow_api.g_varchar2_table(13) := '2262616467655F64656C657465222C207B0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207830313A207265662E69640D0A2020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(14) := '20202020202020202020202020202020202020202020202020202020202020202020207D2C207B0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020737563636573733A';
wwv_flow_api.g_varchar2_table(15) := '2066756E6374696F6E2820704461746120297B0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020616C657274282242616467652072656D6F7665642066726F6D207361';
wwv_flow_api.g_varchar2_table(16) := '766564206669656C647322293B0D0A09090909090909090909090909207D0D0A0909090909090909090909097D293B0D0A09090920200D0A09092020207D0D0A09092020656C73650D0A090920207B0D0A0909202020202020242822236D795F62616467';
wwv_flow_api.g_varchar2_table(17) := '655F222B7265662E6964292E746F67676C65436C61737328226D61696E5F62616467655F68696422293B0D0A0909092020617065782E7365727665722E70726F636573732028202262616467655F696E73657274222C207B0D0A09090909090909090909';
wwv_flow_api.g_varchar2_table(18) := '09090920207830313A207265662E69640D0A0909090909090909090909090920207D2C207B0D0A0909090909090909090909090920737563636573733A2066756E6374696F6E2820704461746120297B0D0A09090909090909090909090909202020616C';
wwv_flow_api.g_varchar2_table(19) := '6572742822426164676520616464656420746F207361766564206669656C647322293B0D0A09090909090909090909090909207D0D0A0909090909090909090909090920207D293B0D0A090920207D0D0A097D3B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(222107321428329906)
,p_plugin_id=>wwv_flow_api.id(222103607274329877)
,p_file_name=>'badge_plugin_js.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
prompt --application/end_environment
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
