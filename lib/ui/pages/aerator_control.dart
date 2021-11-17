import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:simons/my_flutter_app_icons.dart';
import 'package:simons/shared/theme.dart';
import 'dart:async';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AeratorControlPage extends StatefulWidget {
  const AeratorControlPage({Key? key}) : super(key: key);

  _AeratorControlPageState createState() => _AeratorControlPageState();
}

class _AeratorControlPageState extends State<AeratorControlPage>
    with SingleTickerProviderStateMixin {
  final dbRef = FirebaseDatabase.instance.reference();
  bool value = true;
  String status = '';
  int hitung = 0;
  Color color = Colors.grey;
  bool _buttonVisibility = true;
  bool isEnabled = true;
  late DateTime lastClicked;

  eventUpdate() {
    setState(() {
      value = !value;
    });
  }

  sampleFunction() {
    if (isEnabled == false) {
      return 'wait';
    }
    // else
    //   return status;
    else if (value == true)
      return 'on';
    else
      return 'off';
    // value = !value;
    // new Timer(Duration(seconds: 15), () => setState(() => value = !value));
  }

  Future<void> writeEsp() async {
    dbRef.child("Control2").update({"switch": value ? 'ON' : 'OFF'});
  }

  Future<void> readData() async {
    dbRef.child("Control2").once().then((DataSnapshot snapshot) {
      value = snapshot.value['switch'];
    });
  }

  // readEsp() async {
  //   dbRef.child("AeratorControl2").once().then((DataSnapshot snapshot) {
  //     var esp32 = snapshot.value['esp32'];
  //     return esp32;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    readData();
    Widget header() {
      return Container(
          margin: EdgeInsets.only(
            left: 40,
            top: 40,
            bottom: 20,
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
                      'Aerator\nControl',
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
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/simons_logo2.png')),
                ),
                alignment: Alignment.topRight,
              ),
            ],
          ));
    }

    Widget background() {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            alignment: Alignment.bottomCenter,
            image: AssetImage(
              'assets/images/water_bg4.png',
            ),
          ),
        ),
      );
    }

    Widget button() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: StreamBuilder(
            stream: dbRef.child("Control2").onValue,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData &&
                  !snapshot.hasError &&
                  snapshot.data.snapshot.value != null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: _buttonVisibility,
                      child: RawMaterialButton(
                          onPressed: () async {
                            // This is what you should add in your code
                            if (isEnabled) {
                              eventUpdate();
                              writeEsp();
                              isEnabled = false;
                              new Timer(
                                  Duration(seconds: 15),
                                  () => {
                                        setState(() => isEnabled = true),
                                      });
                            }
                          },
                          // onPressed: () => sampleFunction(),
                          // onPressed: isEnabled ? () => sampleFunction() : null,
                          // onPressed: () {
                          //   writeEsp();
                          //   eventUpdate();
                          // },
                          // onPressed: () {
                          //   dbRef
                          //       .child("AeratorControl2")
                          //       .child("esp32")
                          //       .set(!value);
                          //   eventUpdate();
                          // },
                          elevation: 7.0,
                          fillColor:
                              snapshot.data.snapshot.value['switch'] == 'ON'
                                  ? kGreen2Color
                                  : kWhiteColor,
                          child: Column(
                            children: [
                              Icon(
                                MyFlutterApp.drop,
                                size: 60,
                                color: snapshot.data.snapshot.value['switch'] == 'ON'
                                    ? kWhiteColor
                                    : kGreen2Color,
                              ),
                              Text(
                                isEnabled
                                    ? snapshot.data.snapshot.value['switch']
                                    : 'wait',
                                // sampleFunction(),
                                style: snapshot.data.snapshot.value['switch'] == 'ON'
                                    ? whiteTextStyle.copyWith(
                                        fontSize: 18,
                                        fontWeight: regular,
                                      )
                                    : greenTextStyle.copyWith(
                                        fontSize: 18,
                                        fontWeight: regular,
                                      ),
                              )
                            ],
                          ),
                          padding: EdgeInsets.all(20),
                          shape: CircleBorder(),
                          textStyle: TextStyle(
                            fontSize: 18,
                          )),
                    )
                  ],
                );
              } //if
              else {
                return Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 127),
                    // child: Text("NO DATA YET"),
                  ),
                );
              }
            }),
      );
    }

    Widget waterLevel() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(top: 90, bottom: 50),
          child: StreamBuilder(
              stream: dbRef.child("DataSensor").onValue,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData &&
                    !snapshot.hasError &&
                    snapshot.data.snapshot.value != null) {
                  return Column(
                    children: [
                      Text(
                        snapshot.data.snapshot.value['DO'].toStringAsFixed(1),
                        style: whiteTextStyle.copyWith(
                          fontSize: 96,
                          fontWeight: medium,
                        ),
                      ),
                      Text(
                        'Dissolve Oxygen',
                        textAlign: TextAlign.center,
                        style: whiteTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: extraBold,
                        ),
                      ),
                      Text(
                        'mg/L',
                        textAlign: TextAlign.center,
                        style: whiteTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: regular,
                        ),
                      ),
                    ],
                  );
                } //if
                else {
                  return Container(
                    child: Text("Loading"),
                  );
                }
              }),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Stack(
          children: [
            background(),
            Column(
              children: [
                header(),
                button(),
                waterLevel(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
