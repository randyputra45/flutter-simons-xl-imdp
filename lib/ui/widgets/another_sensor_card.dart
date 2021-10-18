import 'package:flutter/material.dart';
import 'package:simons/shared/theme.dart';

class AnotherSensorCard extends StatelessWidget {
  final String sensorName;
  final String unit;
  final double value;
  final double sizeBox;
  final Widget page;

  const AnotherSensorCard({
    Key? key,
    required this.sensorName,
    this.unit = ' ',
    required this.value,
    this.sizeBox = 26,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        width: 97,
        height: 130,
        margin: EdgeInsets.only(
          top: 14,
          right: 14,
        ),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kWhiteColor,
            boxShadow: [
              BoxShadow(
                color: kGreen3Color.withOpacity(1),
                blurRadius: 7,
                offset: Offset(3, 5),
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sensorName,
              style: greenTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 13,
              ),
            ),
            SizedBox(
              height: sizeBox,
            ),
            Text(
              value.toStringAsFixed(1),
              style: greenTextStyle.copyWith(
                fontWeight: bold,
                fontSize: 24,
              ),
            ),
            SizedBox(
              height: 1,
            ),
            Text(
              unit,
              style: greenTextStyle.copyWith(
                fontWeight: medium,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
