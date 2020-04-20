
import 'package:covid19_tracker/constants/api_constants.dart';
import 'package:covid19_tracker/constants/colors.dart';
import 'package:covid19_tracker/constants/app_constants.dart';
import 'package:covid19_tracker/utilities/district.dart';
import 'package:covid19_tracker/utilities/network_handler.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class StateData extends StatefulWidget{

  StateData({this.name,this.stateCode, this.confirmed, this.active, this.recovered,
      this.deaths, this.deltaCnf, this.deltaRec, this.deltaDet,this.lastUpdated,this.stateNotes});

  final String name;
  final String confirmed;
  final String active;
  final String recovered;
  final String deaths;
  final String deltaCnf;
  final String deltaRec;
  final String deltaDet;
  final DateTime lastUpdated;
  final String stateCode;
  final String stateNotes;

  @override
  _StateDataState createState() {
    return _StateDataState();
  }
}

class _StateDataState extends State<StateData>{

  ThemeData theme;

  String name = "";
  String confirmed = "";
  String active = "";
  String recovered = "";
  String deaths = "";
  String deltaCnf = "";
  String deltaRec = "";
  String deltaDet = "";
  String stateCode = "";
  DateTime lastUpdated;
  String stateNotes = "";
  bool logarithmic = false;

  static const String LINE_CHART = 'line_chart';
  static const String BAR_CHART = 'bar_chart';

  NetworkHandler _networkHandler;

  double textScaleFactor = 1;

  @override
  void initState() {
    _networkHandler = NetworkHandler.getInstance();
    name = widget.name;
    stateCode = widget.stateCode;
    confirmed = widget.confirmed;
    active = widget.active;
    recovered = widget.recovered;
    deaths = widget.deaths;
    deltaCnf = widget.deltaCnf;
    deltaRec = widget.deltaRec;
    deltaDet = widget.deltaDet;
    lastUpdated = widget.lastUpdated;
    stateNotes = widget.stateNotes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    theme = Theme.of(context);

    if(size.width<=360){
      textScaleFactor = 0.75;
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        name,
                        style: TextStyle(
                          fontFamily: kQuickSand,
                          fontWeight: FontWeight.bold,
                          fontSize: 30*textScaleFactor,
                        ),
                      ),
                      Text(
                        "Last update at: ${DateFormat("d MMM, ").add_jm().format(lastUpdated)}",
                        style: TextStyle(
                          fontFamily: kQuickSand,
                          fontWeight: FontWeight.bold,
                          fontSize: 14*textScaleFactor,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Material(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              elevation: 2,
                              color: theme.backgroundColor,
                              child: Container(
                                decoration:BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Text(
                                        'TOTAL CONFIRMED CASES',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: kRedColor,
                                          fontSize: 12*textScaleFactor,
                                          fontFamily: kQuickSand,
                                        ),
                                      ),
                                      SizedBox(height: 16,),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            confirmed,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: kRedColor,
                                              fontSize: 24*textScaleFactor,
                                              fontFamily: kQuickSand,
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          Text(
                                            "(+$deltaCnf)",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: kRedColor,
                                              fontSize: 16*textScaleFactor,
                                              fontFamily: kQuickSand,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Material(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              elevation: 2,
                              color: theme.backgroundColor,
                              child: Container(
                                decoration:BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Text(
                                        'TOTAL ACTIVE CASES',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: kBlueColor,
                                          fontSize: 12*textScaleFactor,
                                          fontFamily: kQuickSand,
                                        ),
                                      ),
                                      SizedBox(height: 16,),
                                      Text(
                                        active,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: kBlueColor,
                                          fontSize: 24*textScaleFactor,
                                          fontFamily: kQuickSand,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: Material(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              elevation: 2,
                              color: theme.backgroundColor,
                              child: Container(
                                decoration:BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Text(
                                        'TOTAL RECOVERED',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: kGreenColor,
                                          fontSize: 12*textScaleFactor,
                                          fontFamily: kQuickSand,
                                        ),
                                      ),
                                      SizedBox(height: 16,),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            recovered,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: kGreenColor,
                                              fontSize: 24*textScaleFactor,
                                              fontFamily: kQuickSand,
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          Text(
                                            "(+$deltaRec)",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: kGreenColor,
                                              fontSize: 16*textScaleFactor,
                                              fontFamily: kQuickSand,
                                            ),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Material(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              elevation: 2,
                              color: theme.backgroundColor,
                              child: Container(
                                decoration:BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Text(
                                        'TOTAL DEATHS',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                          fontSize: 12*textScaleFactor,
                                          fontFamily: kQuickSand,
                                        ),
                                      ),
                                      SizedBox(height: 16,),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            deaths,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                              fontSize: 24*textScaleFactor,
                                              fontFamily: kQuickSand,
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          Text(
                                            "(+$deltaDet)",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                              fontSize: 16*textScaleFactor,
                                              fontFamily: kQuickSand,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                stateNotes!=""?Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6,),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(height: 10,),
                        Text(
                          "Note: $stateNotes",
                          style: TextStyle(
                            fontFamily: kNotoSansSc,
                            fontSize: 14*textScaleFactor,
                            color:kGreyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ):SizedBox(),
                SizedBox(height: 10,),
                FutureBuilder(
                  //TODO: Main builder
                  future: Future.wait([_networkHandler.getStateData(name),_networkHandler.getStatesDaily()]),
                  builder: (BuildContext context, snapshot){
                    if(snapshot.hasError){
                      return Container(
                        height: size.height*0.3,
                        child: Center(
                          child: Text(
                            'Could not fetch data',
                            style: TextStyle(
                              fontSize: 20*textScaleFactor,
                              fontFamily: kQuickSand,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    }
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Container(
                        height: size.height*0.3,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if(!snapshot.hasData){
                      return Container(
                        height: size.height*0.3,
                        child: Center(
                          child: Text(
                            'Nothing to show',
                            style: TextStyle(
                              fontSize: 20*textScaleFactor,
                              fontFamily: kNotoSansSc,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    }

                    if(snapshot.data[0] == null){
                      return Container(
                        height: size.height*0.3,
                        child: Center(
                          child: Text(
                            'Nothing to show',
                            style: TextStyle(
                              fontSize: 20*textScaleFactor,
                              fontFamily: kNotoSansSc,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    }

                    //Table data processing
                    Map districtWiseReport = snapshot.data[0];
                    List districtData = districtWiseReport[kDistrictData];
                    List<District> districts = List();

                    districtData.forEach((map){
                      //not adding unknown cases now... to be added later at the end of the sorted list
                      if('Unknown' != map[kDistrict].toString()) {
                        districts.add(
                          District(
                            map[kDistrict],
                            map[kConfirmed],
                            map[kDelta][kConfirmed],
                          ),
                        );
                      }
                    });

                    //Sorting districts according to decreasing order of  confirmed cases
                    districts.sort((a,b) => b.confirmed.compareTo(a.confirmed));

                    //unknown cases is appended at the end of the sorted list is there is any
                    if(districtData[districtData.length-1][kDistrict] == 'Unknown'){
                      districts.add(
                        District(
                          districtData[districtData.length-1][kDistrict],
                          districtData[districtData.length-1][kConfirmed],
                          districtData[districtData.length-1][kDelta][kConfirmed],
                        ),
                      );
                    }

                    //Table data processing ends here

                    //Charts data Processing

                    Map statesDailyReport = snapshot.data[1];

                    List dailyReport = statesDailyReport[kStatesDaily];
                    int totalCnf = 0;
                    int totalRec = 0;
                    int totalDet = 0;

                    List<FlSpot> cnfSpots = List();
                    List<FlSpot> recSpots = List();
                    List<FlSpot> detSpots = List();

                    int dailyHighestCnf = 0;
                    List<BarChartGroupData> dailyConfirmedChartGroup = List();

                    int dailyHighestRec = 0;
                    List<BarChartGroupData> dailyRecChartGroup = List();

                    int dailyHighestDet = 0;
                    List<BarChartGroupData> dailyDetChartGroup = List();

                    int range = 90;
                    if(dailyReport.length<range){
                      range = dailyReport.length;
                    }

                    for(int i =dailyReport.length-90; i<dailyReport.length; i++){
                      Map day = dailyReport[i];
                      if(i%3==0){
                        String str = day[stateCode.toLowerCase()];
                        int currentCnf = 0;
                        if(str != ""){
                          currentCnf = int.parse(str);
                        }

                        if(dailyHighestCnf<currentCnf){
                          dailyHighestCnf = currentCnf;
                        }
                        totalCnf += currentCnf;
                        cnfSpots.add(
                          FlSpot(
                            (i~/3).toDouble(),
                            totalCnf.toDouble(),
                          ),
                        );
                        dailyConfirmedChartGroup.add(
                          BarChartGroupData(
                            x: i,
                            barRods: [
                              BarChartRodData(
                                y: currentCnf.toDouble(),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                ),
                                color: theme.accentColor,
                                width: 5,
                              ),
                            ],
                          ),
                        );
                      }
                      if(i%3==1){
                        String str = day[stateCode.toLowerCase()];
                        int currentRec = 0;
                        if(str!=""){
                          currentRec = int.parse(str);
                        }
                        if(dailyHighestRec < currentRec){
                          dailyHighestRec = currentRec;
                        }
                        totalRec += currentRec;
                        recSpots.add(
                          FlSpot(
                            (i~/3).toDouble(),
                            totalRec.toDouble(),
                          ),
                        );
                        dailyRecChartGroup.add(
                          BarChartGroupData(
                            x: i,
                            barRods: [
                              BarChartRodData(
                                y: currentRec.toDouble(),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                ),
                                color: theme.accentColor,
                                width: 5,
                              ),
                            ],
                          ),
                        );
                      }
                      if(i%3==2){
                        String str = day[stateCode.toLowerCase()];
                        int currentDet = 0;
                        if(str != "") {
                          currentDet = int.parse(str);
                        }

                        if(dailyHighestDet < currentDet){
                          dailyHighestDet = currentDet;
                        }
                        totalDet += currentDet;
                        detSpots.add(
                          FlSpot(
                            (i~/3).toDouble(),
                            totalDet.toDouble(),
                          ),
                        );
                        dailyDetChartGroup.add(
                          BarChartGroupData(
                            x: i,
                            barRods: [
                              BarChartRodData(
                                y: currentDet.toDouble(),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                ),
                                color: theme.accentColor,
                                width: 5,
                              ),
                            ],
                          ),
                        );
                      }
                    }

                    List<Widget> lineChartLayouts = List();

                    lineChartLayouts.add(
                      _getLineChartLayout('Confirmed Cases',cnfSpots, totalCnf.toDouble(), (dailyReport.length~/3)),
                    );

                    lineChartLayouts.add(
                      _getLineChartLayout('Recoveries',recSpots, totalRec.toDouble(), (dailyReport.length~/3)),
                    );

                    lineChartLayouts.add(
                      _getLineChartLayout('Deaths',detSpots, totalDet.toDouble(), (dailyReport.length~/3)),
                    );

                    List<Widget> barChartLayouts = List();

                    barChartLayouts.add(
                      _getBarChartLayout('Daily Confirmed Cases', dailyConfirmedChartGroup, (dailyHighestCnf+100).toDouble(),range~/3),
                    );

                    barChartLayouts.add(
                      _getBarChartLayout('Daily Recovered Cases', dailyRecChartGroup, (dailyHighestRec+100).toDouble(),range~/3),
                    );

                    barChartLayouts.add(
                      _getBarChartLayout('Daily Deaths', dailyDetChartGroup, (dailyHighestDet+100).toDouble(),range~/3),
                    );


                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Material(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          elevation: 2,
                          color: theme.backgroundColor,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              children: <Widget>[
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        )
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            'DISRICT',
                                            style: TextStyle(
                                              color: kGreyColor,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: kQuickSand,
                                              fontSize: 12*textScaleFactor,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'CONFIRMED',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: kQuickSand,
                                              color: Colors.red,
                                              fontSize: 12*textScaleFactor,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'INCREASE',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: kQuickSand,
                                              color: Colors.red,
                                              fontSize: 12*textScaleFactor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Container(height: 1,color: kGreyColor,),
                                SizedBox(height: 5,),
                                Center(
                                  child: Container(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: districts.length,
                                        itemBuilder:(BuildContext context,int index){
                                          District district = districts[index];
                                          int disDeltaCnf = district.deltaCnf;
                                          String districtName = district.name;
                                          int confirmed = district.confirmed;
                                          return Column(
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(top: 10,left: 6,right: 6),
                                                height: 30,
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Text(
                                                        districtName,
                                                        style: TextStyle(
                                                          fontFamily: kQuickSand,
                                                          fontSize: 12*textScaleFactor,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        confirmed.toString(),
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontFamily: kQuickSand,
                                                          fontSize: 12*textScaleFactor,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        disDeltaCnf==0?"":"+$disDeltaCnf",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontFamily: kQuickSand,
                                                          color: Colors.red,
                                                          fontSize: 12*textScaleFactor,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 5,),
                                              Container(height: 1,color: theme.brightness == Brightness.light?kGreyColorLight:Colors.grey[800],),
                                              SizedBox(height: 5,),
                                            ],
                                          );
                                        }
                                    ),
                                  ),
                                ),//Tabular data
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Spread Trends',
                                  style: TextStyle(
                                    fontFamily: kQuickSand,
                                    fontSize: 25*textScaleFactor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Last 30 days',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontFamily: kQuickSand,
                                    fontSize: 14*textScaleFactor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10,),
                              child: Container(
                                height: 20,
                                width: 20,
                                child: Center(
                                  child: Icon(
                                    SimpleLineIcons.arrow_right,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Container(
                          height: size.width*0.7,
                          width: size.width,
                          child: Center(
                            child: PageView.builder(
                                itemCount: lineChartLayouts.length,
                                scrollDirection: Axis.horizontal,
                                controller: PageController(
                                  initialPage: 0,
                                  viewportFraction: 0.95,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return lineChartLayouts[index];
                                }
                            ),
                          ),
                        ),
                        Container(
                          height: size.width*0.7,
                          width: size.width,
                          child: Center(
                            child: PageView.builder(
                                itemCount: barChartLayouts.length,
                                scrollDirection: Axis.horizontal,
                                controller: PageController(
                                  initialPage: 0,
                                  viewportFraction: 0.95,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return barChartLayouts[index];
                                }
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



  Widget _getBarChartLayout(String caseStr,List<BarChartGroupData> barGroups,double highest,int maxX){
    return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
            child: Material(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              elevation: 2,
              color: theme.backgroundColor,
              shadowColor: Colors.black,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      caseStr,
                      style: TextStyle(
                        fontFamily: kQuickSand,
                        fontSize: 25*textScaleFactor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20,),
                    _getBarChart(barGroups, highest,maxX)
                  ],
                ),
              ),
            ),
          ),
        ]
    );
  }

  Widget _getLineChartLayout(String caseStr,List<FlSpot> spots,double total,int maxX){
    return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
            child: Material(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              elevation: 2,
              color: theme.backgroundColor,
              shadowColor: Colors.black,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      caseStr,
                      style: TextStyle(
                        fontFamily: kQuickSand,
                        fontSize: 25*textScaleFactor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20,),
                    _getLineChart(spots,total,maxX),
                  ],
                ),
              ),
            ),
          ),
        ]
    );
  }


  Widget _getBarChart(List<BarChartGroupData> barGroups,double highest,int maxX){
    return Padding(
      padding: const EdgeInsets.all(8),
      child: AspectRatio(
        aspectRatio: 2,
        child: BarChart(
          BarChartData(
            barTouchData: BarTouchData(
                allowTouchBarBackDraw: true,
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: kAccentColor,
                ),
                touchCallback: (BarTouchResponse response){}
            ),
            borderData: FlBorderData(
              show: true,
              border: Border(
                bottom: BorderSide(
                  color: kGreyColor,
                ),
                right: BorderSide(
                  color: kGreyColor,
                ),
              ),
            ),
            titlesData: FlTitlesData(
              leftTitles: SideTitles(
                showTitles: false,
              ),
              rightTitles: SideTitles(
                  reservedSize: 20,
                  showTitles: true,
                  interval: highest<200?50:200,
                  getTitles: (double value){
                    return value.toInt().toString();
                  },
                  textStyle: TextStyle(
                    color: theme.brightness == Brightness.light?Colors.black:Colors.white,
                    fontSize: 10*textScaleFactor,
                  )
              ),
              bottomTitles: SideTitles(
                  rotateAngle: math.pi*90,
                  interval: 5,
                  showTitles: true,
                  getTitles: (double value){
                    DateTime now = DateTime.now();
                    DateTime returnDate = DateTime(
                        2020,
                        now.month,
                        now.day-maxX+value.toInt()
                    );
                    return DateFormat("d MMM").format(returnDate);
                  },
                  textStyle: TextStyle(
                    color: theme.brightness == Brightness.light?Colors.black:Colors.white,
                    fontSize: 8*textScaleFactor,
                  )
              ),
            ),
            maxY: highest,
            backgroundColor: Colors.transparent,
            barGroups: barGroups,
            gridData: FlGridData(
                drawHorizontalLine: true,
                horizontalInterval: highest<200?50:200,
                drawVerticalLine: true
            ),
          ),
        ),
      ),
    );
  }

  Widget _getLineChart(List<FlSpot> spots,double total,int maxX){
    return Padding(
      padding: const EdgeInsets.all(8),
      child: AspectRatio(
        aspectRatio: 2,
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                tooltipBottomMargin: 50,
                tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
              ),
              touchCallback: (LineTouchResponse touchResponse) {},
              handleBuiltInTouches: true,
            ),
            maxY: total<500?total+200:total+2000,
            borderData: FlBorderData(
              show: true,
              border: Border(
                bottom: BorderSide(
                  color: kGreyColor,
                ),
                right: BorderSide(
                  color: kGreyColor,
                ),
              ),
            ),
            gridData: FlGridData(
              drawHorizontalLine: true,
              horizontalInterval: total<500?100:2000,
            ),
            titlesData: FlTitlesData(
                leftTitles: SideTitles(
                  showTitles: false,
                ),
                rightTitles: SideTitles(
                    showTitles: true,
                    interval: logarithmic?math.log(2000)*math.log2e*1000:total<500?100:2000,
                    reservedSize: total<500?20:10,
                    textStyle: TextStyle(
                      fontSize: 10*textScaleFactor,
                      color: theme.brightness == Brightness.light?Colors.black:Colors.white,
                      fontFamily: kNotoSansSc,
                    ),
                    getTitles: (double value){
                      if(value<10000 && value>500){
                        return '${(value).toString().substring(0,1)}k';
                      }else if (value>10000){
                        return '${(value).toString().substring(0,2)}k';
                      }else{
                        return '${(value).toInt().toString()}';
                      }
                    }
                ),
                bottomTitles: SideTitles(
                  showTitles: true,
                  rotateAngle: math.pi*90,
                  interval: 3,
                  textStyle: TextStyle(
                    fontSize: 8*textScaleFactor,
                    color: theme.brightness == Brightness.light?Colors.black:Colors.white,
                    fontFamily: kNotoSansSc,
                  ),
                  getTitles: (double value){
                    DateTime now = DateTime.now();
                    DateTime returnDate = DateTime(
                        2020,
                        now.month,
                        now.day-maxX+value.toInt()
                    );
                    return DateFormat("d MMM").format(returnDate);
                  },
                )
            ),
            lineBarsData: [
              LineChartBarData(
                dotData: FlDotData(
                  dotSize: 2,
                  strokeWidth: 0,
                ),
                isCurved: false,
                barWidth: 2,
                isStrokeCapRound: true,
                colors: [theme.accentColor],
                spots: spots,
              ),
            ],
          ),
        ),
      ),
    );
  }

}