<?xml version="1.0" encoding="utf-8"?>
<settings>
  <phone-settings>
    <gui_fkey1>
        <initialization>
            <variable name='icon' value='kIconTypeFkeyCallList'/>
            <state value='Call logs'/>
        </initialization>
        <action>
            <url target="{{request_url}}/lists/missed" when="on press"/>
        </action>
    </gui_fkey1>
    <idle_ok_key_action>url {{request_url}}/lists/dialed</idle_ok_key_action>
  </phone-settings>
</settings>
