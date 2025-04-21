import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap_1/components/button/td_elevated_button.dart';
import 'package:thuc_tap_1/components/snack_bar/top_snack_bar.dart';
import 'package:thuc_tap_1/components/snack_bar/td_snack_bar.dart';
import 'package:thuc_tap_1/components/text_field/td_text_field.dart';
import 'package:thuc_tap_1/components/text_field/td_text_field_password.dart';
import 'package:thuc_tap_1/gen/assets.gen.dart';
import 'package:thuc_tap_1/models/user_model.dart';
import 'package:thuc_tap_1/pages/home_page.dart';
import 'package:thuc_tap_1/resources/app_color.dart';
import 'package:thuc_tap_1/services/local/shared_prefs.dart';
import 'package:thuc_tap_1/utils/validator.dart';
import 'forgot_password.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.email});
  final String? email;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _userCollection = FirebaseFirestore.instance.collection('users');

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.email != null) {
      emailController.text = widget.email!;
    }
  }

  Future<void> _submitLogin(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      if (!context.mounted) return;

      await _loadUserDataAndNavigate(context);
    } on FirebaseAuthException {
      if (!context.mounted) return;
      showTopSnackBar(
        context,
        const TDSnackBar.error(message: 'Email or Password is wrong😐'),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> _loadUserDataAndNavigate(BuildContext context) async {
    try {
      final doc = await _userCollection.doc(emailController.text).get();
      final data = doc.data() as Map<String, dynamic>;

      SharedPrefs.user = UserModel.fromJson(data) as UserModel?;

      if (!context.mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => HomePage(title: 'FOODIES', )),
        (route) => false,
      );
    } catch (_) {
      // Optionally: handle or log error
    }
  }

  Widget _buildLogo() {
    return Center(
      child: Image.asset(
        Assets.images.logo3.path,
        width: 90.0,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildEmailField() {
    return TdTextField(
      controller: emailController,
      hintText: 'Email',
      prefixIcon: const Icon(Icons.email, color: Colors.orange),
      validator: Validator.email,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildPasswordField() {
    return TdTextFieldPassword(
      controller: passwordController,
      hintText: 'Password',
      validator: Validator.password,
      onFieldSubmitted: (_) => _submitLogin(context),
      textInputAction: TextInputAction.done,
    );
  }

  Widget _buildActionLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const RegisterPage()),
          ),
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
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ForgotPasswordPage()),
          ),
          child: const Text(
            'Forgot Password?',
            style: TextStyle(color: AppColor.brown, fontSize: 16.0),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return TdElevatedButton(
      onPressed: () => _submitLogin(context),
      text: 'Sign in',
      isDisable: isLoading,
    );
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
              top: MediaQuery.of(context).padding.top + 38.0,
              bottom: 16.0,
            ),
            children: [
              const Center(
                child: Text(
                  'Sign in',
                  style: TextStyle(color: AppColor.red, fontSize: 26.0),
                ),
              ),
              const SizedBox(height: 32.0),
              _buildLogo(),
              const SizedBox(height: 36.0),
              _buildEmailField(),
              const SizedBox(height: 20.0),
              _buildPasswordField(),
              const SizedBox(height: 8.0),
              _buildActionLinks(),
              const SizedBox(height: 60.0),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}
