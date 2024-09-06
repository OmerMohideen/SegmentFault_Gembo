import 'package:flutter/material.dart';
import 'package:user_application/pages/home_page.dart';
import 'package:user_application/pages/visa/eligibility_criteria_page.dart';
import 'package:user_application/styles/fonts.dart';
import 'package:user_application/widgets/Button.dart';

class SubmissionFailedPage extends StatefulWidget {
  const SubmissionFailedPage({super.key});

  @override
  State<SubmissionFailedPage> createState() => _SubmissionFailedPageState();
}

class _SubmissionFailedPageState extends State<SubmissionFailedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/sad_mascot.png"),
                    const SizedBox(height: 35),
                    Text(
                      "Application Failed",
                      style: heading1Style,
                    )
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Button(
                  text: "Try again",
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EligibilityCriteriaPage(),
                      ),
                    )
                  },
                ),
                SizedBox(height: 20),
                Button(
                  text: "Go to homepage",
                  secondary: true,
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    )
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
