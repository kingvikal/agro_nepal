import 'package:flutter/material.dart';

class SlidingWidget extends StatelessWidget {
  const SlidingWidget({
    Key? key,
    required PageController pageController,
  })  : _pageController = pageController,
        super(key: key);

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.amber,
      child: PageView(
        controller: _pageController,
        children: const [
          FadeInImage(
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/images/loading1.gif'),
            image: NetworkImage(
                'https://fruitvalleys.com/wp-content/uploads/2021/07/Buy-Grocery-Get-Discount-1024x512.png'),
          ),
          FadeInImage(
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/images/loading1.gif'),
            image: NetworkImage(
                'https://solisworld.com/wp-content/uploads/2020/01/compact.jpg'),
          ),
          FadeInImage(
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/images/loading1.gif'),
            image: NetworkImage(
                'https://png.pngtree.com/png-clipart/20190328/ourlarge/pngtree-summer-fruits-sale-big-discount-offers-banner-png-image_890773.jpg'),
          ),
        ],
      ),
    );
  }
}
