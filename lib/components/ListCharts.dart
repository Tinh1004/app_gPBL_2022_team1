import 'package:app_temperature/components/Loading.dart';
import 'package:app_temperature/components/Todo.dart';
import 'package:app_temperature/model/Temperature.dart';
import 'package:app_temperature/viewmodel/HomeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ListCharts extends StatefulWidget {
  var title;
  var check;
  ListCharts(this.title,this.check);

  @override
  _ListChartsState createState() => _ListChartsState();
}

class _ListChartsState extends State<ListCharts> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.title}"),
        ),
        body: SingleChildScrollView(
          child: ViewModelProvider<HomeViewModel>.withConsumer(
            viewModelBuilder: () => HomeViewModel(),
            onModelReady: (model) async {
              model.getNewsData();
            },
            builder: (context, model, child) =>
                model.listHumidity.length == 0 || model.listTemperature.length == 0
                ? Loading()
                : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: widget.check == 0
                        ? model.listTemperature.map((e) =>
                        Todo(e.time, e.value, widget.check),
                    ).toList()
                        : model.listHumidity.map((e) =>
                        Todo(e.time, e.value, widget.check),
                    ).toList(),
                  ),
                )
          ),
        ),
    );
  }
}
