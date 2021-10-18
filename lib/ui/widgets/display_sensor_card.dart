import 'package:flutter/material.dart';
import 'package:simons/shared/theme.dart';

class SensorCard extends StatelessWidget {
  final String sensorName;
  final String unit;
  final String iconUrl;
  final double value;
  final double sizeBox;
  final Widget page;

  const SensorCard({
    Key? key,
    required this.sensorName,
    this.unit = ' ',
    required this.iconUrl,
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
        width: 130,
        height: 145,
        margin: EdgeInsets.only(
          top: 20,
          right: 20,
        ),
        padding: EdgeInsets.all(17),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kGreenColor,
            boxShadow: [
              BoxShadow(
                color: kGreenColor.withOpacity(0.5),
                blurRadius: 7,
                offset: Offset(3, 5),
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sensorName,
              style: whiteTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: sizeBox,
            ),
            Text(
              value.toStringAsFixed(1),
              style: whiteTextStyle.copyWith(
                fontWeight: bold,
                fontSize: 28,
              ),
            ),
            SizedBox(
              height: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  unit,
                  style: whiteTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                  ),
                ),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        iconUrl,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
