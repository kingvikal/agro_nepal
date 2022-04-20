import 'package:final_year_project/pages/category_products_overview_page.dart';
import 'package:final_year_project/pages/home_screen.dart';
import 'package:flutter/material.dart';

class CircularCategoryWidget extends StatelessWidget {
  const CircularCategoryWidget({
    Key? key,
    required this.widget,
    required this.i,
    required this.categoryId,
    required this.categoryName,
  }) : super(key: key);
  final int i;
  final int categoryId;
  final String categoryName;

  final Home widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20,
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            CategoryProductsPage.routeName,
            arguments: {
              'id': categoryId,
              'name': categoryName,
            },
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: const Color(0XFF32A368),
              radius: 30,
              backgroundImage: AssetImage(widget.categoryImages[i]),
            ),
            Container(
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
              ),
              child: Text(
                categoryName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
