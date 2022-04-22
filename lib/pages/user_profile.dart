import 'package:final_year_project/pages/customer_support.dart';
import 'package:final_year_project/pages/order_page.dart';
import 'package:final_year_project/services/shared_service.dart';
import 'package:final_year_project/widgets/profile_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:final_year_project/pages/profile_page1.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: ListView(
              controller: ScrollController(),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 33,
                      backgroundColor: Colors.green,
                      child: CircleAvatar(
                        backgroundImage: AssetImage("assets/images/logo.png"),
                        radius: 30,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Welcome ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          Text(
                            SharedService.name.toUpperCase(),
                            style: const TextStyle(
                              color: Color(0xff68A037),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Joined in ${DateFormat('yyyy-MM-dd').format(SharedService.dateTime)}",
                            // 'now'
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 50,
                  thickness: 1,
                ),
                const Text(
                  "My Profile.",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  color: const Color(0xffFFFFFF),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, UserProfile.routeName);
                        },
                        child: const ProfileData(
                          string: "My Personal Information",
                          showDivider: true,
                          sizedBox: true,
                        ),
                      ),
                      const ProfileData(
                        string: "My Payments",
                        showDivider: true,
                        sizedBox: true,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, OrderPage.routeName);
                        },
                        child: const ProfileData(
                          string: "My Orders",
                          showDivider: true,
                          sizedBox: true,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Exclusive deals.",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  color: const Color(0xffFFFFFF),
                  child: Column(
                    children: const [
                      ProfileData(
                        string: "Profile Setting",
                        showDivider: true,
                        sizedBox: true,
                      ),
                      ProfileData(
                        string: "Change Password",
                        showDivider: false,
                        sizedBox: false,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Supports.",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  color: const Color(0xffFFFFFF),
                  child: Column(
                    children: [
                      const ProfileData(
                        string: "Terms & Conditions",
                        showDivider: true,
                        sizedBox: true,
                      ),
                      InkWell(
                        // onTap: () async {
                        //   print('rino');
                        //   await launch("tel://9808880359");
                        // },
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CustomerSupportPage(),
                            ),
                          );
                        },
                        child: const ProfileData(
                          string: "Customer Support",
                          showDivider: true,
                          sizedBox: true,
                        ),
                      ),
                      const ProfileData(
                        string: "About AgroNep",
                        showDivider: false,
                        sizedBox: false,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        SharedService.logout(context);
                      },
                      icon: const Icon(Icons.logout),
                    ),
                    TextButton(
                        onPressed: () {
                          SharedService.logout(context);
                        },
                        child: const Text(
                          "Sign Out",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        )),
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
