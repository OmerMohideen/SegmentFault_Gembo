import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:user_application/pages/visa/eligibility_criteria_page.dart';
import 'package:user_application/styles/fonts.dart';
import 'package:user_application/widgets/Button.dart';

class SubmissionSuccessPage extends StatefulWidget {
  const SubmissionSuccessPage({super.key});

  @override
  State<SubmissionSuccessPage> createState() => _SubmissionSuccessPageState();
}

class _SubmissionSuccessPageState extends State<SubmissionSuccessPage> {

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
                    Image.asset("assets/images/happy_mascot.png"),
                    const SizedBox(height: 35),
                    Text("Application Submitted", style: heading1Style, textAlign: TextAlign.center),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0), // Add some padding for the text
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: paragraph2Style, // Apply the default paragraph style
                          children: [
                            TextSpan(
                              text: "Your submission will undergo manual verification, which may take 12 to 24 hours. You can track the status on your ",
                              style: paragraph1Style.copyWith(color: Color(0xff2D3648))
                            ),
                            TextSpan(
                              text: "status page",
                              style: paragraph1Style.copyWith(color: Color(0xff5DB075), decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Add functionality to navigate to status page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => EligibilityCriteriaPage()),
                                  );
                                },
                            ),
                      ],
                    ),
      ),
                    ),
                          ],
                ),
              ),
            ),
            Column(
              children: [
                Button(
                  text: "Go to homepage",
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EligibilityCriteriaPage(),
                      ),
                    )
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}