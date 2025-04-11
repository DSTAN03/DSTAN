import 'package:flutter/material.dart';
import 'package:thuc_tap_1/components/app_bar/td_app_bar.dart';
import 'package:thuc_tap_1/pages/payment/payment_page.dart';
import '../../components/button/app_elevated_button.dart';
import '../../consts.dart';
import '../../models/address_model.dart';
// import '../cart/cart_page.dart';
import '../../services/local/shared_prefs.dart';
import '../profile/profile_page.dart';
import 'widget/address_item.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({
    super.key,
  });

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TdAppBar(
        leftPressed: () => Navigator.of(context).pop(),
        title: 'Choose Address',
        rightPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ProfilePage(),
        )),
        avatar:
            '${AppConstant.endPointBaseImage}/${SharedPrefs.user?.avatar ?? ''}',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0)
              .copyWith(top: 26.0, bottom: 60.0),
          child: Column(
            children: [
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final address = addresses[index];
                  return AddressItem(
                    address,
                    onTap: () {
                      for (var element in addresses) {
                        element.isSelected = false;
                      }
                      address.isSelected = true;
                      setState(() {});
                    },
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20.0),
                itemCount: addresses.length,
              ),
              const SizedBox(height: 46.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppElevatedButton.outline(
                    onPressed: () {},
                    icon: const Icon(Icons.add, size: 20.0, color: Colors.red),
                    text: 'Add New Address',
                    height: 42.0,
                    padding: const EdgeInsets.only(left: 16.0, right: 20.0),
                  ),
                ],
              ),
              const SizedBox(height: 72.0),
              AppElevatedButton(
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const PaymentPage()),
                  (Route<dynamic> route) => false,
                ),
                text: 'Next',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
