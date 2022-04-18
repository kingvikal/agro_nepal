import 'package:final_year_project/providers/category_provider.dart';
import 'package:final_year_project/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'category.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryData =
        Provider.of<CategoryProvider>(context, listen: false).getCategories();
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: 340,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0XFF32A368).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const TextField(
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
                ],
              ),
            ),
            SectionTitle(text: "Category", press: () {}),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: categoryData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print('loading');
                  return CircularProgressIndicator();
                } else if (snapshot.connectionState == ConnectionState.done) {
                  print('done');
                  // return Consumer<CategoryProvider>(
                  //   builder: (ctx, categoryData, child) {
                  //     if (categoryData.categories.isNotEmpty) {
                  //       return Padding(
                  //         padding: const EdgeInsets.all(5.0),
                  //         child: Container(
                  //           height: 400,
                  //           width: double.infinity,
                  //           child: ListView.builder(
                  //             itemCount: categoryData.categories.length,
                  //             itemBuilder: (context, i) {
                  //               return Text(
                  //                 categoryData.categories[i].categoryName,
                  //               );
                  //             },
                  //           ),
                  //         ),
                  //       );
                  //     } else {
                  //       return const Center(
                  //         child: Text('No Items Found.'),
                  //       );
                  //     }
                  //   },
                  // );
                  return Container(child: Text('dkjfdkfj'),);
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
              text: "Special For You",
              press: () {
                print("Pressed");
              },
            )
          ],
        ),
      ),
    );
  }
}
