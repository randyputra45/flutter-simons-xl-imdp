import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simons/cubit/page_cubit.dart';
import 'package:simons/ui/pages/stats_page.dart';
import 'package:simons/ui/widgets/navigation_button.dart';
import '../../shared/theme.dart';
import 'aerator_control.dart';
import 'dashboard_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildContent(int currentIndex) {
      switch (currentIndex) {
        case 0:
          return Dashboard();
        case 1:
          return StatsPage();
        case 2:
          return AeratorControlPage();
        default:
          return Dashboard();
      }
    }

    Widget customBottomNavigation() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.only(top: 10, left: 22, right: 22),
          width: 280,
          height: 50,
          margin: EdgeInsets.only(bottom: 13, left: 16, right: 16),
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButtomNavigation(
                imageUrl: 'assets/images/icon_dashboard.png',
                index: 0,
              ),
              CustomButtomNavigation(
                imageUrl: 'assets/images/icon_graph.png',
                index: 1,
              ),
              CustomButtomNavigation(
                imageUrl: 'assets/images/icon_bubble.png',
                index: 2,
              )
            ],
          ),
        ),
      );
    }

    return BlocBuilder<PageCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          backgroundColor: kBackgroundColor,
          body: Stack(
            children: [
              buildContent(currentIndex),
              customBottomNavigation(),
            ],
          ),
        );
      },
    );
  }
}
