import 'package:final_year_project/pages/search_page.dart';
import 'package:final_year_project/widgets/assets.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        8,
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, SearchPage.routeName);
        },
        child: Container(
          height: 50,
          padding: const EdgeInsets.only(
            left: 15,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Assets.primaryColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(
              25,
            ),
          ),
          child: Row(
            children: const [
              Icon(
                Icons.search,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'What are you looking for?',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
