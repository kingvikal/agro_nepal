import 'package:final_year_project/models/product_model.dart';
import 'package:final_year_project/providers/products_provider.dart';
import 'package:final_year_project/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  static const routeName = '/searchPage';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<ProductModel> searchProductList = [];
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    // final productsData = Provider.of<ProductsProvider>(context)
    //     .getSearchProductByName(_searchController.text);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                textInputAction: TextInputAction.search,
                controller: _searchController,
                autofocus: true,
                onFieldSubmitted: (value) {
                  setState(
                    () {
                      searchProductList =
                          Provider.of<ProductsProvider>(context, listen: false)
                              .getSearchProductByName(value);
                    },
                  );
                },
                // onChanged: (value) {
                //   setState(
                //     () {
                //       searchText = value;
                //       searchProductList =
                //           Provider.of<ProductsProvider>(context, listen: false)
                //               .getSearchProductByName(value);
                //     },
                //   );
                // },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      25,
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      // setState(
                      //   () {
                      //     searchProductList = Provider.of<ProductsProvider>(
                      //             context,
                      //             listen: false)
                      //         .getSearchProductByName(_searchController.text);
                      //   },
                      // );
                    },
                    icon: const Icon(
                      Icons.search,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: _searchController.text.isEmpty
                    ? const Center(
                        child: Text('Search For Products'),
                      )
                    : searchProductList.isEmpty
                        ? const Center(
                            child: Text('No Product Found'),
                          )
                        : GridView.builder(
                            controller: ScrollController(),
                            padding: const EdgeInsets.all(
                              5,
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              crossAxisCount: 2,
                              childAspectRatio: 4 / 7,
                            ),
                            itemCount: searchProductList.length,
                            itemBuilder: (context, index) {
                              return ChangeNotifierProvider.value(
                                value: searchProductList[index],
                                child: const ProductItem(),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
