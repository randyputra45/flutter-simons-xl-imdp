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

_launchURL() async {
  const url = 'https://bit.ly/SIMONS_DataSensor';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  int activeDay = 3;

  bool showAvg = false;
  @override

//   Widget getBody() {
//     var size = MediaQuery.of(context).size;

//     List expenses = [
//       {
//         "icon": Icons.arrow_back,
//         "color": blue,
//         "label": "Income",
//         "cost": "\$6593.75"
//       },
//       {
//         "icon": Icons.arrow_forward,
//         "color": red,
//         "label": "Expense",
//         "cost": "\$2645.50"
//       }
//     ];
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Container(
//             decoration: BoxDecoration(color: white, boxShadow: [
//               BoxShadow(
//                 color: grey.withOpacity(0.01),
//                 spreadRadius: 10,
//                 blurRadius: 3,
//                 // changes position of shadow
//               ),
//             ]),
//             child: Padding(
//               padding: const EdgeInsets.only(
//                   top: 60, right: 20, left: 20, bottom: 25),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Stats",
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: black),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 25,
//                   ),
//                   Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: List.generate(months.length, (index) {
//                         return GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               activeDay = index;
//                             });
//                           },
//                           child: Container(
//                             width: (MediaQuery.of(context).size.width - 40) / 6,
//                             child: Column(
//                               children: [
//                                 Text(
//                                   months[index]['label'],
//                                   style: TextStyle(fontSize: 10),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Container(
//                                   decoration: BoxDecoration(
//                                       color: activeDay == index
//                                           ? primary
//                                           : black.withOpacity(0.02),
//                                       borderRadius: BorderRadius.circular(5),
//                                       border: Border.all(
//                                           color: activeDay == index
//                                               ? primary
//                                               : black.withOpacity(0.1))),
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 12, right: 12, top: 7, bottom: 7),
//                                     child: Text(
//                                       months[index]['day'],
//                                       style: TextStyle(
//                                           fontSize: 10,
//                                           fontWeight: FontWeight.w600,
//                                           color: activeDay == index
//                                               ? white
//                                               : black),
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         );
//                       }
//                     )
//                   )
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 20, right: 20),
//             child: Container(
//               width: double.infinity,
//               height: 250,
//               decoration: BoxDecoration(
//                   color: white,
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: grey.withOpacity(0.01),
//                       spreadRadius: 10,
//                       blurRadius: 3,
//                       // changes position of shadow
//                     ),
//                   ]),
//               child: Padding(
//                 padding: EdgeInsets.all(10),
//                 child: Stack(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         top: 10,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Net balance",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 13,
//                                 color: Color(0xff67727d)),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Text(
//                             "\$2446.90",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 25,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       child: Container(
//                         width: (size.width - 20),
//                         height: 150,
//                         child: LineChart(
//                           mainData(),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Wrap(
//               spacing: 20,
//               children: List.generate(expenses.length, (index) {
//                 return Container(
//                   width: (size.width - 60) / 2,
//                   height: 170,
//                   decoration: BoxDecoration(
//                       color: white,
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           color: grey.withOpacity(0.01),
//                           spreadRadius: 10,
//                           blurRadius: 3,
//                           // changes position of shadow
//                         ),
//                       ]),
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         left: 25, right: 25, top: 20, bottom: 20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           width: 40,
//                           height: 40,
//                           decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: expenses[index]['color']),
//                           child: Center(
//                               child: Icon(
//                             expenses[index]['icon'],
//                             color: white,
//                           )),
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               expenses[index]['label'],
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 13,
//                                   color: Color(0xff67727d)),
//                             ),
//                             SizedBox(
//                               height: 8,
//                             ),
//                             Text(
//                               expenses[index]['cost'],
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20,
//                               ),
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               }))
//         ],
//       ),
//     );
//   }
// }

  final databaseReference = FirebaseDatabase.instance.reference();

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
                // decoration: BoxDecoration(
                //   image: DecorationImage(
                //       image: AssetImage('assets/images/simons_logo2.png')),
                // ),
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
                                    mainData(),
                                  ),
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
