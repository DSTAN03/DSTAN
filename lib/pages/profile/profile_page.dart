import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thuc_tap_1/pages/payment/address_page.dart';
import 'package:thuc_tap_1/pages/payment/chat_ai_page.dart';
import 'package:thuc_tap_1/pages/payment/payment_method_page.dart';
import '../../components/app_dialog.dart';
import '../../consts.dart';
import '../../gen/assets.gen.dart';
import '../../models/user_model.dart';
import '../../resources/app_color.dart';
import '../../services/local/shared_prefs.dart';
import '../auth/change_password_page.dart';
import '../auth/login_page.dart';
import 'my_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel user = SharedPrefs.user ?? UserModel();
  bool isLoading = false;
  File? fileAvatar;

  @override
  Widget build(BuildContext context) {
    const avatarRadius = 45.0;
    return Scaffold(
      appBar: AppBar(
        title:  Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 64, 228, 4),
        highlightColor: Colors.yellow,
        child: const Text(
          "My Profile",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black, 
          ),
        ),
      ),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: _buildAvatar(avatarRadius),
            ),
            const SizedBox(height: 12),
            Text(
              user.name ?? '',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                children: [
                  _buttonCard(
                      const Icon(Icons.person_2_outlined, color: Colors.red),
                      "Information & Contact 🙋‍♂️",
                      () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyProfilePage()))),
                  const SizedBox(height: 10.0),
                  _buttonCard(
                      const Icon(Icons.lock, color: Colors.orange),
                      "Password Management 🔐 ",
                      () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangePasswordPage(
                              email: '',
                            ),
                          ))),
                  const SizedBox(height: 10.0),
                  _buttonCard(
                      const Icon(Icons.location_on, color: Colors.green),
                      "Adresses 🏠",
                      () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddressPage()))),
                  const SizedBox(height: 10.0),
                  _buttonCard(
                      const Icon(Icons.payment_outlined, color: Colors.green),
                      "Payment 🤑",
                      () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentMethodPage()))),
                  const SizedBox(height: 10.0),
                  _buttonCard(
                      const Icon(Icons.message_outlined,
                          color: Colors.greenAccent),
                      "Chat With AI 🖥",
                      () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatScreen()))),
                  const SizedBox(height: 10.0),
                  _buttonCard(
                    const Icon(Icons.logout, color: Colors.red),
                    "Exit 💥",
                    () => AppDialog.dialog(
                      context,
                      title: const Text(
                        'Log Out',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      content: 'Do you want to logout DST.FASTFOOD 💖?',
                      action: () async {
                        await FirebaseAuth.instance.signOut();
                        await SharedPrefs.removeSeason();
                        if (context.mounted) {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (_) => const LoginPage(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildAvatar(double radius) {
    if (isLoading) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: Colors.orange.shade200,
        child: const CircularProgressIndicator(
          color: AppColor.pink,
          strokeWidth: 2.0,
        ),
      );
    }

    if (fileAvatar != null) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: FileImage(File(fileAvatar!.path)),
      );
    }

    if (user.avatar != null && user.avatar!.isNotEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(
          '${AppConstant.endPointBaseImage}/${user.avatar!}',
        ),
        backgroundColor: Colors.grey.shade200,
        onBackgroundImageError: (_, __) {},
      );
    }

    return CircleAvatar(
      radius: radius,
      backgroundImage: AssetImage(Assets.images.defaultAvatar.path),
    );
  }

  Widget _buttonCard(Icon icon, String title, Function()? onTap) {
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: icon,
        title: Text(
          title,
          maxLines: 2,
          style:
              const TextStyle(fontSize: 14.0, overflow: TextOverflow.ellipsis),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
