import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:simons/shared/theme.dart';
import 'package:simons/ui/pages/stats_page.dart';
import 'package:simons/ui/widgets/display_sensor_card.dart';
import 'aerator_control.dart';

class Dashboard extends StatefulWidget {
  // const Dashboard({ Key? key }) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    // Query lastQuery  = databaseReference.child("SensorDatabase").orderByKey().limitToLast(1);

    Widget header() {
      return Container(
          margin: EdgeInsets.only(
            left: 40,
            top: 40,
            bottom: 5,
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
                      'Welcome to\nSIMONS!',
                      style: blackTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: semiBold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 6,
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
      return Container(
          margin: EdgeInsets.only(
            left: 40,
            bottom: 40,
          ),
          child: StreamBuilder(
            stream: databaseReference.child("DataSensor").onValue,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData &&
                  !snapshot.hasError &&
                  snapshot.data.snapshot.value != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data.snapshot.value['DateAndTime'].toString(),
                      style: greyTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                    Row(
                      children: [
                        SensorCard(
                          sensorName: 'Light\nIntensity',
                          unit: 'lux',
                          value:
                              snapshot.data.snapshot.value['Cahaya'].toDouble(),
                          iconUrl: 'assets/images/icon_light.png',
                          sizeBox: 3,
                          page: StatsPage(),
                        ),
                        SensorCard(
                          sensorName: 'Salinity',
                          unit: 'ppm',
                          iconUrl: 'assets/images/icon_salinity.png',
                          value: snapshot.data.snapshot.value['TDS'].toDouble(),
                          // value: newSensor['_TDS'].toDouble(),
                          page: StatsPage(),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SensorCard(
                          sensorName: 'Temperature',
                          unit: '°C',
                          value:
                              snapshot.data.snapshot.value['suhuC'].toDouble(),
                          // value: newSensor['_suhuC'].toDouble(),
                          iconUrl: 'assets/images/icon_temp.png',
                          page: StatsPage(),
                        ),
                        SensorCard(
                          sensorName: 'pH',
                          unit: '',
                          value: snapshot.data.snapshot.value['pH'].toDouble(),
                          // value: newSensor['_pH'].toDouble(),
                          iconUrl: 'assets/images/icon_ph.png',
                          page: StatsPage(),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SensorCard(
                          sensorName: 'Dissolve\nOxygen',
                          unit: 'mg/L',
                          value: snapshot.data.snapshot.value['DO'].toDouble(),
                          iconUrl: 'assets/images/icon_o2.png',
                          sizeBox: 3,
                          page: StatsPage(),
                        ),
                        SensorCard(
                          sensorName: 'Water\nLevel',
                          unit: 'cm',
                          value:
                              snapshot.data.snapshot.value['Jarak'].toDouble(),
                          // value: newSensor['_Jarak'].toDouble(),
                          iconUrl: 'assets/images/icon_water.png',
                          sizeBox: 3,
                          page: AeratorControlPage(),
                        ),
                      ],
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

    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: ListView(
          children: [
            header(),
            stackCard(),
          ],
        ),
      ),
    );
  }
}
