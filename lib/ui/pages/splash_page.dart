import 'dart:async';
import 'package:flutter/material.dart';
import 'package:simons/cubit/auth_cubit.dart';
import '../../shared/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class SplashPage extends StatelessWidget {
//   const SplashPage({ Key? key }) : super(key: key);
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/first-page', (route) => false);
      } else {
        print(user.email);
        context.read<AuthCubit>().getCurrentUser(user.uid);
        Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 144,
              height: 195,
              // margin: EdgeInsets.only(bottom: 40),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                'assets/images/simons_logo3.png',
              )))),
        ],
      )),
    );
  }
}
