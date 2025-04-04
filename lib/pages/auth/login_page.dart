import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap_1/components/snack_bar/td_snack_bar.dart';
import 'package:thuc_tap_1/models/user_model.dart';
import 'package:thuc_tap_1/pages/cart/cart_page_2.dart';
import '../../components/button/td_elevated_button.dart';
import '../../components/snack_bar/top_snack_bar.dart';
import '../../components/text_field/td_text_field.dart';
import '../../components/text_field/td_text_field_password.dart';
import '../../gen/assets.gen.dart';
import '../../models/food_model2.dart';
import '../../resources/app_color.dart';
import '../../services/local/shared_prefs.dart';
import '../../utils/validator.dart';
import 'forgot_password.dart';
import 'register_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.email});
  final String? email;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>(); // o~ validate
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users'); // tham chieu

  Future<void> _submitLogin(BuildContext context) async {
    if (formKey.currentState?.validate() == false) {
      // valiedate ko thanh cong thi return luon
      return;
    }
    setState(() => isLoading = true); // de nut xoay tron de minh k bam duoc
    _auth // dang dung thu vien , code de login
        .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text)
        .then((value) {
      if (!context.mounted) return;
      _getUser(context);
    }).catchError((onError) {
      // login ko thanh cong
      setState(
          () => isLoading = false); // lam cho nu ngung` xoay de co the bam lai
      if (!context.mounted) return;
      showTopSnackBar(
        context,
        const TDSnackBar.error(message: 'Email or Password is wrong😐'),
      );
    });
  }

  void _getUser(BuildContext context) {
    userCollection
        .doc(emailController
            .text) // truy cap den document co id la email vua nhap
        .get() // lay du lieu ra
        .then((snapshot) {
          final data = snapshot.data() as Map<String, dynamic>;
          SharedPrefs.user = FoodModel2.fromJson(data) as UserModel?;
          if (!context.mounted)
            return; // dang sử dụng lập trình bất đồng bộ nên context có thể biết mất bất cứ lúc nào
          // kiểm tra xem context còn tồn tại hay không
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => const CartPage2(),
            ),
            (route) => false,
          );
        })
        .catchError((onError) {})
        .whenComplete(() => setState(() => isLoading = false));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
                top: MediaQuery.of(context).padding.top + 38.0, bottom: 16.0),
            children: [
              const Center(
                child: Text(
                  'Sign in',
                  style: TextStyle(color: AppColor.red, fontSize: 26.0),
                ),
              ),
              const SizedBox(height: 32.0),
              Center(
                child: Image.asset(Assets.images.logo3.path,
                    width: 90.0, fit: BoxFit.cover),
              ),
              const SizedBox(height: 36.0),
              TdTextField(
                controller: emailController,
                hintText: 'Email',
                prefixIcon: const Icon(Icons.email, color: Colors.orange),
                validator: Validator.email,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20.0),
              TdTextFieldPassword(
                controller: passwordController,
                hintText: 'Password',
                validator: Validator.password,
                onFieldSubmitted: (_) => _submitLogin(context),
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    )),
                    child: const Text(
                      'Register',
                      style: TextStyle(color: AppColor.red, fontSize: 16.0),
                    ),
                  ),
                  const Text(
                    ' | ',
                    style: TextStyle(color: AppColor.orange, fontSize: 16.0),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ForgotPasswordPage(),
                    )),
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: AppColor.brown, fontSize: 16.0),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60.0),
              TdElevatedButton(
                onPressed: () => _submitLogin(context),
                text: 'Sign in',
                isDisable: isLoading, // khi bằng true thì sẽ ko bấm được
              ),
            ],
          ),
        ),
      ),
    );
  }
}
