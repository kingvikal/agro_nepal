import 'package:final_year_project/models/product_model.dart';
import 'package:final_year_project/pages/product_detail_page.dart';
import 'package:final_year_project/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
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

  @override
  Widget build(BuildContext context) {
    final productItem = Provider.of<ProductModel>(context);
    final cartData = Provider.of<CartItems>(context);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailPage.routeName,
          arguments: productItem.id,
        );
      },
      child: Card(
        elevation: 3,
        child: Container(
          // height: 280,
          // width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              15,
            ),
            color: const Color(0XFF32A368).withOpacity(0.4),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          15,
                        ),
                        topRight: Radius.circular(15)),
                  ),
                  width: double.infinity,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(
                          5,
                        ),
                        topLeft: Radius.circular(
                          5,
                        ),
                      ),
                      child: FadeInImage(
                        placeholder:
                            const AssetImage('assets/images/loading1.gif'),
                        image: NetworkImage(
                          productItem.imageUrl,
                        ),
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        productItem.title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                      ),
                      child: Row(
                        children: [
                          const Text('NPR.'),
                          Text(
                            productItem.price.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        bottom: 5,
                      ),
                      child: Row(
                        children: [
                          const Text(
                            'NPR.',
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough),
                          ),
                          Text(
                            (productItem.price * 1.5).toInt().toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          print('rino');

                          cartData.addCartItem(
                            productItem.id.toString(),
                            productItem.title,
                            productItem.price.toDouble(),
                            productItem.imageUrl,
                          );
                          showSnackBar();
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.shopping_cart,
                                color: Colors.green,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'ADD TO CART',
                                style: TextStyle(color: Colors.green),
                              )
                            ],
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(
                                15,
                              ),
                              bottomRight: Radius.circular(
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
    );
  }
}
