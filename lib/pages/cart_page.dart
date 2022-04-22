import 'package:final_year_project/providers/cart_provider.dart';
import 'package:final_year_project/providers/order_provider.dart';
import 'package:final_year_project/widgets/assets.dart';
import 'package:final_year_project/widgets/cart_item.dart' as ci;
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  static const routeName = '/cartPage';

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // @override
  // void initState() {

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartItems>(context, listen: true);
    final orderData = Provider.of<OrderProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Assets.primaryColor,
          title: const Text(
            'My Cart',
          ),
        ),
        body: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(
                15,
              ),
              child: Padding(
                padding: const EdgeInsets.all(
                  8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total'),
                    const Spacer(),
                    Consumer<CartItems>(
                      builder: (BuildContext context, value, Widget? child) {
                        return Chip(
                          label: Text(
                            'Rs. ${cartData.totalPrice}',
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    TheOrderButton(
                      cartData: cartData,
                      // orderData: orderData,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: cartData.cartItems.isEmpty
                  ? const Center(
                      child: Text('No items added to the cart.'),
                    )
                  : ListView.builder(
                      controller: ScrollController(),
                      itemCount: cartData.cartItems.length,
                      itemBuilder: (ctx, i) {
                        return ci.CartItem(
                          cartData.cartItems.values.toList()[i].id,
                          cartData.cartItems.keys.toList()[i],
                          cartData.cartItems.values.toList()[i].title,
                          cartData.cartItems.values.toList()[i].imageUrl,
                          cartData.cartItems.values.toList()[i].quantity,
                          cartData.cartItems.values.toList()[i].price,
                        );
                      },
                    ),
            ),
            if (cartData.cartItems.isNotEmpty)
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Assets.primaryColor),
                  ),
                  onPressed: () {
                    cartData.clearCart();
                  },
                  child: const Text('Clear your Cart'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class TheOrderButton extends StatefulWidget {
  const TheOrderButton({
    Key? key,
    required this.cartData,
    // required this.orderData,
  }) : super(key: key);

  final CartItems cartData;
  // final Orders orderData;

  @override
  State<TheOrderButton> createState() => _TheOrderButtonState();
}

class _TheOrderButtonState extends State<TheOrderButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.cartData.itemCount <= 0
          ? null
          : () async {
              setState(() {
                isLoading = true;
              });
              await Provider.of<OrderProvider>(context, listen: false)
                  .addOrder(
                widget.cartData.totalPrice.toInt(),
                PaymentStatus.unpaid,
                widget.cartData.itemCount,
              )
                  .then((_) {
                widget.cartData.clearCart();
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return Dialog(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 80,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Your Order has been placed.',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Check your orders for more details.',
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Pay Later',
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        Colors.purple.withOpacity(0.6),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      'Pay Now',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).catchError((_) {
                setState(() {
                  isLoading = false;
                });
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: const Text('An error occurred!'),
                      content: const Text(
                        'Please check your Internet Connection.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Okay'),
                        ),
                      ],
                    );
                  },
                );
              });
              setState(() {
                isLoading = false;
              });
            },
      child: isLoading
          ? const SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                color: Colors.blueGrey,
                strokeWidth: 2,
              ),
            )
          : const Text('Order Now'),
    );
  }
}
