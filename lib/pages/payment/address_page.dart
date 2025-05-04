import 'package:flutter/material.dart';
import 'package:thuc_tap_1/components/app_bar/td_app_bar.dart';
import 'package:thuc_tap_1/pages/payment/payment_page.dart';
import 'package:thuc_tap_1/pages/payment/widget/address_item.dart';
import 'package:thuc_tap_1/services/google_services.dart';
import '../../components/button/app_elevated_button.dart';
import '../../components/text_field/td_text_field.dart';
import '../../consts.dart';
import '../../models/address_model.dart';
import '../../resources/app_color.dart';
import '../../services/local/shared_prefs.dart';
import '../profile/profile_page.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  List<AddressModel> _addressSuggestions = [];

  Future<void> _searchAddress(String query) async {
    final suggestions = await GooglePlaceService().autocomplete(query);
    setState(() {
      _addressSuggestions = suggestions;
    });
  }

  void _onAddressSelected(AddressModel address) {
    print(address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TdAppBar(
        leftPressed: () => Navigator.of(context).pop(),
        title: 'Choose Address',
        rightPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        ),
        avatar:
            '${AppConstant.endPointBaseImage}/${SharedPrefs.user?.avatar ?? ''}',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0)
            .copyWith(top: 26.0, bottom: 60.0),
        child: Column(
          children: [
            TdTextField(
              textInputAction: TextInputAction.done,
              prefixIcon: const Icon(Icons.search, color: AppColor.orange),
              hintText: 'Search Address',
              onChanged: _searchAddress,
            ),
            const SizedBox(height: 20),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final address = _addressSuggestions[index];
                return AddressItem(
                  address,
                  onTap: () {
                    setState(() {
                      for (var e in _addressSuggestions) {
                        e.isSelected = false;
                      }
                      address.isSelected = true;
                      _onAddressSelected(address);
                    });
                  },
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 30.0),
              itemCount: _addressSuggestions.length,
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
    );
  }
}