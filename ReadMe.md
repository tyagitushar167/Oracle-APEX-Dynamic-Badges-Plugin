# Dynamic Badges Plug-in

This is a Region Badge Plug-in for Oracle APEX that let users to add or remove badges from the available badges and create their own view for them.
User can keep only those badges on the UI that are relevant for him/her and settings can be saved per user. User may also change the order in which the badges should appear. A JS action can also be triggered by clicking on each badge to get desired output.

The plugin uses simple JS and CSS files which are attached in the plugin itself. Developer may edit the files to change color schemes or JS messages that are referred in this plugin. 

This plugin just guides the developer to implement such requirements by doing the initial dirty work for the developer. Feel free to update the plugin as per requirements and explore the endless possibilities :)

Below are the steps to run this plugin in your APEX application

1. Install the objects in the Scripts_TT.sql file.
2. Create AJAX callback application process in your application as mentioned in Application_Processes_TT.sql file.
3. Keep the same name of the application processes as mentioned in the file.
4. Currently, only one instance of this plugin can be used on one page.
5. Sample query for region is added to Badges_sample_query_tt.sql. Write the query and select the required plugin attributes.

write to tyagitushar167@gmail.com for any queries or suggestions.

Click on "https://apex.oracle.com/pls/apex/tyagitushar167/r/an-application/dynamicbadges" for a working demo of this plugin.

Note: This plugin was built on APEX 19.2 and will be compatible with all versions over 19.2.