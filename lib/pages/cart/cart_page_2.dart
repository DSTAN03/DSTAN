import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../components/app_bar/td_app_bar.dart';
import '../../components/app_dialog.dart';
import '../../consts.dart';
import '../../services/local/shared_prefs.dart';
import '../profile/profile_page.dart';
import 'widget/delivery_time.dart';
import 'widget/food_item_2.dart';
import '../../models/food_model.dart';

class CartPage2 extends StatefulWidget {
  const CartPage2({super.key, required this.title});
  final String title;

  @override
  State<CartPage2> createState() => _CartPage2State();
}

class _CartPage2State extends State<CartPage2> {
  final addController = TextEditingController();
  final addFocus = FocusNode();
  bool showAddBox = false;

  double get totalPrice {
    double total = 0.0;
    for (FoodModel food in foods) {
      total = total + food.total;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TdAppBar(
        leftPressed: () => AppDialog.dialog(
          context,
          title: const Text('😍'),
          content: 'Do you want to exit app?',
          action: () =>
              SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
        ),
        rightPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ProfilePage(),
        )),
        title: widget.title,
        avatar:
            '${AppConstant.endPointBaseImage}/${SharedPrefs.user?.avatar ?? ''}',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ).copyWith(top: 12.0),
        child: CustomScrollView(
          slivers: [
            SliverList.separated(
              itemCount: foods.length,
              itemBuilder: (context, index) {
                FoodModel food = foods[index];
                return FoodItem2(
                  food,
                  onAdd: () =>
                      setState(() => food.quantity = (food.quantity ?? 0) + 1),
                  onRemove: food.quantity == 1
                      ? null
                      : () => setState(
                          () => food.quantity = (food.quantity ?? 0) - 1),
                  onDelete: () => AppDialog.dialog(
                    context,
                    title: const Text('😐'),
                    content: 'Delete this food?',
                    action: () => setState(
                        () => foods.removeWhere((e) => e.id == food.id)),
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 20.0),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 16.0),
                  DeliveryTime(minute: 25, totalPrice: totalPrice),
                  const SizedBox(height: 24.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
