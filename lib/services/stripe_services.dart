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
      total += food.total;
    }
    return total;
  }

  Future<void> makePayment() async {
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent(
        totalPrice,
        "usd",
      );
      if (paymentIntentClientSecret == null) return;

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: "Song Tan",
        ),
      );

      await _processPayment();
    } catch (e) {
      print("Lỗi thanh toán: $e");
    }
  }

  Future<String?> _createPaymentIntent(double amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        'amount': _calculateAmount(amount),
        'currency': currency,
      };

      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": "application/x-www-form-urlencoded"
          },
        ),
      );

      if (response.data != null) {
        return response.data["client_secret"];
      }
      return null;
    } catch (e) {
      if (e is DioException) {
        print("Lỗi API Stripe: ${e.response?.data}");
      } else {
        print("Lỗi không xác định: $e");
      }
    }
    return null;
  }

  int _calculateAmount(double amount) {
    return (amount * 100).toInt(); // Chuyển đổi sang cents
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      print("Lỗi xử lý thanh toán: $e");
    }
  }
}
