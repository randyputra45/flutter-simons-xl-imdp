import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simons/cubit/auth_cubit.dart';
import 'package:simons/ui/widgets/custom_button.dart';
import 'package:simons/ui/widgets/text_form_field.dart';
import '../../shared/theme.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Container(
        margin: EdgeInsets.only(
          top: 42,
          left: 20,
        ),
        child: Text(
          'Hello 👋\nSign up to continue',
          style: blackTextStyle.copyWith(
            fontSize: 24,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget inputSection() {
      Widget nameInput() {
        return CustomTextFormField(
          title: 'Full Name',
          hintText: 'Your full name',
          controller: nameController,
        );
      }

      Widget emailInput() {
        return CustomTextFormField(
          title: 'Email Address',
          hintText: 'Your email address',
          controller: emailController,
        );
      }

      Widget passwordInput() {
        return CustomTextFormField(
          title: 'Password',
          hintText: 'Your password',
          obscureText: true,
          controller: passwordController,
        );
      }

      Widget submitButton() {
        return BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/main', (route) => false);
            } else if (state is AuthFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: kRedColor,
                  content: Text(state.error),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return CustomButton(
              title: 'Get Started',
              onPressed: () {
                context.read<AuthCubit>().signUp(
                      email: emailController.text,
                      password: passwordController.text,
                      name: nameController.text,
                    );
              },
            );
          },
        );
      }

      Widget signUpGoogle() {
        return Container(
          margin: EdgeInsets.only(
            top: 26,
          ),
          width: double.infinity,
          height: 55,
          child: TextButton(
            onPressed: () {
              // Navigator.pushNamed(context, '/');
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
                        'assets/images/icon_google.png',
                      ),
                    ),
                  ),
                ),
                Text(
                  'Continue with Google',
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: regular,
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return Container(
        margin: EdgeInsets.only(top: 30),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(
            defaultRadius,
          ),
        ),
        child: Column(
          children: [
            nameInput(),
            emailInput(),
            passwordInput(),
            submitButton(),
          ],
        ),
      );
    }

    Widget signInButton() {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/sign-in');
        },
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(
            top: 50,
            bottom: 73,
          ),
          child: Text(
            'Have an account? Login',
            style: greyTextStyle.copyWith(
              fontSize: 16,
              fontWeight: light,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            children: [
              title(),
              inputSection(),
              signInButton(),
            ]),
      ),
    );
  }
}
