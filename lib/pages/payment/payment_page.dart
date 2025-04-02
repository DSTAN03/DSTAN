import 'package:flutter/material.dart';
import '../../components/app_bar/foodie_app_bar.dart';
import '../../components/app_box_shadow.dart';
import 'address_page.dart';
import 'payment_method_page.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FoodieAppBar(
        iconPressed: () => Navigator.of(context).pop(),
        title: 'Payment',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0)
            .copyWith(top: 40.0, bottom: 20.0),
        child: Column(
          children: [
            _paymentItem(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddressPage())),
                text: 'Choose Address'),
            const SizedBox(height: 22.0),
            _paymentItem(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PaymentMethodPage())),
                text: 'Payment Method'),
          ],
        ),
      ),
    );
  }

  Widget _paymentItem({Function()? onTap, required String text}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14.6)
            .copyWith(left: 18.0, right: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: AppBoxShadow.boxShadow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: const TextStyle(fontSize: 16.0)),
            const Icon(Icons.navigate_next, size: 32.0),
          ],
        ),
      ),
    );
  }
}
