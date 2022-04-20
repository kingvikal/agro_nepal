import 'package:final_year_project/providers/products_provider.dart';
import 'package:final_year_project/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryProductsPage extends StatefulWidget {
  const CategoryProductsPage({Key? key}) : super(key: key);
  static const routeName = '/categoryProductsPage';

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    final categoryId = routeArgs['id'] as int;
    final categoryName = routeArgs['name'] as String;
    final productsData = Provider.of<ProductsProvider>(context, listen: false)
        .getProductsByCategory(categoryId);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            categoryName,
          ),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GridView.builder(
            controller: ScrollController(),
            padding: const EdgeInsets.all(
              5,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              crossAxisCount: 2,
              childAspectRatio: 4 / 7,
            ),
            itemCount: productsData.length,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                value: productsData[index],
                child: const ProductItem(),
              );
            },
          ),
        ),
      ),
    );
  }
}
