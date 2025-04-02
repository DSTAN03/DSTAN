import 'package:flutter/material.dart';
import 'package:thuc_tap_1/pages/cart/cart_page_2.dart';
import '../../components/button/app_elevated_button.dart';
import '../../components/text_field/app_text_field.dart';
import '../../components/text_field/app_text_field_password.dart';
import '../../resources/app_color.dart';
import '../../resources/app_style.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Welcome Back',
                  style: AppStyle.h24Normal.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Login to your account',
                  style: AppStyle.h18Normal.copyWith(color: AppColor.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50.0),
                AppTextField(
                  controller: emailController,
                  hintText: 'Email or Phone',
                  textInputAction: TextInputAction.next,
                  prefixIcon: Icons.email,
                ),
                const SizedBox(height: 20.0),
                AppTextFieldPassword(
                  controller: passwordController,
                  hintText: 'Password',
                  textInputAction: TextInputAction.done,
                  prefixIcon: Icons.lock,
                ),
                const SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: AppColor.red, fontSize: 14.0),
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
                AppElevatedButton(
                  onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const CartPage2()),
                    (Route<dynamic> route) => false,
                  ),
                  text: 'Login',
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(color: AppColor.grey, fontSize: 14.0),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      ),
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                            color: AppColor.red,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
