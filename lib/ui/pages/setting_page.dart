import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simons/cubit/auth_cubit.dart';
import 'package:simons/cubit/page_cubit.dart';
import 'package:simons/shared/theme.dart';
import 'package:simons/ui/widgets/custom_button.dart';
import 'package:simons/ui/widgets/custom_button2.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  get kPrimaryColor => null;

  @override
  Widget build(BuildContext context) {
    Widget bonusCard() {
      return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return Container(
              width: 300,
              height: 178,
              margin: EdgeInsets.only(
                top: 40,
              ),
              padding: EdgeInsets.only(
                left: 30,
                right: 30,
                top: 18,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/image_card.png',
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: kGreenColor.withOpacity(0.5),
                    blurRadius: 50,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name',
                              style: whiteTextStyle.copyWith(
                                fontWeight: light,
                              ),
                            ),
                            Text(
                              state.user.name,
                              style: whiteTextStyle.copyWith(
                                fontSize: 20,
                                fontWeight: bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   width: 24,
                      //   height: 24,
                      //   margin: EdgeInsets.only(right: 6),
                      //   decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //       image: AssetImage(
                      //         'assets/icon_plane.png',
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Text(
                        'SIMONS',
                        style: whiteTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: medium,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Text(
                    'Email',
                    style: whiteTextStyle.copyWith(
                      fontWeight: light,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    state.user.email,
                    style: whiteTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          } else {
            return SizedBox();
          }
        },
      );
    }

    Widget title() {
      return Container(
        margin: EdgeInsets.only(top: 200),
        child: Text(
          'Your Profile 🎉',
          style: blackTextStyle.copyWith(
            fontSize: 32,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget subtitle() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Text(
          'Made with ❤️\nby XLFL x IMDP',
          style: blackTextStyle.copyWith(
            fontSize: 16,
            fontWeight: light,
          ),
        ),
      );
    }

    Widget signOutButton() {
      return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: kRedColor,
                content: Text(state.error),
              ),
            );
          } else if (state is AuthInitial) {
            context.read<PageCubit>().setPage(0);
            Navigator.pushNamedAndRemoveUntil(
                context, '/first-page', (route) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: Container(
              margin: EdgeInsets.only(top: 80),
              child: CustomButton2(
                title: 'Sign Out',
                onPressed: () {
                  context.read<AuthCubit>().signOut();
                },
                width: 150,
              ),
            ),
          );
        },
      );
    }

    return Center(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Center(
            child: Column(
          children: [
            title(),
            bonusCard(),
            signOutButton(),
            subtitle(),
          ],
        )),
      ),
    );
  }
}
