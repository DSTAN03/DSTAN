import 'dart:async';
import 'package:flutter/material.dart';
import 'package:thuc_tap_1/pages/auth/login_page.dart';
import 'package:thuc_tap_1/pages/onboarding/onboarding_page.dart';
import 'package:thuc_tap_1/services/local/shared_prefs.dart';
import '../../gen/assets.gen.dart';
import '../welcome_page.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  void _checkToken() {
    Timer(const Duration(milliseconds: 2600), () {
      if (SharedPrefs.isAccessed ) {
        if (SharedPrefs.isLogin) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
            (Route<dynamic> route) => false,
          );
        } else {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const WelcomePage(),
            ),
            (Route<dynamic> route) => false,
          );
        }
      } else {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const OnboardingPage(),
          ),
          (Route<dynamic> route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.background.provider(),
            fit: BoxFit.fill,
          ),
        ),
        child: Image.asset(Assets.images.logo1.path, width: 160.0),
      ),
      // body: Stack(
      //   children: [
      //     Image.asset(
      //       Assets.images.background.path,
      //       width: size.width,
      //       height: size.height,
      //       fit: BoxFit.fill,
      //     ),
      //     Center(
      //       child: Image.asset(
      //         Assets.images.logo1.path,
      //         width: 160.0,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
