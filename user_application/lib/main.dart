import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_application/pages/visa/eligibility_criteria_page.dart';
import 'package:user_application/utils/form_handler.dart';

void main() {
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
