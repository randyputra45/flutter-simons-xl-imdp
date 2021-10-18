import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simons/cubit/auth_cubit.dart';
import 'package:simons/cubit/page_cubit.dart';
import 'package:simons/ui/pages/first_page.dart';
import 'package:simons/ui/pages/main_page.dart';
import 'package:simons/ui/pages/setting_page.dart';
import 'package:simons/ui/pages/sign_in_page.dart';
import 'package:simons/ui/pages/sign_up_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:simons/ui/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PageCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: FirstPage(),
        routes: {
          //cara cepat untuk route page
          '/': (context) => SplashPage(),
          '/first-page': (context) => FirstPage(),
          '/sign-up': (context) => SignUpPage(),
          '/sign-in': (context) => SignInPage(),
          '/main': (context) => MainPage(),
          '/setting': (context) => SettingPage(),
          //   '/sign-up': (context) => SignUpPage(),
          //   '/bonus': (context) => BonusPage(),
          //   '/main': (context) => MainPage(),
        },
      ),
    );
  }
}
