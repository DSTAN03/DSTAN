import 'package:flutter/material.dart';
import 'package:thuc_tap_1/components/app_bar/td_app_bar.dart';
// import 'package:thuc_tap_1/pages/cart/cart_page_2.dart';
// import 'package:thuc_tap_1/pages/payment/payment_last_page.dart';
import 'package:thuc_tap_1/services/stripe_services.dart';
import '../../components/app_box_shadow.dart';
import '../../components/button/app_elevated_button.dart';
import '../../consts.dart';
import '../../gen/assets.gen.dart';
import '../../models/payment_method_model.dart';
import '../../services/local/shared_prefs.dart';
import '../profile/profile_page.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({super.key});

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TdAppBar(
        leftPressed: () => Navigator.of(context).pop(),
        title: 'Payment Method',
        rightPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ProfilePage(),
        )),
        avatar:
            '${AppConstant.endPointBaseImage}/${SharedPrefs.user?.avatar ?? ''}',
      ),
      body: Stack(
        children: [
          Positioned(
            left: 0.0,
            top: 0.0,
            right: 0.0,
            bottom: 114.0,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20.0)
                  .copyWith(top: 30.0, bottom: 20.0),
              itemBuilder: (context, index) {
                final paymentMethod = paymentMethods[index];
                return _paymentMethodItem(
                  paymentMethod,
                  onTap: () {
                    for (var element in paymentMethods) {
                      element.isSelected = false;
                    }
                    paymentMethod.isSelected = true;
                    setState(() {});
                  },
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 20.0),
              itemCount: paymentMethods.length,
            ),
          ),
          Positioned(
            left: 20.0,
            right: 20.0,
            bottom: 60.0,
            child: AppElevatedButton(
              onPressed: () => {StripeServices.instance.makePayment()},
              text: 'Purchase',
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentMethodItem(PaymentMethodModel paymentMethod,
      {Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0)
            .copyWith(left: 16.0, right: 14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: AppBoxShadow.boxShadow,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                paymentMethod.name ?? '-:-',
                style: const TextStyle(fontSize: 16.0),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
              ),
            ),
            Image.asset(
              paymentMethod.isSelected == true
                  ? Assets.images.radioButtonOn.path
                  : Assets.images.radioButtonOff.path,
              width: 18.6,
            ),
          ],
        ),
      ),
    );
  }
}
