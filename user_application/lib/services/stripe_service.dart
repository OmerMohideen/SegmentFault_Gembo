import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:user_application/pages/visa/failed_page.dart';
import 'package:user_application/pages/visa/success_page.dart';
import 'package:user_application/services/database_service.dart';
import 'package:user_application/utils/form_handler.dart';

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<void> makePayment(
      BuildContext context, FormHandler formHandler) async {
    try {
      String? clientSecret = await _createPaymentIntent(10000, "lkr");
      if (clientSecret == null) return;
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: clientSecret,
              merchantDisplayName: "Gembo"));
      await Stripe.instance.presentPaymentSheet();

      _storeData(formHandler);

      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => new SubmissionSuccessPage()),
      );
    } catch (e) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => new SubmissionFailedPage()),
      );
    }
  }

  Future<void> _storeData(FormHandler formHandler) async {
    try {
      DatabaseService databaseService = DatabaseService();
      var userId = FirebaseAuth.instance.currentUser?.uid;
      await databaseService.saveFormData(formHandler, userId!);
    } catch (e) {
      print(e);
    }
  }

  // very bad approach
  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": (amount * 100).toString(),
        "currency": currency
      };
      Response response = await dio.post(
          "https://api.stripe.com/v1/payment_intents",
          data: data,
          options:
              Options(contentType: Headers.formUrlEncodedContentType, headers: {
            "Authorization": "Bearer ${dotenv.env['STRIPE_SECRET_KEY']}",
            "Content-Type": "application/x-www-form-urlencoded",
          }));
      if (response.data != null) {
        return response.data["client_secret"];
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
