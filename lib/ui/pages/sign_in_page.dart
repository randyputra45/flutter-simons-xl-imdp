import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simons/cubit/auth_cubit.dart';
import 'package:simons/ui/widgets/custom_button.dart';
import 'package:simons/ui/widgets/text_form_field.dart';
import '../../shared/theme.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

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
          'Hello 👋\nLogin to continue',
          style: blackTextStyle.copyWith(
            fontSize: 24,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget inputSection() {
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
              title: 'Login',
              onPressed: () {
                context.read<AuthCubit>().signIn(
                      email: emailController.text,
                      password: passwordController.text,
                    );
              },
            );
          },
        );
      }

      Widget tacButton() {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/sign-up');
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              top: 50,
              bottom: 73,
            ),
            child: Text(
              'Don\'t have an account? Sign Up',
              style: greyTextStyle.copyWith(
                fontSize: 16,
                fontWeight: light,
                decoration: TextDecoration.underline,
              ),
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
            emailInput(),
            passwordInput(),
            submitButton(),
            tacButton(),
          ],
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
            ]),
      ),
    );
  }
}
