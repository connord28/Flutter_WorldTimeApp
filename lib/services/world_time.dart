import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location name for the UI
  late String time; //time in that location
  String flag; //url to asset flag image
  String url; //location url for api endpoint
  late bool isDaytime; // true or false if daytime or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      //make the request
      var url2 = Uri.https('worldtimeapi.org', "/api/timezone/$url");
      Response response = await get(url2);
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String datetime = data['utc_datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      //print(offset);
      //print(datetime);

      DateTime now = DateTime.parse(datetime);
      now = now.subtract(Duration(hours: int.parse(offset)));
      //print(now);

      //set time property
      //time = now.toString();
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Caught error: $e');
      time = "could not get time data";
      isDaytime = false;
    }
  }
}

WorldTime instance =
    WorldTime(location: 'Berlin', flag: 'Germany', url: 'Europe/Berlin');
