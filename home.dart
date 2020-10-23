import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutterapi/api.dart';
import 'dart:math' as math;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {

  List<charts.Series<Task,String>> _series = List<charts.Series<Task,String>>();
  Map<String, int> map = Map<String,int>();

  HomePage(Map map){
    this.map = map;
    _gogo();
  }

  _gogo(){
    var pie = new List<Task>();

    map.forEach((key, value) {
      pie.add(new Task(key, value, Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0)));
    });

    if(map.isNotEmpty){
      _series.add(
        charts.Series(
          data: pie,
          domainFn: (Task task, _) => task.task,
          measureFn: (Task task, _) => task.val,
          colorFn: (Task task, _) => charts.ColorUtil.fromDartColor(task.colorVal),
          id: 'Daily Task',
          labelAccessorFn: (Task row, _) => '${row.val}',
        ),
      );
    }
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

//  _generateData(){
//    var pie = new List<Task>();
//
//    map.forEach((key, value) {
//      pie.add(new Task(key, value, Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0)));
//    });
//
//    if(map.isNotEmpty){
//      _series.add(
//        charts.Series(
//          data: pie,
//          domainFn: (Task task, _) => task.task,
//          measureFn: (Task task, _) => task.val,
//          colorFn: (Task task, _) => charts.ColorUtil.fromDartColor(task.colorVal),
//          id: 'Daily Task',
//          labelAccessorFn: (Task row, _) => '${row.val}',
//        ),
//      );
//    }
//  }
//
//  _getData() async {
//    Api o = new Api();
//    await o.getInfo();
//    map = o.m;
//    _generateData();
//  }

//  @override
//  void initState(){
//    super.initState();
//    _series = List<charts.Series<Task,String>>();
//    _gogo();
//  }






  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              FlatButton.icon(
                icon: Icon(Icons.settings),
                label: Text('Input'),
                onPressed: (){},
              )
            ],
            title: Text("Codeforces API"),
            backgroundColor: Colors.blueGrey,
            bottom: TabBar(
              indicatorColor: Colors.brown,
              tabs: [
                Tab(icon: Icon(Icons.bar_chart),),
                Tab(icon: Icon(Icons.pie_chart),),
                Tab(icon: Icon(Icons.stacked_line_chart),),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text('API Data'),
                        SizedBox(height: 10,),
                        Expanded(
                          child: charts.PieChart(
                            widget._series,
                            animate: true,
                            animationDuration: Duration(seconds: 2),
                            behaviors: [
                              new charts.DatumLegend(
                                outsideJustification: charts.OutsideJustification.endDrawArea,
                                horizontalFirst: false,
                                desiredMaxRows: 4,
                                cellPadding: EdgeInsets.only(right: 4, bottom: 4),
                                entryTextStyle: charts.TextStyleSpec(
                                  color: charts.MaterialPalette.purple.shadeDefault,
                                  fontFamily: 'Georgia',
                                  fontSize: 11,
                                ),
                              ),
                            ],
                            defaultRenderer: new charts.ArcRendererConfig(
                              arcWidth: 100,
                              arcRendererDecorators: [
                                new charts.ArcLabelDecorator(
                                  labelPosition: charts.ArcLabelPosition.inside,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Text(
                'Annyeong'
              ),
              Text(
                'Gamsahabnida'
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Task{
  String task;
  int val;
  Color colorVal;

  Task(this.task, this.val, this.colorVal);
}