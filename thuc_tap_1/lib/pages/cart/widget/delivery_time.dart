import 'package:flutter/material.dart';
import '../../../components/app_box_shadow.dart';
import '../../../components/button/app_elevated_button.dart';
import '../../payment/payment_page.dart';

class DeliveryTime extends StatelessWidget {
  const DeliveryTime({
    super.key,
    this.minute,
    required this.totalPrice,
  });

  final int? minute;
  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: AppBoxShadow.boxShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Text(
                'Delivery Time',
                style: TextStyle(color: Colors.red, fontSize: 16.0),
              ),
              const Spacer(),
              Image.asset('assets/images/time_icon.png', width: 20.0),
              Text(
                ' ${minute ?? '-:-'} mins',
                style: const TextStyle(
                    color: Colors.brown, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Total Price',
            style: TextStyle(color: Colors.brown, fontSize: 16.0),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 14.0),
          Row(
            children: [
              const Text(
                '\$ ',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                totalPrice.toStringAsFixed(2),
                style: const TextStyle(color: Colors.brown, fontSize: 24.0),
              ),
              const Spacer(),
              AppElevatedButton.small(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PaymentPage(),
                  ),
                ),
                height: 40.0,
                text: 'Place Order',
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
