import 'dart:async';
import 'package:final_year_project/pages/products_overview_page.dart';
import 'package:final_year_project/providers/cart_provider.dart';
import 'package:final_year_project/providers/category_provider.dart';
import 'package:final_year_project/providers/products_provider.dart';
import 'package:final_year_project/services/shared_service.dart';
import 'package:final_year_project/widgets/circular_category_item.dart';
import 'package:final_year_project/widgets/product_item.dart';
import 'package:final_year_project/widgets/search_textfield.dart';
import 'package:final_year_project/widgets/section_title.dart';
import 'package:final_year_project/widgets/sliding_widget.dart';
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
    if (SharedService.isAppStarted == false) {
      _pageController = PageController(
        initialPage: currentIndex,
      );
      Timer.periodic(const Duration(seconds: 6), (Timer timer) {
        if (currentIndex < 2) {
          currentIndex++;
          _pageController.animateToPage(
            currentIndex,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeIn,
          );
        } else {
          currentIndex = 0;
        }
      });
      print(currentIndex);
    } else {
      return;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        controller: _scrollController1,
        child: Column(
          children: [
            const SearchField(),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
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
                                return CircularCategoryWidget(
                                  widget: widget,
                                  i: i,
                                  categoryId: categoryData.categories[i].id,
                                  categoryName:
                                      categoryData.categories[i].category,
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
            SlidingWidget(
              pageController: _pageController,
            ),
            const SizedBox(
              height: 20,
            ),
            SectionTitle(
              text: 'Special For You',
              press: () {
                Navigator.pushNamed(context, ProductOverViewPage.routeName);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: Provider.of<ProductsProvider>(context, listen: false)
                  .getAllProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 290,
                    width: double.infinity,
                    color: Colors.transparent,
                    child: const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  );
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
                              itemCount: 6,
                              itemBuilder: (context, i) {
                                return SizedBox(
                                  height: 290,
                                  width: 180,
                                  child: ChangeNotifierProvider.value(
                                    value: productsData.products[i],
                                    child: const ProductItem(),
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
              press: () {
                Navigator.pushNamed(context, ProductOverViewPage.routeName);
              },
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
                    height: 290,
                    width: double.infinity,
                    color: Colors.transparent,
                    child: const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  );
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
                              itemCount: 6,
                              itemBuilder: (context, i) {
                                return SizedBox(
                                  height: 290,
                                  width: 180,
                                  child: ChangeNotifierProvider.value(
                                    value: productsData.shuffledProducts[i],
                                    child: const ProductItem(),
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
