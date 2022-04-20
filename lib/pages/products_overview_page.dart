import 'package:final_year_project/providers/products_provider.dart';
import 'package:final_year_project/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductOverViewPage extends StatefulWidget {
  const ProductOverViewPage({Key? key}) : super(key: key);
  static const routeName = '/productOverviewPage';

  @override
  State<ProductOverViewPage> createState() => _ProductOverViewPageState();
}

class _ProductOverViewPageState extends State<ProductOverViewPage> {
  @override
  Widget build(BuildContext context) {
    final productsData =
        Provider.of<ProductsProvider>(context, listen: false).products;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Get Your Products',
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:
              // StaggeredGrid.count(
              //     crossAxisCount: 2,
              //     mainAxisSpacing: 10,
              //     crossAxisSpacing: 10,
              //     children: productsData.map(
              //       (e) {
              //         if (e.id == 0) {

              //           return const StaggeredGridTile.extent(
              //             crossAxisCellCount: 1,
              //             mainAxisExtent: 280,
              //             child: ProductItem(),
              //           );
              //         } else {
              //           return const StaggeredGridTile.extent(
              //             crossAxisCellCount: 1,
              //             mainAxisExtent: 300,
              //             child: ProductItem(),
              //           );
              //         }
              //       },
              //     ).toList()

              GridView.builder(
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
          // ),
        ),
      ),
    );
  }
}
