import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:erp_aspire/Routes/Router.dart' as Router;
import 'package:erp_aspire/Utils/appConstants.dart';
import 'package:erp_aspire/provider/authenticationProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quiver/strings.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../../constants.dart';

class loginscreenWeb extends StatelessWidget {
  const loginscreenWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    bool _showPassword = false;

    return Consumer<authenticationProvider>(
        builder: (context, provider, child) {
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: bgColor,
        body: SizedBox(
          height: height,
          width: width,
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: secondaryColor,
            margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 100),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 60, horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: (width / 3) - 50,
                    height: height - height / 2,
                    child: SvgPicture.asset(loginSvg),
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  SizedBox(
                    width: (width / 3) - 50,
                    height: height - height / 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                            height: 150,
                            width: 200,
                            child: Image.asset(
                              logo512,
                              fit: BoxFit.cover,
                            )),
                        Column(
                          children: [
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (input) => isValidPassword(input!)
                                  ? null
                                  : "Please enter at-least 6 digit password",
                              controller: _passwordController,
                              decoration: InputDecoration(
                                hintText: 'Enter your password',
                                // helperText: 'helper',
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.password),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    // setState(() {
                                    //   _showPassword = !_showPassword;
                                    // });
                                  },
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.4),
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
                                          validator: (value) =>
                                              isEmailValidae(value!)
                                                  ? null
                                                  : "Please enter valid email",
                                        ),
                                      ],
                                    );
                                    if (text == null) {
                                    } else if (text.length > 0) {
                                      showOkAlertDialog(
                                        context: context,
                                        title: 'Email has been sent',
                                        message:
                                            'Password recovery email has been sent to your email address.',
                                      );
                                      FirebaseAuth.instance
                                          .sendPasswordResetEmail(
                                              email: text[0]);
                                    }
                                  },
                                  child: Text("Forget password.?")),
                            )
                          ],
                        ),
                        SizedBox(
                          width: (width / 3) - 100,
                          height: 45,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            padding: EdgeInsets.all(8.0),
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
                                      .then((value) {
                                    if (provider.isUserLoggedIn) {
                                      provider.mSaveUserLocal(
                                          _emailController.text,
                                          _passwordController.text);
                                      // _loginButtonController.success();
                                      Timer(Duration(seconds: 1), () {
                                        final _controller = SidebarXController(
                                            selectedIndex: 0);

                                        Navigator.pushNamed(
                                            context, Router.homepage,
                                            arguments: _controller);
                                      });
                                    } else {
                                      // _loginButtonController.error();
                                      // Timer(Duration(seconds: 1), () {
                                      //   _loginButtonController.reset();
                                      // });
                                      // snackBar(provider.userLoginMessage,
                                      //     _scaffoldKey);
                                      mShowNotificationError(
                                          heading: 'Warning',
                                          message:
                                              "${provider.userLoginMessage}",
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
