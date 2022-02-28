import 'dart:convert';
import 'package:app_temperature/model/Temperature.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeViewModel extends ChangeNotifier{
  List<Temperature> newsTem1 = [];
  List<Temperature> newsTem2 = [];
  var url1 = "https://thingspeak.com/channels/1661309/field/1.json?&amp;offset=0&amp;results=60;";
  var url2 = "https://thingspeak.com/channels/1661309/field/2.json?&amp;offset=0&amp;results=60;";

  getNewsData() async  {
    var response1 = await http.get(Uri.parse(url1));
    var response2 = await http.get(Uri.parse(url2));
    List<Temperature> newsList1 = [];
    List<Temperature> newsList2 = [];

    if(response1.statusCode == 200){
      List m = jsonDecode(response1.body)['feeds'];
      for(var i = 0; i < m.length; i++){
        Temperature new_T = new Temperature(m[0]['entry_id'],m[0]['created_at'],m[0]['field1']);
        newsList1.add(new_T);
      }
    }else{
      newsList1 = [];
    }

    if(response2.statusCode == 200){
      List m = jsonDecode(response2.body)['feeds'];
      for(var i = 0; i < m.length; i++){
        Temperature new_T = new Temperature(m[0]['entry_id'],m[0]['created_at'],m[0]['field1']);
        newsList2.add(new_T);
      }
    }else{
      newsList2 = [];
    }

    newsTem1 = newsList1;
    newsTem2 = newsList2;
    notifyListeners();
  }

}