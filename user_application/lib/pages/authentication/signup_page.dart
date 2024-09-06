import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:user_application/pages/authentication/signin_page.dart';
import 'package:user_application/services/auth_service.dart';
import 'package:user_application/styles/colors.dart';
import 'package:user_application/styles/fonts.dart';
import 'package:user_application/widgets/back_button.dart';
import 'package:user_application/widgets/input_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
                    InputField(
                      label: "Password",
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                          text: "Do you already have an account? ",
                          style: paragraph2Style.copyWith(
                              color: Color(0xff2D3648))),
                      TextSpan(
                        text: "Sign In",
                        style: paragraph2Style.copyWith(
                            color: Colors.black,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SigninPage()),
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
          "Sign up.",
          style: heading1Style,
        ),
        Text(
          "Sign up to your account for an adventure.",
          style: paragraph1Style.copyWith(color: grayColor),
        )
      ],
    );
  }
}
