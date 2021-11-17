import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:flutter_icons/flutter_icons.dart';
import 'package:simons/shared/color.dart';
import 'package:simons/shared/theme.dart';
import 'package:simons/ui/widgets/another_sensor_card.dart';
import 'package:simons/ui/widgets/chart_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'dart:developer';

List<Color> gradientColors = [kGreenColor];
List<double> dataSensorList = [];
List<FlSpot> spotSensorList = [];
List<FlSpot> removedSensorList = [];
final dbRef = FirebaseDatabase.instance.reference();
double data = 0.0;

_launchURL() async {
  const url = 'https://bit.ly/SIMONS_DataSensor';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

bool isStopped = false; //global

Future<void> readData() async {
  dbRef.child("Test").once().then((DataSnapshot snapshot) {
    data = snapshot.value['Sensor'].toDouble();
    dataSensorList.add(data);
    double dataSensorListLength = (dataSensorList.length - 1).toDouble();
    spotSensorList.add(FlSpot(
        dataSensorListLength, dataSensorList[dataSensorListLength.toInt()]));
  });
  if (dataSensorList.length >= 24) {
    spotSensorList.clear();
    dataSensorList.clear();
  }
  log('spotSensorList, $spotSensorList');
  log('spotSensorList.length, ${spotSensorList.length}');
  log('dataSensorList, $dataSensorList');
  log('dataSensorList.length, ${dataSensorList.length}');
}

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    Timer.periodic(Duration(hours: 1), (t) {
      log('print timer');
      readData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Query lastQuery  = databaseReference.child("SensorDatabase").orderByKey().limitToLast(1);

    Widget header() {
      return Container(
          margin: EdgeInsets.only(
            left: 40,
            top: 40,
            bottom: 0,
            right: 40,
          ),
          child: Row(
            children: [
              Expanded(
                //mencegah overflow dibandingkan menggunakan MainAxisAligment.spaceBetween
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Statistics',
                      style: blackTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: semiBold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      'SIMONS',
                      style: greyTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 50,
                height: 52,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/setting');
                  },
                  child: Image.asset(
                    'assets/images/simons_logo2.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ));
    }

    Widget stackCard() {
      //Graph

      // oneHourTimer();
      return Container(
          margin: EdgeInsets.only(
            top: 40,
            left: 10,
            right: 10,
            bottom: 13,
          ),
          child: StreamBuilder(
            stream: databaseReference.child("DataSensor").onValue,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData &&
                  !snapshot.hasError &&
                  snapshot.data.snapshot.value != null) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 10),
                      child: Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: grey.withOpacity(0.01),
                                spreadRadius: 10,
                                blurRadius: 3,
                                // changes position of shadow
                              ),
                            ]),
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                  left: 20,
                                  right: 20,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                right: 20,
                                              ),
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    'assets/images/icon_light2.png',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "Light\nIntensity",
                                              style: greenTextStyle.copyWith(
                                                fontSize: 18,
                                                fontWeight: semiBold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // SizedBox(
                                        //   width: 95,
                                        // ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              snapshot
                                                  .data.snapshot.value['Cahaya']
                                                  .toString(),
                                              // '10000',
                                              style: greenTextStyle.copyWith(
                                                fontSize: 22,
                                                fontWeight: semiBold,
                                              ),
                                            ),
                                            Text(
                                              "lux",
                                              style: greenTextStyle.copyWith(
                                                fontSize: 14,
                                                fontWeight: regular,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  width: 300,
                                  height: 170,
                                  child: LineChart(
                                      LineChartData(
                                        lineTouchData: LineTouchData(
                                          enabled: true,
                                          touchTooltipData:
                                              LineTouchTooltipData(
                                                  tooltipBgColor:
                                                      Colors.green[500],
                                                  getTooltipItems:
                                                      (List<LineBarSpot>
                                                          touchedBarSpots) {
                                                    return touchedBarSpots
                                                        .map((barSpot) {
                                                      final flSpot = barSpot;
                                                      return LineTooltipItem(
                                                        '${spotSensorList[flSpot.x.toInt()]}',
                                                        const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      );
                                                    }).toList();
                                                  }),
                                        ),
                                        gridData: FlGridData(
                                            show: false,
                                            drawHorizontalLine: false,
                                            getDrawingHorizontalLine: (value) {
                                              return FlLine(
                                                color: kGreenColor,
                                                strokeWidth: 0.1,
                                              );
                                            }),
                                        titlesData: FlTitlesData(
                                          show: true,
                                          bottomTitles: SideTitles(
                                            showTitles: true,
                                            reservedSize: 22,
                                            getTextStyles: (context, value) =>
                                                const TextStyle(
                                                    color: Color(0xff68737d),
                                                    fontSize: 12),
                                            getTitles: (value) {
                                              switch (value.toInt()) {
                                                case 0:
                                                  return '0';
                                                case 1:
                                                  return '1';
                                                case 2:
                                                  return '2';
                                                case 3:
                                                  return '3';
                                                case 4:
                                                  return '4';
                                                case 5:
                                                  return '5';
                                                case 6:
                                                  return '6';
                                                case 7:
                                                  return '7';
                                                case 8:
                                                  return '8';
                                                case 9:
                                                  return '9';
                                                case 10:
                                                  return '10';
                                                case 11:
                                                  return '11';
                                                case 12:
                                                  return '12';
                                                case 13:
                                                  return '13';
                                                case 14:
                                                  return '14';
                                                case 15:
                                                  return '15';
                                                case 16:
                                                  return '16';
                                                case 17:
                                                  return '17';
                                                case 18:
                                                  return '18';
                                                case 19:
                                                  return '19';
                                                case 20:
                                                  return '20';
                                                case 21:
                                                  return '21';
                                                case 22:
                                                  return '22';
                                                case 23:
                                                  return '23';
                                                case 24:
                                                  return '24';
                                              }
                                              return 'e';
                                            },
                                            margin: 8,
                                          ),
                                          leftTitles: SideTitles(
                                            showTitles: true,
                                            getTextStyles: (context, value) =>
                                                const TextStyle(
                                                    color: Color(0xff67727d),
                                                    fontSize: 12),
                                            getTitles: (value) {
                                              switch (value.toInt()) {
                                                case 1:
                                                  return '10k';
                                                case 3:
                                                  return '50k';
                                                case 5:
                                                  return '70k';
                                                case 7:
                                                  return '70k';
                                                case 17:
                                                  return '70k';
                                              }
                                              return '';
                                            },
                                            reservedSize: 28,
                                            margin: 3,
                                          ),
                                          rightTitles:
                                              SideTitles(showTitles: false),
                                          topTitles:
                                              SideTitles(showTitles: false),
                                        ),
                                        borderData: FlBorderData(
                                          show: false,
                                        ),
                                        minX: 0,
                                        maxX: 24,
                                        minY: 0,
                                        maxY: 6,
                                        lineBarsData: [
                                          LineChartBarData(
                                            spots: spotSensorList,
                                            // spots: [
                                            //   FlSpot(0, 3),
                                            //   FlSpot(2.6, 2),
                                            //   FlSpot(4.9, 5),
                                            //   FlSpot(6.8, 3.1),
                                            //   FlSpot(8, 4),
                                            //   FlSpot(9.5, 3),
                                            //   FlSpot(11, 4),
                                            // ],
                                            isCurved: false,
                                            colors: gradientColors,
                                            barWidth: 3,
                                            isStrokeCapRound: true,
                                            dotData: FlDotData(
                                              show: false,
                                            ),
                                            belowBarData: BarAreaData(
                                              show: true,
                                              colors: gradientColors
                                                  .map((color) =>
                                                      color.withOpacity(1))
                                                  .toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                      swapAnimationCurve: Curves.linear),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } //if
              else {
                return Container(
                  child: Text(
                    "NO DATA YET",
                    textAlign: TextAlign.center,
                  ),
                );
              }
            },
          ));
    }

    Widget downloadSheet() {
      return Container(
        margin: EdgeInsets.only(
          top: 26,
          left: 40,
          right: 40,
        ),
        width: double.infinity,
        height: 55,
        child: TextButton(
          onPressed: () {
            _launchURL();
          },
          style: TextButton.styleFrom(
            backgroundColor: kWhiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 9),
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/icon_gsheet.png',
                    ),
                  ),
                ),
              ),
              Text(
                'Download GSheets',
                style: greenTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget anotherSensor() {
      return Container(
          margin: EdgeInsets.only(left: 20),
          child: StreamBuilder(
              stream: databaseReference.child("DataSensor").onValue,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData &&
                    !snapshot.hasError &&
                    snapshot.data.snapshot.value != null) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        AnotherSensorCard(
                          sensorName: 'Salinity',
                          unit: 'ppm',
                          value: snapshot.data.snapshot.value['TDS'].toDouble(),
                          sizeBox: 25,
                          page: StatsPage(),
                        ),
                        AnotherSensorCard(
                          sensorName: 'Temp',
                          unit: '°C',
                          value:
                              snapshot.data.snapshot.value['suhuC'].toDouble(),
                          sizeBox: 25,
                          page: StatsPage(),
                        ),
                        AnotherSensorCard(
                          sensorName: 'pH',
                          unit: '',
                          value: snapshot.data.snapshot.value['pH'].toDouble(),
                          sizeBox: 25,
                          page: StatsPage(),
                        ),
                        AnotherSensorCard(
                          sensorName: 'Dissolve\nOxygen',
                          unit: 'mg/L',
                          value: snapshot.data.snapshot.value['DO'].toDouble(),
                          sizeBox: 6,
                          page: StatsPage(),
                        ),
                        AnotherSensorCard(
                          sensorName: 'Water\nLevel',
                          unit: 'cm',
                          value:
                              snapshot.data.snapshot.value['Jarak'].toDouble(),
                          sizeBox: 6,
                          page: StatsPage(),
                        ),
                      ],
                    ),
                  );
                } //if
                else {
                  return Container(
                    child: Text(
                      "NO DATA YET",
                      textAlign: TextAlign.center,
                    ),
                  );
                }
              }));
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: ListView(
          children: [
            header(),
            stackCard(),
            anotherSensor(),
            downloadSheet(),
          ],
        ),
      ),
    );
  }
}
