<?xml version="1.0" encoding="utf-8"?>
<IPPhoneText dtmf="off" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="../schemas/minibrowser.xsd" state="others_except_mb">
% call = next(item for item in call_list if item["id"] == call_id)
  <Title>Details: {{call_list_name}}</Title>
  <SoftKeyItem>
    <Name>F4</Name>
    <Label>F_DELETE</Label>
    <Url>{{request_url + '/delete/' + call_list_name.lower() + '/' + call_id}}</Url>
  </SoftKeyItem>
  <SoftKeyItem>
    <Name>ENTER</Name>
    <Url>phone://mb_nop#numberdial={{call['number']}}</Url>
  </SoftKeyItem>
  <SoftKeyItem>
    <Name>OFFHOOK</Name>
    <Url>phone://mb_nop#numberdial={{call['number']}}</Url>
  </SoftKeyItem>
  <SoftKeyItem>
    <Name>HEADSET_OFFHOOK</Name>
    <Url>phone://mb_nop#numberdial={{call['number']}}</Url>
  </SoftKeyItem>
  <SoftKeyItem>
    <Name>SPEAKER</Name>
    <Url>phone://mb_nop#numberdial={{call['number']}}</Url>
  </SoftKeyItem>
  <Text>
Name: {{call['display']}}<br/>
Number: {{call['number']}}<br/>
Time: {{call['time']}}<br/>
 </Text>
</IPPhoneText>

