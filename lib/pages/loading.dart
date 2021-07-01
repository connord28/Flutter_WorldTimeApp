import 'package:flutter/material.dart';
import 'package:world_time_app/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String time = 'loading';

  /*void getData() async {
    var url = Uri.https('jsonplaceholder.typicode.com', "/todos/1");
    Response response = await get(url);
    Map data = jsonDecode(response.body);
    print(data);
    print(data['title']);
    //print(response.body);
  }*/

  void setupWorldTime() async {
    WorldTime instance =
        WorldTime(location: 'Berlin', flag: 'Germany', url: 'Europe/Berlin');
    await instance.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime': instance.isDaytime,
    });
    //print(instance.time);
    /*setState(() {
      time = instance.time;
    });*/
  }

  @override
  void initState() {
    super.initState();
    //getTime();
    //getData();
    setupWorldTime();
    //print("initState function ran");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
