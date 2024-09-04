import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:user_application/pages/visa/eligibility_criteria_page.dart';
import 'package:user_application/utils/form_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? "";

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
    return const EligibilityCriteriaPage();
  }
}
