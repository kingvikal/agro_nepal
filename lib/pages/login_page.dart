import 'dart:io';

import 'package:final_year_project/config.dart';
import 'package:final_year_project/models/http_exception.dart';
import 'package:final_year_project/models/login_request_model.dart';
import 'package:final_year_project/services/api_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  String? email;
  String? password;

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
          child: _loginUI(context),
        ),
        key: UniqueKey(),
        inAsyncCall: isAPIcallProcess,
        opacity: 0.3,
      ),
    ));
  }

  Widget _loginUI(BuildContext context) {
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
              "Login",
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
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 25.0, top: 10),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Forget Password ?',
                        style: const TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()..onTap = () {})
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton("Login", () async {
              if (validateAndSave()) {
                setState(() {
                  isAPIcallProcess = true;
                });

                LoginRequestModel model = LoginRequestModel(
                  email: email!,
                  password: password!,
                );

                try {
                  await APIService.login(model).then((_) => {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/home', (route) => false),
                      });
                } on FormatException catch (_) {
                  FormHelper.showSimpleAlertDialog(
                      context, Config.appName, "Password Not Match", "OK", () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/login', (route) => false);
                  });
                } on HttpException catch (e) {
                  FormHelper.showSimpleAlertDialog(
                      context, Config.appName, e.toString(), "OK", () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/login', (route) => false);
                  });
                } on SocketException catch (_) {
                  FormHelper.showSimpleAlertDialog(
                      context, Config.appName, "No Internet Connection", "OK",
                      () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/login', (route) => false);
                  });
                } catch (e) {
                  FormHelper.showSimpleAlertDialog(
                      context, Config.appName, "Something Went Wrong", "OK",
                      () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/login', (route) => false);
                  });
                }
              }
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
                        text: "Dont`t have an account?",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    TextSpan(
                        text: 'Sign Up',
                        style: const TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, "/register");
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
