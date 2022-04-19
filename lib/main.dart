import 'package:final_year_project/pages/cart_page.dart';
import 'package:final_year_project/pages/home_page.dart';
import 'package:final_year_project/pages/login_page.dart';
import 'package:final_year_project/pages/profile_page1.dart';
import 'package:final_year_project/pages/register_page.dart';
import 'package:final_year_project/providers/cart_provider.dart';
import 'package:final_year_project/providers/category_provider.dart';
import 'package:final_year_project/providers/products_provider.dart';
import 'package:final_year_project/services/shared_service.dart';
import 'package:final_year_project/widgets/assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget _defaultHome = const LoginPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool _result = await SharedService.isLoggedIn();
  if (_result) {
    _defaultHome = const HomePage();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartItems(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Agro_Nepal',
        theme: ThemeData(
          primaryColor: Assets.primaryColor,
          primarySwatch: Colors.green,
        ),
        routes: {
          '/': (context) => _defaultHome,
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/home': (context) => const HomePage(),
          CartPage.routeName: (context) => const CartPage(),
          UserProfile.routeName: (context) => const UserProfile(),
        },
      ),
    );
  }
}
