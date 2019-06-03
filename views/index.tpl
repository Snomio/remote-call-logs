<html>
<body>
<h1>Remote Snom call lists manager PoC</h1>
<p>Please configure the <b><i>setting_server=<a href="{{request_url}}/settings.xml">{{request_url}}/settings.xml</a></i></b> and then reboot your phone</p>
% for list_name in data.keys():
  <h2>{{list_name}}</h2>
  <table border="1">
    <tr>
      <td>Display</td><td>Number</td><td>Date</td><td>Time</td><td/>
    </tr>
    % for call in data[list_name]:
    <tr>
      <td>{{call['display']}}</td><td>{{call['number']}}</td><td>{{call['date']}}</td><td>{{call['time']}}</td><td><a href="/delete/{{list_name.lower()}}/{{call['id']}}">Delete</a></td>
    </tr>
    % end
    <form action="/add/{{list_name.lower()}}" method="POST">
      <tr>
        <td><input name="display"/></td>
        <td><input name="number"/></td>
        <td><input name="date"/></td>
        <td><input name="time"/></td>
        <td><input type="submit" name="Add"/></td>
      </tr>
    </form>
  </table>
  <hr/>
% end
</body>
</html>
