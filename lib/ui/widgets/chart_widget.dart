import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:simons/shared/theme.dart';
import 'dart:developer';

List<Color> gradientColors = [kGreenColor];
List<double> dataSensorList = [];
List<FlSpot> spotSensorList = [];
List<FlSpot> removedSensorList = [];
final dbRef = FirebaseDatabase.instance.reference();
double data = 0.0;

Future<void> readData() async {
  dbRef.child("Test").once().then((DataSnapshot snapshot) {
    data = snapshot.value['Sensor'].toDouble();
    dataSensorList.add(data);
  });
}

List<FlSpot> gatherSensorData() {
  log('gatherSensorData');
  oneHourTimer();
  for (int i = 0; i < dataSensorList.length; i++) {
    spotSensorList.add(FlSpot((i * 1.0), dataSensorList[i]));
    if (dataSensorList.length >= 11) {
      spotSensorList = [];
      dataSensorList = [];
    }
  }
  // log('data: $dataSensorList');
  return spotSensorList;
}

bool isStopped = false; //global

oneHourTimer() {
  Timer.periodic(Duration(minutes: 1), (Timer t) {
    log('print timer');
    if (isStopped) {
      t.cancel();
    }
    readData();
  });
}

LineChartData mainData() {
  return LineChartData(
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
            const TextStyle(color: Color(0xff68737d), fontSize: 12),
        getTitles: (value) {
          switch (value.toInt()) {
            case 2:
              return '1';
            case 5:
              return '11';
            case 8:
              return '21';
          }
          return '';
        },
        margin: 8,
      ),
      leftTitles: SideTitles(
        showTitles: true,
        getTextStyles: (context, value) =>
            const TextStyle(color: Color(0xff67727d), fontSize: 12),
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
      rightTitles: SideTitles(showTitles: false),
      topTitles: SideTitles(showTitles: false),
    ),
    borderData: FlBorderData(
      show: false,
    ),
    minX: 0,
    maxX: 11,
    minY: 0,
    maxY: 6,
    lineBarsData: [
      LineChartBarData(
        spots: gatherSensorData(),
        // spots: [
        //   FlSpot(0, 3),
        //   FlSpot(2.6, 2),
        //   FlSpot(4.9, 5),
        //   FlSpot(6.8, 3.1),
        //   FlSpot(8, 4),
        //   FlSpot(9.5, 3),
        //   FlSpot(11, 4),
        // ],
        isCurved: true,
        colors: gradientColors,
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          colors: gradientColors.map((color) => color.withOpacity(1)).toList(),
        ),
      ),
    ],
  );
}
