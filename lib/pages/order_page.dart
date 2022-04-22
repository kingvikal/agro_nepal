import 'package:final_year_project/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  static const routeName = '/orderPage';

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  // @override
  // void initState() {
  //   Provider.of<OrderProvider>(context, listen: false).getOrders();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Orders',
          ),
        ),
        body: FutureBuilder(
          future:
              Provider.of<OrderProvider>(context, listen: false).getOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Consumer<OrderProvider>(
                builder: (ctx, orderData, child) {
                  if (orderData.orders.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 13,
                      ),
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await Provider.of<OrderProvider>(context,
                                  listen: false)
                              .getOrders();
                        },
                        child: ListView.builder(
                          controller: ScrollController(),
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: orderData.orders.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: 5,
                              ),
                              child: Container(
                                height: 80,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(
                                    0.4,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Item Quantity',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          orderData.orders[i].quantity
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Total Price',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          orderData.orders[i].price.toString(),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Payment Status',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        if (orderData.orders[i].paymentStatus ==
                                            'paid')
                                          SizedBox(
                                            height: 30,
                                            child: ElevatedButton.icon(
                                              icon: const Icon(
                                                Icons.check_circle,
                                              ),
                                              onPressed: () {},
                                              label: const Text(
                                                'Paid',
                                              ),
                                            ),
                                          ),
                                        if (orderData.orders[i].paymentStatus ==
                                            'unpaid')
                                          Row(
                                            children: [
                                              SizedBox(
                                                height: 30,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(
                                                      Colors.purple.withOpacity(
                                                        0.6,
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    print(
                                                        'move to payment page');
                                                  },
                                                  child: const Text(
                                                    'Pay',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('No Orders Till Date.'),
                    );
                  }
                },
              );
            } else {
              print(snapshot.error.toString());
              return Center(
                child: Text(
                  snapshot.error.toString(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
