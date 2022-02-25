import 'dart:async';
import 'dart:math';
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
  var temperature = "";
  var humidity = "";
  final now = new DateTime.now();
  String formatter = "";

  late Timer timer;
  @override
  void initState() {
    super.initState();
    //callApi();
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) => callApi());
  }

  getCurrentDate() {
    return DateFormat('dd-MM-yyyy').format(DateTime.now());
  }

  void callApi() {
    getNewsData();
  }
  var url1 = "https://thingspeak.com/channels/1661958/fields/1/last.json?api_key=NPGR4TS32L3S8M5S";
  var url2 = "https://thingspeak.com/channels/1661958/fields/2/last.json?api_key=NPGR4TS32L3S8M5S";
  getNewsData() async  {
    var response1 = await http.get(Uri.parse(url1));
    var response2 = await http.get(Uri.parse(url2));

    var _newTemperature= "";
    var _newHumidity= "";

    if(response1.statusCode == 200){
      var m = jsonDecode(response1.body)["field1"];
      _newTemperature = m;
      print(m);
    }else{
      _newHumidity = "";
    }

    if(response2.statusCode == 200){
      var m = jsonDecode(response2.body)["field2"];
      _newHumidity = m;
      print(m);
    }else{
      _newHumidity = "";
    }

    Temperature newT = new Temperature(_newTemperature,_newHumidity);

    setState((){
      temperature= _newTemperature;
      humidity = _newHumidity;
      formatter = getCurrentDate();
    });
  }

  Widget buildCountWidget(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 250,
          decoration: new BoxDecoration(
            color: Colors.orange,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              Text("Temperature",
                style: TextStyle(
                  fontSize: 43,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
// <<<<<<< HEAD
// =======
//
// >>>>>>> 8828f9c89c06bce0a74a6196218e229a82e2604f
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      icon: Icon(Icons.settings_system_daydream),
                      color: Colors.white,
                      iconSize: 80,
                      onPressed: () {  }
                  ),
                  Text(
                    temperature.toString()+"\u2103",
                    style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white

                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 250,
          decoration: new BoxDecoration(
            color: Colors.blue,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              Text("Humidity",
                style: TextStyle(
                    fontSize: 43,
                    fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      icon: Icon(Icons.water_damage),
                      color: Colors.white,
                      iconSize: 80,
                      onPressed: () {  }
                  ),

                  Text(
                    humidity.toString()+" %",
                    style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text('${formatter}', style: TextStyle(
                fontSize: 30,
                color: Colors.blue
            ),),
          ),
          Expanded(
              child: buildCountWidget()
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {},
            child: const Text('Charts', style: TextStyle(
              fontSize: 30,
              color: Colors.blue
            ),),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          callApi();
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.refresh_rounded),
      ),
    );
  }
}
