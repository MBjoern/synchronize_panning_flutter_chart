import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() => runApp(SynchronizedZoom());
final cartesianChartKey = GlobalKey<CartesianChartState>();
final chartKey = GlobalKey<ChartState>();

class SynchronizedZoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Synchronized Zoom',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

double zoomP = 0.5;
double zoomF = 0.2;

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: <Widget>[
              Container(
                height: 280,
                child: Chart(key: chartKey),
              ),
              Container(
                height: 280,
                child: CartesianChart(key: cartesianChartKey),
              ),
            ]),
          )),
    );
  }
}

class Chart extends StatefulWidget {
  Chart({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ChartState();
  }
}

class ChartState extends State<Chart> {
  ChartState({Key key});

  void refreshChart() {
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        backgroundColor: Colors.white,
        zoomPanBehavior: ZoomPanBehavior(
          enablePanning: true,
          enablePinching: true,
          enableDoubleTapZooming: true,
          zoomMode: ZoomMode.x
        ),
        onZooming: (ZoomPanArgs args) {
          if (args.axis.name == 'primaryXAxis') {
            zoomP = args.currentZoomPosition;
            zoomF = args.currentZoomFactor;
            cartesianChartKey.currentState.chartRefresh();
          }
        },
        primaryXAxis: CategoryAxis(
            zoomFactor: zoomF, zoomPosition: zoomP, name: 'primaryXAxis'),
        primaryYAxis: NumericAxis(name: 'primaryYAxis'),
        title: ChartTitle(text: 'Chart 1'),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <LineSeries<SalesData, String>>[
          LineSeries<SalesData, String>(
              dataSource: <SalesData>[
                SalesData('Jan', 21),
                SalesData('Feb', 24),
                SalesData('Mar', 35),
                SalesData('Apr', 38),
                SalesData('May', 54),
                SalesData('Jun', 21),
                SalesData('Jul', 24),
                SalesData('Aug', 35),
                SalesData('Sep', 38),
                SalesData('Oct', 54),
                SalesData('Nov', 38),
                SalesData('Dec', 54)
              ],
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales)
        ]);
  }
}

class CartesianChart extends StatefulWidget {
  CartesianChart({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return CartesianChartState();
  }
}

class CartesianChartState extends State<CartesianChart> {
  CartesianChartState({Key key});
  void chartRefresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        backgroundColor: Colors.white,
        zoomPanBehavior: ZoomPanBehavior(
          enablePanning: true,
          enablePinching: true,
          enableDoubleTapZooming: true,
          zoomMode: ZoomMode.x
        ),
        onZooming: (ZoomPanArgs args) {
          if (args.axis.name == 'primaryXAxis') {
            zoomP = args.currentZoomPosition;
            zoomF = args.currentZoomFactor;
            chartKey.currentState.refreshChart();
          }
        },
        primaryXAxis: CategoryAxis(zoomFactor: zoomF, zoomPosition: zoomP, name:'primaryXAxis'),
        // Chart title
        title: ChartTitle(text: 'Chart 2'),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <LineSeries<SalesData, String>>[
          LineSeries<SalesData, String>(
              dataSource: <SalesData>[
                SalesData('Jan', 21),
                SalesData('Feb', 24),
                SalesData('Mar', 35),
                SalesData('Apr', 38),
                SalesData('May', 54),
                SalesData('Jun', 21),
                SalesData('Jul', 24),
                SalesData('Aug', 35),
                SalesData('Sep', 38),
                SalesData('Oct', 54),
                SalesData('Nov', 38),
                SalesData('Dec', 54)
              ],
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales)
        ]);
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
