import 'dart:async';

import 'package:final_year_project/pages/cart_page.dart';
import 'package:final_year_project/pages/category_page.dart';
import 'package:final_year_project/pages/home_screen.dart';
import 'package:final_year_project/pages/user_profile.dart';
import 'package:final_year_project/providers/cart_provider.dart';
import 'package:final_year_project/services/api_service.dart';
import 'package:final_year_project/widgets/assets.dart';
import 'package:final_year_project/widgets/badge.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget tabBuilder(IconData icon, String text) {
    return Tab(
      icon: Icon(
        icon,
        size: 26,
      ),
      text: text,
    );
  }

  List<String> categoryImages = [
    "assets/images/fruit.png",
    "assets/images/seed-bag.png",
    "assets/images/fertilizer.png",
    "assets/images/tractor.png",
    "assets/images/vegetable.png"
  ];

  int userId = 0;

  Future<void> getUserId() async {
    APIService.getUserProfile();
  }

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartItems>(context, listen: false);
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: Container(
            height: 70,
            color: Assets.primaryColor,
            child: TabBar(
              labelStyle: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black54,
              tabs: [
                tabBuilder(Icons.home, 'Home'),
                tabBuilder(Icons.category, 'Category'),
                tabBuilder(Icons.person, 'Profile'),
              ],
            ),
          ),
          drawer: const Drawer(
            backgroundColor: Color(0XFF32A368),
          ),
          appBar: AppBar(
            backgroundColor: const Color(0XFF32A368),
            title: const Center(child: Text("Agro Nep")),
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 5,
                ),
                child: Consumer<CartItems>(
                  builder: (_, cartItem, child) => Badge(
                    child: child as Widget,
                    value: cartData.itemCount.toString(),
                    color: Colors.amber,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.shopping_cart_sharp),
                    onPressed: () {
                      Navigator.pushNamed(context, CartPage.routeName);
                    },
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Home(categoryImages: categoryImages),
              CategoryPage(categoryImages: categoryImages),
              const ProfilePage(),
            ],
          ),
        ),
      ),
    );
  }
}
