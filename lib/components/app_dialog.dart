import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../resources/app_color.dart';
import '../resources/app_style.dart';
import 'button/app_elevated_button.dart';

class AppDialog {
  AppDialog._();

  static void dialog(
    BuildContext context, {
    Widget? title,
    required String content,
    Function()? action,
  }) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: title,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  content,
                  style: const TextStyle(color: Colors.brown, fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppElevatedButton.smallOutline(
                  onPressed: () {
                    action?.call();
                    Navigator.pop(context);
                  },
                  text: 'Yes',
                ),
                const SizedBox(width: 12.0),
                AppElevatedButton.smallOutline(
                  onPressed: () => Navigator.pop(context),
                  text: 'No',
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  static Future<void> confirmExitApp(BuildContext context) async {
    bool? status = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('😍'),
        content: Text(
          'Do you want to exit app?',
          style: AppStyle.h18Normal.copyWith(color: AppColor.brown),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppElevatedButton.smallOutline(
                onPressed: () => Navigator.pop(context, true),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                text: 'Yes',
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: AppElevatedButton.smallOutline(
                  onPressed: () => Navigator.pop(context, false),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  text: 'No',
                ),
              ),
            ],
          ),
        ],
      ),
    );

    if (status ?? false) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
  }
}
