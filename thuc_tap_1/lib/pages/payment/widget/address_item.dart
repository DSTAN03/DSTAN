import 'package:flutter/material.dart';
import '../../../components/app_box_shadow.dart';
import '../../../gen/assets.gen.dart';
import '../../../models/address_model.dart';

class AddressItem extends StatelessWidget {
  const AddressItem(
    this.address, {
    super.key,
    this.onTap,
    this.width,
    this.height,
  });

  final Function()? onTap;
  final AddressModel address;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.only(
            left: 18.0, top: 12.0, right: 14.0, bottom: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: AppBoxShadow.boxShadow,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    address.titleFirst ?? '-:-',
                    style: const TextStyle(
                        color: Colors.brown,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Image.asset(
                    address.isSelected == true
                        ? Assets.images.radioButtonOn.path
                        : Assets.images.radioButtonOff.path,
                    width: 18.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                address.titleSecond ?? '-:-',
                style: const TextStyle(color: Colors.grey),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                address.description ?? '-:-',
                style: const TextStyle(color: Colors.grey),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
