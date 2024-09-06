import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:user_application/firebase_options.dart';
import 'package:user_application/pages/home_page.dart';
import 'package:user_application/pages/visa/eligibility_criteria_page.dart';
import 'package:user_application/pages/welcome_page.dart';
import 'package:user_application/utils/form_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? "";

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(ChangeNotifierProvider(
      create: (_) => FormHandler(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      )));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data == null) {
            return WelcomePage();
          } else {
            return HomePage();
          }
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
