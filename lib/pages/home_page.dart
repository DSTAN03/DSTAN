import 'package:flutter/material.dart';
import 'package:thuc_tap_1/pages/cart/cart_page_2.dart';
import 'package:thuc_tap_1/pages/payment/chat_ai_page.dart';
import 'package:thuc_tap_1/pages/payment/payment_method_page.dart';

import '../resources/app_color.dart';
import 'profile/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.title, this.pageIndex});

  final String? title;
  final int? pageIndex;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.pageIndex ?? 0;
  }

  List pages = [
    const CartPage2(title: 'Foodie Lover'),
    const ChatScreen(),
    const PaymentMethodPage(),
    const ProfilePage(),
  ];

  List<IconData> listIconData = [
    Icons.home,
    Icons.message_sharp,
    Icons.payment_sharp,
    Icons.person,
  ];
  List<String> listLabel = [
    'Home',
    'Chat AI',
    'Payments',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return AnimatedContainer(
      height: 52.0,
      duration: const Duration(milliseconds: 2000),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      child: Row(
        children: List.generate(
          4,
          (index) => Expanded(child: _navigationItem(index)),
        ),
        // children: [
        //   Expanded(
        //     child: _navigationItem(0),
        //   ),
        //   Expanded(
        //     child: _navigationItem(1),
        //   ),
        //   Expanded(
        //     child: _navigationItem(2),
        //   ),
        //   Expanded(
        //     child: _navigationItem(3),
        //   ),
        // ],
      ),
    );
  }

  Widget _navigationItem(int index) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 251, 68, 2).withOpacity(0.2),
              const Color.fromARGB(255, 0, 105, 242).withOpacity(0.05),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              listIconData[index],
              size: 22.0,
              color:
                  index == selectedIndex ? const Color.fromARGB(255, 3, 214, 246) : AppColor.dark500,
            ),
            Text(
              listLabel[index],
              style: TextStyle(
                color: index == selectedIndex
                    ? const Color.fromARGB(255, 3, 214, 246)
                    : AppColor.dark500,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
