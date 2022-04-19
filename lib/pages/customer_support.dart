import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerSupportPage extends StatelessWidget {
  const CustomerSupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.12),
            child: const Text('Customer Service'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Agro Nepal Customer Service',
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.call),
                        onPressed: () async {
                          await launch("tel://9805344671");
                        },
                        label: const Text(
                          'Call',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Agro Nepal Help Desk',
                      ),
                      ElevatedButton.icon(
                        icon: Icon(Icons.call),
                        onPressed: () async {
                          await launch("tel://9808880359");
                        },
                        label: const Text(
                          'Call',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                '@agroNepal',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
