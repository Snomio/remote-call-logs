<?xml version="1.0" encoding="UTF-8"?>
<IPPhoneMenu track="no" icon_xoffset="$(math_eval:$(gui_display_xsize)/20-5)" text_xoffset="$(math_eval:$(gui_display_xsize)/20-7)" line_separator="yes" line_yoffset="$(math_eval:$(gui_display_ysize)/6)" dtmf="off" speedselect="off"  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="../schemas/minibrowser.xsd" >
<Title>Call Lists</Title>
    <ListIndicator count="{{len(data)}}" page_with_warning="-1" active_page="{{list(data).index(call_list_name)}}">{{call_list_name.capitalize()}} Calls</ListIndicator>
    % call_list = data[call_list_name]
    % if len(call_list) > 0: # Call list is not empty

        % for item in call_list:
      <MenuItem name="{{item['display']}}" id="{{call_list_name}}">
        <SubText>{{item['number']}}</SubText>
        <ExtraText>{{item['time']}}</ExtraText>
        <ExtraText2>{{item['date']}}</ExtraText2>
        <Url>phone://mb_nop#numberdial={{item['number']}}</Url>
        <DetailUrl>{{request_url + '/lists/' + call_list_name.lower()+ '/' + item['id']}}</DetailUrl>
        <IconType>{{icon}}</IconType>

        <SoftKeyItem>
          <Name>F1</Name>
          <Url>{{request_url + '/lists/' + call_list_name.lower() + '/' + item['id']}}</Url>
          <Label>F_DETAILS</Label>
        </SoftKeyItem>
        <SoftKeyItem> <!-- TODO -->
          <Name>F2</Name>
        </SoftKeyItem>
        <SoftKeyItem>
          <Name>F3</Name>
          <Label>F_DELETE</Label>
          <Url>{{request_url + '/delete/' + call_list_name.lower() + '/' + item['id']}}/snom</Url>
        </SoftKeyItem>
        <SoftKeyItem>
          <Name>F4</Name>
          <Label>F_CLEAR</Label>
          <Url>{{request_url + '/delete/' + call_list_name.lower()}}/snom</Url>
        </SoftKeyItem>
        <SoftKeyItem>
          <Name>OFFHOOK</Name>
          <SoftKey>ENTER</SoftKey>
        </SoftKeyItem>
        <SoftKeyItem>
          <Name>RIGHT</Name>
          % if call_list_name == "missed":
          <Url track="no">{{request_url + '/lists/dialed'}}</Url>
          % elif call_list_name == "dialed":
          <Url track="no">{{request_url + '/lists/received'}}</Url>
          % elif call_list_name == "received":
          <Url track="no">{{request_url + '/lists/missed'}}</Url>
          % end # end key RIGHT
        </SoftKeyItem>
        <SoftKeyItem>
          <Name>LEFT</Name>
          % if call_list_name == "missed":
          <Url track="no">{{request_url + '/lists/received'}}</Url>
          % elif call_list_name == "received":
          <Url track="no">{{request_url + '/lists/dialed'}}</Url>
          % elif call_list_name == "dialed":
          <Url track="no">{{request_url + '/lists/missed'}}</Url>
          % end # end key LEFT
        </SoftKeyItem>
      </MenuItem>

        % end # end call list loop
        
      % else: # Call list is empty
        <MenuItem name="(No data available)" id="">
            <SubText/>
            <ExtraText/>
            <ExtraText2/>
            <IconType/>

        <SoftKeyItem>
          <Name>OFFHOOK</Name>
          <Url>phone://mb_exit</Url>
        </SoftKeyItem>
        <SoftKeyItem>
          <Name>SPEAKER</Name>
          <Url>phone://mb_exit</Url>
        </SoftKeyItem>
        <SoftKeyItem>
          <Name>HEADSET_OFFHOOK</Name>
          <Url>phone://mb_exit</Url>
        </SoftKeyItem>
        <SoftKeyItem>
          <Name>HEADSET</Name>
          <Url>phone://mb_exit</Url>
        </SoftKeyItem>
        <SoftKeyItem>
          <Name>REDIAL</Name>
          <SoftKey>ENTER</SoftKey>
        </SoftKeyItem>
        <SoftKeyItem>
          <Name>F_REDIAL</Name>
          <SoftKey>ENTER</SoftKey>
        </SoftKeyItem>
        <SoftKeyItem>
          <Name>RIGHT</Name>
          % if call_list_name == "missed":
          <Url track="no">{{request_url + '/lists/dialed'}}</Url>
          % elif call_list_name == "dialed":
          <Url track="no">{{request_url + '/lists/received'}}</Url>
          % elif call_list_name == "received":
          <Url track="no">{{request_url + '/lists/missed'}}</Url>
          % end
        </SoftKeyItem>
        <SoftKeyItem>
          <Name>LEFT</Name>
          % if call_list_name == "missed":
          <Url track="no">{{request_url + '/lists/received'}}</Url>
          % elif call_list_name == "received":
          <Url track="no">{{request_url + '/lists/dialed'}}</Url>
          % elif call_list_name == "dialed":
          <Url track="no">{{request_url + '/lists/missed'}}</Url>
          % end
        </SoftKeyItem>
      </MenuItem>
    % end
    <Fetch mil="120000">phone://mb_exit</Fetch>
</IPPhoneMenu>
