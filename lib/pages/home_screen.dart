import 'dart:async';

import 'package:final_year_project/providers/cart_provider.dart';
import 'package:final_year_project/providers/category_provider.dart';
import 'package:final_year_project/providers/products_provider.dart';
import 'package:final_year_project/widgets/assets.dart';
import 'package:final_year_project/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  void showSnackBar() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.blueGrey,
        duration: Duration(seconds: 2),
        content: Text(
          'Item Added To Cart',
        ),
      ),
    );
  }

  int currentIndex = 0;
  PageController _pageController = PageController();
  final ScrollController _scrollController1 = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  final ScrollController _scrollController3 = ScrollController();
  final ScrollController _scrollController4 = ScrollController();

  @override
  void initState() {
    _pageController = PageController(
      initialPage: currentIndex,
    );
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (currentIndex < 2) {
        currentIndex++;
        _pageController.animateToPage(
          currentIndex,
          duration: Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      } else {
        currentIndex = 0;
      }
    });
    print(currentIndex);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Timer(const Duration(seconds: 2), () {
      setState(() {
        currentIndex++;
      });
    });
    print(currentIndex);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartItems>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        controller: _scrollController1,
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
                    child: const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  );
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
                              controller: _scrollController2,
                              physics: const BouncingScrollPhysics(),
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
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.amber,
              child: PageView(
                controller: _pageController,
                children: const [
                  FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/images/loading.gif'),
                    image: NetworkImage(
                        'https://fruitvalleys.com/wp-content/uploads/2021/07/Buy-Grocery-Get-Discount-1024x512.png'),
                  ),
                  FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/images/loading.gif'),
                    image: NetworkImage(
                        'https://solisworld.com/wp-content/uploads/2020/01/compact.jpg'),
                  ),
                  FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/images/loading.gif'),
                    image: NetworkImage(
                        'https://png.pngtree.com/png-clipart/20190328/ourlarge/pngtree-summer-fruits-sale-big-discount-offers-banner-png-image_890773.jpg'),
                  ),
                ],
              ),
            ),
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
                      child: const Center(
                          child: CircularProgressIndicator(
                        strokeWidth: 2,
                      )));
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return Consumer<ProductsProvider>(
                    builder: (ctx, productsData, child) {
                      if (productsData.products.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SizedBox(
                            height: 290,
                            width: double.infinity,
                            child: ListView.builder(
                              controller: _scrollController3,
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
                                                  decoration:
                                                      const BoxDecoration(
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
                                                        placeholder:
                                                            const AssetImage(
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
                                                      child: InkWell(
                                                        onTap: () {
                                                          print('rino');

                                                          cartData.addCartItem(
                                                            productsData
                                                                .products[i].id
                                                                .toString(),
                                                            productsData
                                                                .products[i]
                                                                .title,
                                                            productsData
                                                                .products[i]
                                                                .price
                                                                .toDouble(),
                                                            productsData
                                                                .products[i]
                                                                .imageUrl,
                                                          );
                                                          showSnackBar();
                                                        },
                                                        child: Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: const [
                                                              Icon(
                                                                Icons
                                                                    .shopping_cart,
                                                                color: Colors
                                                                    .green,
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
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                15,
                                                              ),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                15,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
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
                  return Container(
                      height: 100,
                      width: double.infinity,
                      color: Colors.transparent,
                      child: const Center(
                          child: CircularProgressIndicator(
                        strokeWidth: 2,
                      )));
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return Consumer<ProductsProvider>(
                    builder: (ctx, productsData, child) {
                      if (productsData.shuffledProducts.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SizedBox(
                            height: 290,
                            width: double.infinity,
                            child: ListView.builder(
                              controller: _scrollController4,
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
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(15),
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
                                                        placeholder:
                                                            const AssetImage(
                                                                'assets/images/loading.gif'),
                                                        image: NetworkImage(
                                                            productsData
                                                                .shuffledProducts[
                                                                    i]
                                                                .imageUrl),
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
                                                        child: InkWell(
                                                      onTap: () {
                                                        cartData.addCartItem(
                                                          productsData
                                                              .shuffledProducts[
                                                                  i]
                                                              .id
                                                              .toString(),
                                                          productsData
                                                              .shuffledProducts[
                                                                  i]
                                                              .title,
                                                          productsData
                                                              .shuffledProducts[
                                                                  i]
                                                              .price
                                                              .toDouble(),
                                                          productsData
                                                              .shuffledProducts[
                                                                  i]
                                                              .imageUrl,
                                                        );
                                                        showSnackBar();
                                                      },
                                                      child: Container(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: const [
                                                            Icon(
                                                              Icons
                                                                  .shopping_cart,
                                                              color:
                                                                  Colors.green,
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
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                              15,
                                                            ),
                                                            bottomRight:
                                                                Radius.circular(
                                                              15,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
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
