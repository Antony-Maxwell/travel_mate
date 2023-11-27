import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class overView extends StatefulWidget {
  const overView({super.key});

  @override
  State<overView> createState() => _overViewState();
}

class _overViewState extends State<overView> {
  late List<OverView> _chartData;
  @override
  void initState() {
    _chartData = getChartData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SfCircularChart(
        series: <CircularSeries>[
          PieSeries<OverView, String>(
            dataSource: _chartData,
            xValueMapper: (OverView data, _) => data.places,
            yValueMapper: (OverView data, _) => data.uploads,
          )
        ],
      ),
    ));
  }

  List<OverView> getChartData(){
    final List<OverView> chartData = [
      OverView('users', 'Deactivation', 10, 'requests', 'places'),
      OverView('users', 'Deactivation', 50, 'requests', 'places'),
      OverView('users', 'Deactivation', 80, 'requests', 'places'),
      OverView('users', 'Deactivation', 60, 'requests', 'places'),
      OverView('users', 'Deactivation', 10, 'requests', 'places'),
    ];
    return chartData;
  }
}

class OverView{

  OverView(
    this.users,
    this.unInstalls,
    this.uploads,
    this.requests,
    this.places,
  );
  final String users;
  final String unInstalls;
  final int uploads;
  final String requests;
  final String places;
}