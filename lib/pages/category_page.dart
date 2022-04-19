import 'package:final_year_project/providers/category_provider.dart';
import 'package:final_year_project/widgets/assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({
    Key? key,
    required this.categoryImages,
  }) : super(key: key);

  final List<String> categoryImages;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<CategoryProvider>(context, listen: false).getCategories(),
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
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: categoryData.categories.length,
                      itemBuilder: (context, i) {
                        return Container(
                          margin: const EdgeInsets.all(
                            5,
                          ),
                          decoration: BoxDecoration(
                            color: Assets.primaryColor,
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                          ),
                          height: 110,
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                child: Image(
                                  image: AssetImage(widget.categoryImages[i]),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  categoryData.categories[i].category,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
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
    );
  }
}
