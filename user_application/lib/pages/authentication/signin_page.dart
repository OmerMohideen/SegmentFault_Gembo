import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:user_application/pages/authentication/signup_page.dart';
import 'package:user_application/services/auth_service.dart';
import 'package:user_application/styles/colors.dart';
import 'package:user_application/styles/fonts.dart';
import 'package:user_application/widgets/Button.dart';
import 'package:user_application/widgets/back_button.dart';
import 'package:user_application/widgets/input_field.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _head(),
                    const SizedBox(height: 35),
                    InputField(label: "Email address"),
                    const SizedBox(height: 30),
                    InputField(
                      label: "Password",
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 30),
                    Container(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        child: Text(
                          "Reset Password",
                          style: paragraph2Style.copyWith(
                              color: Color(0xff2D3648),
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Button(text: "Sign In")
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Color(0xffD9D9D9),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'or',
                      style: paragraph2Style.copyWith(color: Color(0xff4C4E55)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Color(0xffD9D9D9),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 35),
                GestureDetector(
                  child: Container(
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xffF0F0F0),
                        borderRadius: BorderRadius.circular(12)),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/icons/facebook_icon.svg"),
                        const SizedBox(width: 12),
                        Text("Continue With Facebook", style: paragraph2Style)
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () => {AuthService.signInWithGoogle(context)},
                  child: Container(
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xffF0F0F0),
                        borderRadius: BorderRadius.circular(12)),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/icons/google_icon.svg"),
                        const SizedBox(width: 12),
                        Text("Continue With Google", style: paragraph2Style)
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: paragraph2Style,
                    children: [
                      TextSpan(
                          text: "Do not have an account? ",
                          style: paragraph2Style.copyWith(
                              color: Color(0xff2D3648))),
                      TextSpan(
                        text: "Sign Up",
                        style: paragraph2Style.copyWith(
                            color: Colors.black,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupPage()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Column _head() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DripBackButton(
          onTap: () => {
            if (Navigator.canPop(context)) {Navigator.pop(context)}
          },
        ),
        const SizedBox(height: 35),
        Text(
          "Sign in.",
          style: heading1Style,
        ),
        Text(
          "Sign in to your account for an adventure.",
          style: paragraph1Style.copyWith(color: grayColor),
        )
      ],
    );
  }
}
