import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/button/app_elevated_button.dart';
import '../gen/assets.gen.dart';
import 'auth/login_page.dart';
import 'auth/register_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const textStyle = TextStyle(color: Colors.brown, fontSize: 14.0);

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0.0,
            child: Image.asset(Assets.images.logo2.path, width: size.width),
          ),
          Positioned(
            left: 20.0,
            top: size.height / 2.0,
            right: 20.0,
            bottom: 72.0,
            child: Column(
              children: [
                const Text('Welcome',
                    style: TextStyle(color: Colors.red, fontSize: 32.0)),
                const Text('Lorem ipsum dolor sit amet, consect-',
                    style: textStyle),
                const Text('tetur adipiscing elit. Vivamus et felis',
                    style: textStyle),
                const Text('dolor. Donec vitae facilisis velit.',
                    style: textStyle),
                const Spacer(),
                AppElevatedButton(
                  onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (Route<dynamic> route) => false,
                  ),
                  text: 'Login',
                ),
                const SizedBox(height: 20.0),
                AppElevatedButton.outline(
                  onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()),
                    (Route<dynamic> route) => false,
                  ),
                  text: 'Sign up',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
