import 'dart:async';
import 'dart:developer';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:erp_aspire/Routes/Router.dart' as Router;
import 'package:erp_aspire/Utils/appConstants.dart';
import 'package:erp_aspire/provider/authenticationProvider.dart';
import 'package:erp_aspire/provider/company_provider.dart';
import 'package:erp_aspire/screens/add_company.dart';
import 'package:erp_aspire/screens/add_my_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quiver/strings.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../../Provider/money_provider.dart';
import '../../../constants.dart';
import '../../../provider/addRetailerProvider.dart';
import '../../../provider/homeProvider.dart';
import '../../../provider/userProvider.dart';

class loginscreenWeb extends StatefulWidget {
  const loginscreenWeb({Key? key}) : super(key: key);

  @override
  State<loginscreenWeb> createState() => _loginscreenWebState();
}

class _loginscreenWebState extends State<loginscreenWeb> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = true;

  addRetailerProvider? retailerProvider;
  userProvider? userprovider;
  homepage_provider? homeprovider;
  CompanyProvider? companyProvider;

  mInIt(BuildContext context) {
    homeprovider = Provider.of<homepage_provider>(context, listen: false);
    retailerProvider = Provider.of<addRetailerProvider>(context, listen: false);
    userprovider = Provider.of<userProvider>(context, listen: false);
    companyProvider = Provider.of<CompanyProvider>(context, listen: false);

    homeprovider!.getOrdersDataList();
    retailerProvider!.mGetLocationPermission().then((value) {
      retailerProvider!.mSetCurrentLocation();
    });
    companyProvider!.getMyCompany();
    userprovider!.mGetUserDetails().then((value) {
      userprovider!.mGetAllUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
              margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 50),
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
                                prefixIcon: const Icon(Icons.email),
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
                              obscureText: _showPassword,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                hintText: 'Enter your password',
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.password),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _showPassword = !_showPassword;
                                    });
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
                                    } else if (text.isNotEmpty) {
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
                                  child: const Text("Forget password.?")),
                            )
                          ],
                        ),
                        provider.isUserLoggedIn
                            ? const Align(
                                alignment: Alignment.bottomRight,
                                child: SizedBox(
                                    height: 35,
                                    width: 35,
                                    child: CircularProgressIndicator()),
                              )
                            : SizedBox(
                                width: (width / 3) - 100,
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
                                          message:
                                              "Please Fill All Input Fields",
                                          context: context);
                                    } else {
                                      bool emailValid =
                                          isEmailValidae(_emailController.text);
                                      bool passcodeValid = isValidPassword(
                                          _passwordController.text);

                                      if (emailValid && passcodeValid) {
                                        provider
                                            .loginUser(_emailController.text,
                                                _passwordController.text)
                                            .then((value) {
                                          if (provider.isUserLoggedIn) {
                                            provider.mSaveUserLocal(
                                                _emailController.text,
                                                _passwordController.text);

                                            Provider.of<userProvider>(context,
                                                    listen: false)
                                                .isUserAvailable()
                                                .then((_) {
                                              if (Provider.of<userProvider>(
                                                      context,
                                                      listen: false)
                                                  .userAvailable) {
                                                mInIt(context);
                                                Provider.of<userProvider>(
                                                        context,
                                                        listen: false)
                                                    .mGetUserDetails()
                                                    .then((value) {
                                                  Provider.of<userProvider>(
                                                          context,
                                                          listen: false)
                                                      .current_user;

                                                  Provider.of<homepage_provider>(
                                                          context,
                                                          listen: false)
                                                      .getOrdersDataList()
                                                      .then((_) {
                                                    Provider.of<CompanyProvider>(
                                                            context,
                                                            listen: false)
                                                        .getMyCompany()
                                                        .then((_) {
                                                      Timer(
                                                          const Duration(
                                                              seconds: 1), () {
                                                        final _controller =
                                                            SidebarXController(
                                                                selectedIndex:
                                                                    0);
                                                        if (companyProvider!
                                                                .myCompanyData !=
                                                            null) {
                                                          Provider.of<MoneyProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .getTransactions()
                                                              .then((_) {
                                                            Navigator.pushNamed(
                                                                context,
                                                                Router.homepage,
                                                                arguments:
                                                                    _controller);
                                                          });
                                                        } else {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const AddCompany()));
                                                        }
                                                      });
                                                    });
                                                  });
                                                });
                                              } else {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const AddMyInfo()));
                                              }
                                            });
                                          } else {
                                            mShowNotificationError(
                                                heading: 'Warning',
                                                message:
                                                    provider.userLoginMessage,
                                                context: context);
                                          }
                                        }).onError((error, stackTrace) {
                                          log(error.toString() +
                                              '        ]]     ' +
                                              stackTrace.toString());
                                          mShowNotificationError(
                                              heading: 'Error',
                                              message:
                                                  "Something went wrong please try again" +
                                                      error.toString() +
                                                      '      ' +
                                                      stackTrace.toString(),
                                              context: context);
                                        });
                                      } else {
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
