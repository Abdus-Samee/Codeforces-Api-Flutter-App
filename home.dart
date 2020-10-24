import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutterapi/api.dart';
import 'dart:math' as math;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {

  List<charts.Series<Task,String>> _series = List<charts.Series<Task,String>>();
  List<charts.Series<VerdictTypes,String>> _bar = List<charts.Series<VerdictTypes,String>>();
  List<charts.Series<Rating,int>> _line = List<charts.Series<Rating,int>>();
  
  Map<String, int> map = Map<String,int>();
  Map<String,  int> verdictMap = Map<String, int>();
  Map<int,  int> ratingMap = Map<int, int>();

  HomePage(Map map1, Map map2, Map map3){
    this.map = map1;
    this.verdictMap = map2;
    this.ratingMap = map3;
    _gogo();
    _verdict();
    _rating();
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

  _verdict(){
    var line = new List<VerdictTypes>();
    verdictMap.forEach((key, value) { 
      line.add(new VerdictTypes(key, value));
    });

    if(verdictMap.isNotEmpty){
      _bar.add(
        charts.Series(
          domainFn: (VerdictTypes v, _) => v.verdict,
          measureFn: (VerdictTypes v, _) => v.quantity,
          id: '2020',
          data: line,
          fillPatternFn: (_, __) => charts.FillPatternType.solid,
          fillColorFn: (VerdictTypes v, _) =>
              charts.ColorUtil.fromDartColor(Color(0xff990099)),
        ),
      );
    }
  }

  _rating(){
    var lineData = new List<Rating>();
    ratingMap.forEach((key, value) {
      lineData.add(new Rating(key, value));
    });

    _line.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        id: 'Rating Change',
        data: lineData,
        domainFn: (Rating r, _) => r.id,
        measureFn: (Rating r, _) => r.rating,
      ),
    );
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              FlatButton.icon(
                icon: Icon(Icons.create),
                label: Text('Handle'),
                onPressed: (){},
              )
            ],
            title: Text("Codeforces API"),
            backgroundColor: Colors.blueGrey,
            bottom: TabBar(
              indicatorColor: Colors.brown,
              tabs: [
                Tab(icon: Icon(Icons.pie_chart),),
                Tab(icon: Icon(Icons.bar_chart),),
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
                        Text(
                            'Types of Problemes',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
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
                                  labelPosition: charts.ArcLabelPosition.outside,
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
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Verdicts on Problems',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Expanded(
                          child: charts.BarChart(
                            widget._bar,
                            animate: true,
                            animationDuration: Duration(seconds: 2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: charts.LineChart(
                            widget._line,
                            defaultRenderer: new charts.LineRendererConfig(
                              includeArea: true,
                              stacked: true,
                            ),
                            animate: true,
                            animationDuration: Duration(seconds: 2),
                            behaviors: [
                              new charts.ChartTitle(
                                'Contest ID',
                                behaviorPosition: charts.BehaviorPosition.bottom,
                                titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
                              ),
                              new charts.ChartTitle(
                                'Rating Change',
                                behaviorPosition: charts.BehaviorPosition.start,
                                titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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

class VerdictTypes{
  String verdict;
  int quantity;

  VerdictTypes(this.verdict, this.quantity);
}

class Rating{
  int id;
  int rating;

  Rating(this.id, this.rating);
}
