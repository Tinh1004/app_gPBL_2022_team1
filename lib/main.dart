import 'dart:async';
import 'dart:math';
import 'package:app_temperature/components/ListCharts.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:app_temperature/model/Temperature.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Humidity & Temperature '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int random(min, max){
    return min + Random().nextInt(max - min);
  }
  var temperature = 0;
  var humidity = 0;
  final now = new DateTime.now();
  String formatter = "";

  late Timer timer;
  @override
  void initState() {
    super.initState();
    //callApi();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => callApi());
  }
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  getCurrentDate() {
    return DateFormat('dd-MM-yyyy  hh:mm aaa').format(DateTime.now());
  }

  void callApi() {
    getNewsData();
  }
  var url1 = "https://thingspeak.com/channels/1661958/fields/1/last.json?api_key=NPGR4TS32L3S8M5S";
  var url2 = "https://thingspeak.com/channels/1661958/fields/2/last.json?api_key=NPGR4TS32L3S8M5S";
  getNewsData() async  {
    var response1 = await http.get(Uri.parse(url1));
    var response2 = await http.get(Uri.parse(url2));

    var _newTemperature= 0;
    var _newHumidity= 0;

    if(response1.statusCode == 200){
      var m = jsonDecode(response1.body)["field1"];
      _newTemperature = int.parse(m);
      print(m);
    }else{
      _newHumidity = 0;
    }

    if(response2.statusCode == 200){
      var m = jsonDecode(response2.body)["field2"];
      _newHumidity = int.parse(m);

      print(m);
    }else{
      _newHumidity = 0;
    }

    setState((){
      temperature= _newTemperature;
      humidity = _newHumidity;
      formatter = getCurrentDate();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right:20.0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text('${formatter}', style: TextStyle(
                    fontSize: 30,
                    color: Colors.blue
                ),),
              ),

              SizedBox(
                height: 50,
              ),

              //tem
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListCharts("Temperature",0)),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 230,
                  decoration: new BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          temperature <= 25
                              ? "assets/image/cold.jpg"
                              : temperature >= 30
                                ?"assets/image/hot.jpg"
                                :"assets/image/normally.jpg"

                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 30, left: 20),
                              child: Column(
                                children: [
                                  Text(
                                    "Temperature",
                                    style: TextStyle(
                                        fontSize: 28.0,
                                        color: Colors.white
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "${temperature}\u2103",
                                    style: TextStyle(
                                        fontSize: 50.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.4,
                        height: MediaQuery.of(context).size.width*0.4,
                        child: Image(
                            image: AssetImage(
                                temperature <= 25
                                    ?'assets/icon/temperature_2.png'
                                    : temperature >= 30
                                      ?'assets/icon/temperature_1.png'
                                      : 'assets/icon/normally.png'
                            ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),



              //hum
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListCharts("Humidity",1)),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 230,
                  decoration: new BoxDecoration(
                    // color: Colors.blue,
                    image: DecorationImage(
                      image: AssetImage("assets/image/humidyti.jpg"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width *0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 30, left: 20),
                              child: Column(
                                children: [
                                  Text(
                                    "Humidity",
                                    style: TextStyle(
                                        fontSize: 30.0,
                                        color: Colors.white
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "${humidity}%",
                                    style: TextStyle(
                                        fontSize: 50.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.4,
                        height: MediaQuery.of(context).size.width*0.4,
                        child: Image(
                          image: AssetImage(
                              'assets/icon/humidity.png'
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sensor 1",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54
                        ),
                      ),
                      Text(
                          "${temperature * 9/5 + 32}\u2109",
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }
}
