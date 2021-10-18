import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../shared/theme.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomCenter,
                  image: AssetImage(
                    'assets/images/alga_bg.png',
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 60,
                      bottom: 284,
                    ),
                    width: 91,
                    height: 131,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        alignment: Alignment.center,
                        image: AssetImage(
                          'assets/images/simons_logo1.png',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 55,
                    child: TextButton( 
                      onPressed: () {
                        Navigator.pushNamed(context, '/sign-in'); //berpindah ke page signup
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: kGreenOldColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        )
                      ), 
                      child: Text(
                        'Login',
                        style: whiteTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: regular,
                        )
                      )
                    )
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Container(
                    width: 150,
                    height: 55,
                    child: TextButton( 
                      onPressed: () {
                        Navigator.pushNamed(context, '/sign-up'); //berpindah ke page signup
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: kGreenColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        )
                      ), 
                      child: Text(
                        'Sign Up',
                        style: whiteTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: medium,
                        )
                      )
                    )
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}