import 'dart:async';

import 'package:final_year_project/pages/home_screen.dart';
import 'package:final_year_project/pages/user_profile.dart';
import 'package:final_year_project/providers/category_provider.dart';
import 'package:final_year_project/providers/products_provider.dart';
import 'package:final_year_project/services/api_service.dart';
import 'package:final_year_project/widgets/assets.dart';
import 'package:final_year_project/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
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
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfilePage()));
                    },
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ))
              ],
            ),
            backgroundColor: Colors.white,
            body: TabBarView(
              children: [
                Home(categoryImages: categoryImages),
                Container(
                  child: Text('Categories'),
                ),
                Container(
                  child: Text('Profile'),
                ),
              ],
            )),
      ),
    );
  }
}

class Home extends StatefulWidget {
  Home({
    Key? key,
    required this.categoryImages,
  }) : super(key: key);

  final List<String> categoryImages;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // int currentIndex = 0;
  // PageController _pageController = PageController();

  // @override
  // void initState() {
  //   _pageController = PageController(
  //     initialPage: currentIndex,
  //   );
  //   Timer.periodic(Duration(seconds: 3), (Timer timer) {
  //   if (currentIndex < 2) {
  //     currentIndex++;
  //     _pageController.animateToPage(
  //         currentIndex,
  //         duration: Duration(milliseconds: 350),
  //   curve: Curves.easeIn,
  //     );
  //   } else {
  //     currentIndex = 0;
  //   }
  // });
  //   print(currentIndex);
  //   super.initState();
  // }

  // @override
  // void didChangeDependencies() {
  //   Timer(const Duration(seconds: 2), () {
  //     setState(() {
  //       pageInteger++;
  //     });
  //   });
  //   print(pageInteger);
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: "Search Product",
                  prefixIcon: Icon(Icons.search),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                ),
              ),
            ),
            SectionTitle(text: "Category", press: () {}),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: Provider.of<CategoryProvider>(context, listen: false)
                  .getCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                      height: 100,
                      width: double.infinity,
                      color: Colors.transparent,
                      child: Center(
                          child: CircularProgressIndicator(
                        strokeWidth: 2,
                      )));
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return Consumer<CategoryProvider>(
                    builder: (ctx, categoryData, child) {
                      if (categoryData.categories.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SizedBox(
                            height: 100,
                            width: double.infinity,
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: categoryData.categories.length,
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    right: 20,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            const Color(0XFF32A368),
                                        radius: 30,
                                        backgroundImage: AssetImage(
                                            widget.categoryImages[i]),
                                        // child: FadeInImage(placeholder: AssetImage('assets/images/loading.gif'), image: NetworkImage(categoryImages[i],),fit: BoxFit.cover,),
                                      ),
                                      Container(
                                        // margin: const EdgeInsets.only(right: 10,),\
                                        padding: const EdgeInsets.only(
                                          left: 5,
                                          right: 5,
                                          top: 5,
                                          bottom: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                          // color: Colors.grey,
                                        ),
                                        child: Text(
                                          categoryData.categories[i].category,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text('No Items Found.'),
                        );
                      }
                    },
                  );
                } else {
                  return const Center(
                    child: Text('Something went Wrong'),
                  );
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            // Container(
            //   height: 200,
            //   width: double.infinity,
            //   color: Colors.amber,
            //   child: PageView(
            //     controller: _pageController,
            //     children: [
            //       Container(
            //         child: FadeInImage(fit: BoxFit.cover,placeholder: AssetImage('assets/images/loading.gif'), image: NetworkImage('https://fruitvalleys.com/wp-content/uploads/2021/07/Buy-Grocery-Get-Discount-1024x512.png'),),
            //       ),
            //      Container(
            //         child: FadeInImage(fit: BoxFit.cover,placeholder: AssetImage('assets/images/loading.gif'), image: NetworkImage('https://solisworld.com/wp-content/uploads/2020/01/compact.jpg'),),
            //       ),
            //       Container(
            //         child: FadeInImage(fit: BoxFit.cover,placeholder: AssetImage('assets/images/loading.gif'), image: NetworkImage('https://png.pngtree.com/png-clipart/20190328/ourlarge/pngtree-summer-fruits-sale-big-discount-offers-banner-png-image_890773.jpg'),),
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
            SectionTitle(
              text: 'Special For You',
              press: () {},
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: Provider.of<ProductsProvider>(context, listen: false)
                  .getAllProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print('loading');
                  return Container(
                      height: 100,
                      width: double.infinity,
                      color: Colors.transparent,
                      child: Center(
                          child: CircularProgressIndicator(
                        strokeWidth: 2,
                      )));
                } else if (snapshot.connectionState == ConnectionState.done) {
                  print('done');
                  return Consumer<ProductsProvider>(
                    builder: (ctx, productsData, child) {
                      if (productsData.products.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: 290,
                            width: double.infinity,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: productsData.products.length,
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    right: 20,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Card(
                                        elevation: 3,
                                        child: Container(
                                          height: 280,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                            color: const Color(0XFF32A368)
                                                .withOpacity(0.4),
                                          ),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                flex: 5,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                              15,
                                                            ),
                                                            topRight:
                                                                Radius.circular(
                                                                    15)),
                                                  ),
                                                  width: double.infinity,
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        5,
                                                      ),
                                                      child: FadeInImage(
                                                        placeholder: AssetImage(
                                                            'assets/images/loading.gif'),
                                                        image: NetworkImage(
                                                          productsData
                                                              .products[i]
                                                              .imageUrl,
                                                        ),
                                                        fit: BoxFit.cover,
                                                      )),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        productsData
                                                            .products[i].title,
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 8,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          const Text('NPR.'),
                                                          Text(
                                                            productsData
                                                                .products[i]
                                                                .price
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 8,
                                                        bottom: 5,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                            'NPR.',
                                                            style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough),
                                                          ),
                                                          Text(
                                                            (productsData
                                                                        .products[
                                                                            i]
                                                                        .price *
                                                                    1.5)
                                                                .toInt()
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                        child: Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.shopping_cart,
                                                            color: Colors.green,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            'ADD TO CART',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green),
                                                          )
                                                        ],
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                    15,
                                                                  ),
                                                                  bottomRight:
                                                                      Radius
                                                                          .circular(
                                                                    15,
                                                                  ))),
                                                    )),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text('No Items Found.'),
                        );
                      }
                    },
                  );
                } else {
                  return const Center(
                    child: Text('Something went Wrong'),
                  );
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SectionTitle(
              text: 'Daily Deals',
              press: () {},
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: Provider.of<ProductsProvider>(context, listen: false)
                  .getShuffledProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print('loading');
                  return Container(
                      height: 100,
                      width: double.infinity,
                      color: Colors.transparent,
                      child: Center(
                          child: CircularProgressIndicator(
                        strokeWidth: 2,
                      )));
                } else if (snapshot.connectionState == ConnectionState.done) {
                  print('done');
                  return Consumer<ProductsProvider>(
                    builder: (ctx, productsData, child) {
                      if (productsData.shuffledProducts.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: 290,
                            width: double.infinity,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: productsData.shuffledProducts.length,
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    right: 20,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Card(
                                        elevation: 3,
                                        child: Container(
                                          height: 280,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                            color: const Color(0XFF32A368)
                                                .withOpacity(0.4),
                                          ),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                flex: 5,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                              15,
                                                            ),
                                                            topRight:
                                                                Radius.circular(
                                                                    15)),
                                                  ),
                                                  width: double.infinity,
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        5,
                                                      ),
                                                      child: FadeInImage(
                                                        placeholder: AssetImage(
                                                            'assets/images/loading.gif'),
                                                        image: NetworkImage(
                                                          productsData
                                                              .shuffledProducts[
                                                                  i]
                                                              .imageUrl,
                                                        ),
                                                        fit: BoxFit.cover,
                                                      )),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        productsData
                                                            .shuffledProducts[i]
                                                            .title,
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 8,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          const Text('NPR.'),
                                                          Text(
                                                            productsData
                                                                .shuffledProducts[
                                                                    i]
                                                                .price
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 8,
                                                        bottom: 5,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                            'NPR.',
                                                            style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough),
                                                          ),
                                                          Text(
                                                            (productsData
                                                                        .shuffledProducts[
                                                                            i]
                                                                        .price *
                                                                    1.5)
                                                                .toInt()
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                        child: Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.shopping_cart,
                                                            color: Colors.green,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            'ADD TO CART',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green),
                                                          )
                                                        ],
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                    15,
                                                                  ),
                                                                  bottomRight:
                                                                      Radius
                                                                          .circular(
                                                                    15,
                                                                  ))),
                                                    )),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text('No Items Found.'),
                        );
                      }
                    },
                  );
                } else {
                  return const Center(
                    child: Text('Something went Wrong'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
