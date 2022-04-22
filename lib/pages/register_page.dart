import 'dart:io';

import 'package:final_year_project/models/http_exception.dart';
import 'package:final_year_project/models/register_request_model.dart';
import 'package:final_year_project/services/api_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../config.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  String? email;
  String? password;
  String? fullName;
  String? city;
  String? gender;

  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  RegExp emails = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0XFF32A368),
      body: ProgressHUD(
        child: Form(
          key: globalFormKey,
          child: _registerUI(context),
        ),
        key: UniqueKey(),
        inAsyncCall: isAPIcallProcess,
        opacity: 0.3,
      ),
    ));
  }

  Widget _registerUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blueGrey, Colors.white],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/Hand-leaf.png",
                    width: 100,
                    fit: BoxFit.contain,
                    color: Colors.green,
                  ),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 30, top: 50),
            child: Text(
              "Register",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "FullName",
              "FullName",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "FullName can't be empty.";
                }
                return null;
              },
              (onSavedVal) {
                fullName = onSavedVal;
              },
              showPrefixIcon: true,
              prefixIcon: const Icon(Icons.person),
              prefixIconPaddingLeft: 5,
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "city",
              "City",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "City can't be empty.";
                }
                return null;
              },
              (onSavedVal) {
                city = onSavedVal;
              },
              showPrefixIcon: true,
              prefixIcon: const Icon(Icons.location_city),
              prefixIconPaddingLeft: 5,
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 5,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 10),
          //   child: FormHelper.inputFieldWidget(
          //     context,
          //     "gender",
          //     "Gender",
          //     (onValidateVal) {
          //       if (onValidateVal.isEmpty) {
          //         return "Gender can\'t be empty.";
          //       }
          //       return null;
          //     },
          //     (onSavedVal) {
          //       gender = onSavedVal;
          //     },
          //     showPrefixIcon: true,
          //     prefixIcon: const Icon(Icons.person),
          //     prefixIconPaddingLeft: 5,
          //     borderFocusColor: Colors.white,
          //     prefixIconColor: Colors.white,
          //     borderColor: Colors.white,
          //     textColor: Colors.white,
          //     hintColor: Colors.white.withOpacity(0.7),
          //     borderRadius: 5,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "email",
              "Email",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "Please enter an Email";
                } else {
                  if (!emails.hasMatch(onValidateVal)) {
                    return 'Enter valid email';
                  } else {
                    return null;
                  }
                }
              },
              (onSavedVal) {
                email = onSavedVal;
              },
              showPrefixIcon: true,
              prefixIconPaddingLeft: 5,
              prefixIcon: const Icon(Icons.email),
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "password",
              "Password",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Please enter password';
                } else {
                  if (!regex.hasMatch(onValidateVal)) {
                    return 'Enter valid password';
                  } else {
                    return null;
                  }
                }
              },
              (onSavedVal) {
                password = onSavedVal;
              },
              showPrefixIcon: true,
              prefixIcon: const Icon(Icons.vpn_key),
              prefixIconPaddingLeft: 5,
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 5,
              obscureText: hidePassword,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
                color: Colors.white.withOpacity(0.7),
                icon: Icon(
                    hidePassword ? Icons.visibility_off : Icons.visibility),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton("Register", () async {
              if (validateAndSave()) {
                setState(() {
                  isAPIcallProcess = true;
                });

                RegisterRequestModel model = RegisterRequestModel(
                  email: email!,
                  password: password!,
                  fullName: fullName!,
                  city: city!,
                  // gender: gender!,
                );

                try {
                  await APIService.register(model);
                  FormHelper.showSimpleAlertDialog(
                    context,
                    Config.appName,
                    "Registration Successful. Please Login",
                    "OK",
                    () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login', (route) => false);
                    },
                  );
                } on HttpException catch (e) {
                  FormHelper.showSimpleAlertDialog(
                      context, Config.appName, e.toString(), "OK", () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/register', (route) => false);
                  });
                } on SocketException catch (_) {
                  FormHelper.showSimpleAlertDialog(
                      context, Config.appName, "No Internet Connection", "OK",
                      () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/register', (route) => false);
                  });
                } catch (e) {
                  FormHelper.showSimpleAlertDialog(
                      context, Config.appName, "Something went Wrong", "OK",
                      () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/register', (route) => false);
                  });
                }
              } else {
                FormHelper.showSimpleAlertDialog(
                    context, Config.appName, "Fill the Fields", "OK", () {
                  Navigator.pop(context);
                });
              }
              setState(() {
                isAPIcallProcess = false;
              });
            },
                btnColor: const Color(0XFF32A368),
                borderColor: Colors.white,
                txtColor: Colors.white,
                borderRadius: 10),
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              "OR",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(right: 25.0, top: 10),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                  children: <TextSpan>[
                    const TextSpan(
                        text: "Already have an account?",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    TextSpan(
                        text: 'Sign In',
                        style: const TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, "/login");
                          })
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
