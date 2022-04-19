import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> category = [
      {"icon": "assets/images/fruit.png", "text": "Fruits"},
      {"icon": "assets/images/fertilizer.png", "text": "Fertilizer"},
      {"icon": "assets/images/seed-bag.png", "text": "Seeds"},
      {"icon": "assets/images/tractor.png", "text": "Machinery"},
      {"icon": "assets/images/vegetable.png", "text": "Vegetable"},
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(
              category.length,
              (index) => CategoryCard(
                  icon: category[index]["icon"],
                  text: category[index]["text"],
                  press: () {
                  }))
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: 55,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0XFF32A368),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(icon),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
