import 'dart:async';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap_1/components/snack_bar/td_snack_bar.dart';

import '../../components/button/td_elevated_button.dart';
import '../../components/snack_bar/top_snack_bar.dart';
import '../../components/text_field/td_text_field.dart';
import '../../components/text_field/td_text_field_password.dart';
import '../../gen/assets.gen.dart';
import '../../models/user_model.dart';
import '../../resources/app_color.dart';
import '../../utils/post_image.dart';
import '../../utils/validator.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _userCollection = FirebaseFirestore.instance.collection('users');
  final _postImage = PostImage();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  File? _avatarFile;
  bool _isLoading = false;

  Future<void> _pickAvatar() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return;

    setState(() {
      _avatarFile = File(result.files.single.path!);
    });
  }

  Future<void> _submitForm(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      final avatarUrl = _avatarFile != null
          ? await _postImage.post(image: _avatarFile!)
          : null;

      final user = UserModel()
        ..name = _nameController.text.trim()
        ..email = _emailController.text.trim()
        ..avatar = avatarUrl;

      await _userCollection.doc(user.email).set(user.toJson());

      if (!context.mounted) return;

      showTopSnackBar(
        context,
        const TDSnackBar.success(
          message: 'Register successfully, please login 😍',
        ),
      );

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => LoginPage(email: user.email),
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      showTopSnackBar(context, TDSnackBar.error(message: e.message ?? ''));
    } catch (e) {
      dev.log("Registration error: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget _buildAvatar() {
    final avatarImage = _avatarFile != null
        ? FileImage(_avatarFile!)
        : AssetImage(Assets.images.defaultAvatar.path) as ImageProvider;

    return GestureDetector(
      onTap: _isLoading ? null : _pickAvatar,
      child: Stack(
        children: [
          _isLoading
              ? CircleAvatar(
                  radius: 34.6,
                  backgroundColor: Colors.orange.shade200,
                  child: const SizedBox.square(
                    dimension: 36,
                    child: CircularProgressIndicator(
                      color: AppColor.pink,
                      strokeWidth: 2.6,
                    ),
                  ),
                )
              : CircleAvatar(
                  radius: 34.6,
                  backgroundImage: avatarImage,
                  backgroundColor: Colors.transparent,
                ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: AppColor.pink),
              ),
              child: const Icon(
                Icons.camera_alt_outlined,
                size: 14.6,
                color: AppColor.pink,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(horizontal: 20)
        .copyWith(top: MediaQuery.of(context).padding.top + 38, bottom: 16);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: ListView(
            padding: padding,
            children: [
              const Center(
                child: Text(
                  'Register',
                  style: TextStyle(color: AppColor.red, fontSize: 26),
                ),
              ),
              const SizedBox(height: 30),
              Center(child: _buildAvatar()),
              const SizedBox(height: 40),
              TdTextField(
                controller: _nameController,
                hintText: 'Full Name',
                prefixIcon: const Icon(Icons.person, color: AppColor.orange),
                textInputAction: TextInputAction.next,
                validator: Validator.required,
              ),
              const SizedBox(height: 20),
              TdTextField(
                controller: _emailController,
                hintText: 'Email',
                prefixIcon: const Icon(Icons.email, color: AppColor.orange),
                textInputAction: TextInputAction.next,
                validator: Validator.email,
              ),
              const SizedBox(height: 20),
              TdTextFieldPassword(
                controller: _passwordController,
                hintText: 'Password',
                textInputAction: TextInputAction.next,
                validator: Validator.password,
              ),
              const SizedBox(height: 20),
              TdTextFieldPassword(
                controller: _confirmPasswordController,
                hintText: 'Confirm Password',
                onFieldSubmitted: (_) => _submitForm(context),
                onChanged: (_) => setState(() {}),
                textInputAction: TextInputAction.done,
                validator: Validator.confirmPassword(
                  _passwordController.text,
                ),
              ),
              const SizedBox(height: 56),
              TdElevatedButton(
                onPressed: () => _submitForm(context),
                text: 'Sign up',
                isDisable: _isLoading,
              ),
              const SizedBox(height: 12),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Do you have an account? ',
                  style: const TextStyle(fontSize: 16, color: AppColor.grey),
                  children: [
                    TextSpan(
                      text: 'Sign in',
                      style: const TextStyle(color: AppColor.red),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (_) => const LoginPage()),
                            (route) => false,
                          );
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
