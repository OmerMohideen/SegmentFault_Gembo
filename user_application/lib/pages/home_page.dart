import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:user_application/pages/visa/eligibility_criteria_page.dart';
import 'package:user_application/pages/visa/status_page.dart';
import 'package:user_application/pages/welcome_page.dart';
import 'package:user_application/styles/colors.dart';
import 'package:user_application/widgets/Button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> _checkIfUserApplied(String userId) async {
    final querySnapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('visa_applications')
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text('No user is logged in. Please log in first.'),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 50, left: 24, right: 24),
        child: FutureBuilder<bool>(
          future: _checkIfUserApplied(user.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(
                  child: Text('Error checking visa application status'));
            }

            bool hasApplied = snapshot.data ?? false;

            return Column(
              children: [
                hasApplied
                    ? Button(
                        text: "Visa Status",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StatusPage(),
                            ),
                          );
                        },
                      )
                    : Button(
                        text: "Apply for Visa",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EligibilityCriteriaPage(),
                            ),
                          );
                        },
                      ),
                const SizedBox(height: 35),
                Button(
                  text: "Sign out",
                  secondary: true,
                  onTap: () async {
                    await GoogleSignIn().signOut();
                    await FirebaseAuth.instance.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WelcomePage(),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
