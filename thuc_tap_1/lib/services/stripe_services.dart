// import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:thuc_tap_1/consts.dart';
import 'package:thuc_tap_1/models/food_model.dart';

class StripeServices {
  StripeServices._();
  static final StripeServices instance = StripeServices._();
  
  double get totalPrice {
    double total = 0.0;
    for (FoodModel food in foods) {
      total = total + food.total;
    }
    return total;
  }

  Future<void> makePayment() async {
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent(
        10,
        "usd",
      );
      if (paymentIntentClientSecret == null) return;
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentClientSecret,
            merchantDisplayName: " Song Tan "),
      );
      await _processPayment();
    } catch (e) {
      print(e);
    }
  }

  // roi ay bro. tim hiu chut la oke. cai nay cung de ay . a oi lam sao de dung gia tien nhi

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        // cai nay la gia tien . don vi tien te ne 
        //  "amount": _calculateAmount(amount),
        //    "currency": currency,
        // oke chua bro da. roi a . de e tim hieu them a.
       
      'amount': ('totalPrice'),
        'currency': '\$'
      };
      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": " Bearer $stripeSecretKey",
            "Content-Type": 'application/x-www-form-urlencoded'
          },
        ),
      );
      if (response.data != null) {
        return response.data["client_secret"];
      }
      return null;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      print(e);
    }
  }

  
}
