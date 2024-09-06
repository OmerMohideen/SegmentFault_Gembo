import 'package:flutter/material.dart';
import 'package:user_application/pages/authentication/signin_page.dart';
import 'package:user_application/pages/authentication/signup_page.dart';
import 'package:user_application/styles/fonts.dart';
import 'package:user_application/widgets/back_button.dart';
import 'package:user_application/widgets/button.dart';
import 'package:user_application/widgets/radio_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool yes = true, no = false;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _head(),
                    const SizedBox(height: 35),
                    RadioButton(
                      label: "Yes, I have an account",
                      selected: yes,
                      onChanged: (value) {
                        setState(() {
                          yes = true;
                          no = false;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    RadioButton(
                      label: "No, I do not have an account",
                      selected: no,
                      onChanged: (value) {
                        setState(() {
                          yes = false;
                          no = true;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Button(
              text: "Continue",
              secondary: true,
              onTap: () => {
                if (yes)
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SigninPage(),
                      ),
                    )
                  }
                else
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupPage(),
                      ),
                    )
                  }
              },
            ),
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
          "Do you already",
          style: heading1Style,
        ),
        Text(
          "have an account?",
          style: heading1Style,
        )
      ],
    );
  }
}
