import 'package:final_year_project/services/shared_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  static const routeName = '/userProfile';

  @override
  State<UserProfile> createState() => UserProfileState();
}

class UserProfileState extends State<UserProfile> {
  Widget textWidget(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }

  Widget sizedBox5() {
    return const SizedBox(
      height: 5,
    );
  }

  Widget isEditableButtons() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.redAccent,
              ),
            ),
            onPressed: () {},
            child: const Text('Cancel'),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Save Changes'),
          ),
        ),
      ],
    );
  }

  bool isEditable = false;

  final _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2),
            child: const Text('My Profile'),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _globalKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isEditable = true;
                          });
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  ),
                  textWidget(
                    'Full Name',
                  ),
                  sizedBox5(),
                  TextFormField(
                    initialValue: SharedService.name,
                    enabled: isEditable ? true : false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  textWidget(
                    'City',
                  ),
                  sizedBox5(),
                  TextFormField(
                    initialValue: SharedService.city,
                    enabled: isEditable ? true : false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  textWidget(
                    'Joined At',
                  ),
                  sizedBox5(),
                  TextFormField(
                    initialValue:
                        DateFormat('yyyy-MM-dd').format(SharedService.dateTime),
                    enabled: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                      ),
                    ),
                  ),
                  if (isEditable) isEditableButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
