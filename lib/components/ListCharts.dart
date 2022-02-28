import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ListCharts extends StatefulWidget {
  const ListCharts({Key? key}) : super(key: key);

  @override
  _ListChartsState createState() => _ListChartsState();
}

class _ListChartsState extends State<ListCharts> {
  var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, 5.0, -0.5, 0.0, 0.0];
  var data1 = [1.0, 2.0, 1.5, 2.0, 0.0, 0.0, 10.5, -1.0, -0.5, 0.0, 0.0];
  final List<ChartData> chartData = [
    ChartData(2010, 35),
    ChartData(2011, 28),
    ChartData(2012, 34),
    ChartData(2013, 32),
    ChartData(2014, 40)
  ];


  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(2010, 35),
      ChartData(2011, 28),
      ChartData(2012, 34),
      ChartData(2013, 32),
      ChartData(2014, 40)
    ];

    final List<ChartData> chartData1 = [
      ChartData(2010, 20),
      ChartData(2011, 28),
      ChartData(2012, 50),
      ChartData(2013, 32),
      ChartData(2015, 30)
    ];

    return Scaffold(
        appBar: AppBar(

          title: Text("List Charts"),
        ),
        body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
                height: 400,
                child: SfCartesianChart(
                    series: <ChartSeries>[
                      // Renders line chart
                      LineSeries<ChartData, int>(
                          dataSource: chartData,
                          xValueMapper: (ChartData sales, _) => sales.year,
                          yValueMapper: (ChartData sales, _) => sales.sales
                      ),
                      LineSeries<ChartData, int>(
                          dataSource: chartData1,
                          xValueMapper: (ChartData sales, _) => sales.year,
                          yValueMapper: (ChartData sales, _) => sales.sales
                      ),

                    ]
                )
            )
        )
    );
  }
}
class ChartData {
  ChartData(this.year, this.sales);
  final int year;
  final double sales;
}