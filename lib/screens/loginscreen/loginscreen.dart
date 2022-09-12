import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:erp_aspire/Routes/Router.dart' as Router;
import 'package:erp_aspire/adativeScreen/screentypeLayout.dart';
import 'package:erp_aspire/screens/loginscreen/widgets/loginscreenWeb.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiver/strings.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../Provider/money_provider.dart';
import '../../Utils/appConstants.dart';
import '../../constants.dart';
import '../../provider/authenticationProvider.dart';
import '../../provider/company_provider.dart';
import '../add_company.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({Key? key}) : super(key: key);

  @override
  _loginscreenState createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  @override
  Widget build(BuildContext context) {
    return screentypeLayout(
      web: const loginscreenWeb(),
      mobile: loginscreenMobile(),
    );
  }
}

class loginscreenMobile extends StatefulWidget {
  loginscreenMobile({Key? key}) : super(key: key);

  @override
  State<loginscreenMobile> createState() => _loginscreenMobileState();
}

class _loginscreenMobileState extends State<loginscreenMobile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<authenticationProvider>(
        builder: (context, provider, child) {
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: bgColor,
        body: SingleChildScrollView(
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: secondaryColor,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 150,
                      width: 150,
                      child: Image.asset(
                        logo512,
                        fit: BoxFit.cover,
                      )),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (input) => isEmailValidae(input!)
                            ? null
                            : "Please enter valid email",
                        controller: _emailController,
                        decoration: InputDecoration(
                          enabled: true,
                          hintText: 'Enter your email address',
                          // helperText: 'helper',
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          // suffixIcon: Icon(Icons.park),
                          // counterText: 'counter',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (input) => isValidPassword(input!)
                            ? null
                            : "Please enter at-least 6 digit password",
                        controller: _passwordController,
                        obscureText: _showPassword,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          // helperText: 'helper',
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            color:
                                Theme.of(context).accentColor.withOpacity(0.4),
                            icon: Icon(_showPassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () async {
                              final text = await showTextInputDialog(
                                context: context,
                                textFields: [
                                  DialogTextField(
                                    hintText: 'Please enter your email',
                                    validator: (value) => isEmailValidae(value!)
                                        ? null
                                        : "Please enter valid email",
                                  ),
                                ],
                              );
                              if (text == null) {
                              } else if (text.isNotEmpty) {
                                showOkAlertDialog(
                                  context: context,
                                  title: 'Email has been sent',
                                  message:
                                      'Password recovery email has been sent to your email address.',
                                );
                                FirebaseAuth.instance
                                    .sendPasswordResetEmail(email: text[0]);
                              }
                            },
                            child: const Text("Forget password.?")),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 45,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      color: primaryColor,
                      onPressed: () {
                        if (isBlank(_emailController.text) ||
                            isBlank(_passwordController.text)) {
                          // // _loginButtonController.reset();
                          // snackBar("Please Fill All Input Fields",
                          //     _scaffoldKey);

                          mShowNotificationError(
                              heading: 'Warning',
                              message: "Please Fill All Input Fields",
                              context: context);
                        } else {
                          bool emailValid =
                              isEmailValidae(_emailController.text);
                          bool passcodeValid =
                              isValidPassword(_passwordController.text);

                          if (emailValid && passcodeValid) {
                            provider
                                .loginUser(_emailController.text,
                                    _passwordController.text)
                                .then((value) async {
                              if (provider.isUserLoggedIn) {
                                // provider.mSaveUserLocal(_emailController.text,
                                //     _passwordController.text);
                                // _loginButtonController.success();
                                // Timer(const Duration(seconds: 0), () {
                                final _controller =
                                    SidebarXController(selectedIndex: 0);

                                Provider.of<CompanyProvider>(context,
                                        listen: false)
                                    .getMyCompany()
                                    .then((_) {
                                  if (Provider.of<CompanyProvider>(context,
                                              listen: false)
                                          .myCompanyData !=
                                      null) {
                                    Provider.of<MoneyProvider>(context,
                                            listen: false)
                                        .getTransactions()
                                        .then((_) {
                                      Navigator.pushReplacementNamed(
                                          context, Router.homepage,
                                          arguments: _controller);
                                    });
                                  } else {
                                    Provider.of<MoneyProvider>(context,
                                            listen: false)
                                        .getTransactions()
                                        .then((_) {
                                      Future.delayed(
                                          const Duration(milliseconds: 800),
                                          () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AddCompany()));
                                      });
                                    });
                                  }
                                });

                                Provider.of<MoneyProvider>(context,
                                        listen: false)
                                    .getTransactions()
                                    .then((_) {
                                  Navigator.pushReplacementNamed(
                                      context, Router.homepage,
                                      arguments: _controller);
                                });
                                // });
                              } else {
                                // _loginButtonController.error();
                                // Timer(Duration(seconds: 1), () {
                                //   _loginButtonController.reset();
                                // });
                                // snackBar(provider.userLoginMessage,
                                //     _scaffoldKey);
                                mShowNotificationError(
                                    heading: 'Warning',
                                    message: provider.userLoginMessage,
                                    context: context);
                              }
                            }).onError((error, stackTrace) {
                              // _loginButtonController.error();
                              // snackBar(
                              //     "Something went wrong please try again",
                              //     _scaffoldKey);

                              mShowNotificationError(
                                  heading: 'Error',
                                  message:
                                      "Something went wrong please try again",
                                  context: context);

                              // Timer(Duration(seconds: 1), () {
                              //   _loginButtonController.reset();
                              // });
                            });
                          } else {
                            // _loginButtonController.error();
                            mShowNotificationError(
                                heading: 'Warning',
                                message:
                                    "Please enter valid email address and passowrd",
                                context: context);
                            // snackBar(
                            //     "Please enter valid email address and passowrd",
                            //     _scaffoldKey);
                            // Timer(Duration(seconds: 1), () {
                            //   _loginButtonController.reset();
                            // });
                          }
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: bgColor),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
