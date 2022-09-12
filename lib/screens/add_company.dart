import 'dart:async';

import 'package:erp_aspire/Utils/appConstants.dart';
import 'package:erp_aspire/provider/company_provider.dart';
import 'package:erp_aspire/screens/dashboard/components/header.dart';
import 'package:erp_aspire/widgets/regularWidgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../constants.dart';
import '../../responsive.dart';

class AddCompany extends StatefulWidget {
  const AddCompany({Key? key}) : super(key: key);

  @override
  State<AddCompany> createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {
  uploadImage() async {
    if (kIsWeb) {
      PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
      );
      var f = await pickedFile!.readAsBytes();
      Provider.of<CompanyProvider>(context, listen: false)
          .setCompanyImage(webImage: f, image: pickedFile);
    } else {
      print("NO PERMISSION");
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      margin: const EdgeInsets.all(20),
      child: Scaffold(
        body: SafeArea(
            child: Container(
          height: height,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: SafeArea(
            child: Consumer<CompanyProvider>(
                builder: (context, companyProvider, _child) =>
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Header(
                            title: 'Add Company Details',
                          ),
                          const SizedBox(height: defaultPadding),
                          ///////FORM WIDTH WILL BE FULL IN MOBILE VIEW AND HALF IN THE DESKTOP VIEW.
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              (Responsive.isMobile(context))
                                  ? Expanded(
                                      flex: 5,
                                      child: Column(
                                        children: [
                                          (companyProvider.companyImage == null)
                                              ? SizedBox(
                                                  height: 150,
                                                  width: 150,
                                                  child: Image.asset(
                                                      "assets/images/placeholder.png"))
                                              : (kIsWeb)
                                                  ? SizedBox(
                                                      height: 150,
                                                      width: 200,
                                                      child: Image.memory(
                                                          companyProvider
                                                              .webImage))
                                                  : SizedBox(
                                                      height: 150,
                                                      width: 200,
                                                      child: Image.memory(
                                                          companyProvider
                                                              .webImage)),
                                          const SizedBox(
                                              height: defaultPadding),
                                          SizedBox(
                                            width: 100,
                                            height: 30,
                                            child: MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              color: primaryColor,
                                              onPressed: () => uploadImage(),
                                              child: const Text(
                                                "Pick image",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                              height: defaultPadding),
                                          TextFormField(
                                            controller: companyProvider
                                                .companyNameController,
                                            decoration: inputdecoration(
                                                label: 'Product Name'),
                                          ),
                                          const SizedBox(
                                              height: defaultPadding),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                width: 150,
                                                child: RoundedLoadingButton(
                                                  borderRadius: 12,
                                                  controller: companyProvider
                                                      .btnController,
                                                  color: primaryColor,
                                                  onPressed: () async {
                                                    if (companyProvider
                                                            .companyNameController
                                                            .text
                                                            .isNotEmpty &&
                                                        companyProvider
                                                                .companyImage !=
                                                            null) {
                                                      companyProvider
                                                          .uploadCompanyData(
                                                              ctx: context,
                                                              companyName:
                                                                  companyProvider
                                                                      .companyNameController
                                                                      .text);
                                                    } else {
                                                      companyProvider
                                                          .btnController
                                                          .error();
                                                      mShowNotificationError(
                                                          heading: "Warning",
                                                          context: context,
                                                          message:
                                                              "Please fill all required fields");
                                                      Timer(
                                                          const Duration(
                                                              milliseconds:
                                                                  500), () {
                                                        companyProvider
                                                            .btnController
                                                            .reset();
                                                      });
                                                    }
                                                  },
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      "Upload",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ))
                                  : Container(),
                              if (!Responsive.isMobile(context))
                                const SizedBox(width: defaultPadding),
                              // On Mobile means if the screen is less than 850 we dont want to show it
                              if (!Responsive.isMobile(context))
                                Center(
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width > 500
                                            ? 350
                                            : MediaQuery.of(context).size.width,
                                    child:
                                        // SizedBox()
                                        Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Add Company Details",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor),
                                        ),
                                        SizedBox(
                                          height: height / 1.25,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                (companyProvider.companyImage ==
                                                        null)
                                                    ? SizedBox(
                                                        height: 150,
                                                        width: 150,
                                                        child: Image.asset(
                                                            "assets/images/placeholder.png"))
                                                    : (kIsWeb)
                                                        ? SizedBox(
                                                            height: 150,
                                                            width: 200,
                                                            child: Image.memory(
                                                                companyProvider
                                                                    .webImage))
                                                        : SizedBox(
                                                            height: 150,
                                                            width: 200,
                                                            child: Image.memory(
                                                                companyProvider
                                                                    .webImage)),
                                                const SizedBox(
                                                    height: defaultPadding),
                                                SizedBox(
                                                  width: 100,
                                                  height: 30,
                                                  child: MaterialButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    color: primaryColor,
                                                    onPressed: () =>
                                                        uploadImage(),
                                                    child: const Text(
                                                      "Pick image",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                    height: defaultPadding),
                                                TextFormField(
                                                  controller: companyProvider
                                                      .companyNameController,
                                                  decoration: inputdecoration(
                                                      label: 'Company Name'),
                                                ),
                                                const SizedBox(
                                                    height: defaultPadding),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    SizedBox(
                                                      width: 150,
                                                      child:
                                                          RoundedLoadingButton(
                                                        borderRadius: 12,
                                                        controller:
                                                            companyProvider
                                                                .btnController,
                                                        color: primaryColor,
                                                        onPressed: () async {
                                                          companyProvider
                                                              .ismShopsDataUploading(
                                                                  true);

                                                          if (companyProvider
                                                                  .companyNameController
                                                                  .text
                                                                  .isNotEmpty &&
                                                              companyProvider
                                                                      .companyImage !=
                                                                  null) {
                                                            companyProvider.uploadCompanyData(
                                                                companyName:
                                                                    companyProvider
                                                                        .companyNameController
                                                                        .text,
                                                                ctx: context);
                                                            mShowNotification(
                                                                heading:
                                                                    "Success",
                                                                context:
                                                                    context,
                                                                message:
                                                                    "Shop added successfully");
                                                            companyProvider
                                                                .btnController
                                                                .success();
                                                            // companyProvider
                                                            //     .getMyCompany()
                                                            //     .then((_) {
                                                            // });
                                                            Timer(
                                                                const Duration(
                                                                    milliseconds:
                                                                        600),
                                                                () {
                                                              companyProvider
                                                                  .btnController
                                                                  .reset();
                                                            });
                                                          } else {
                                                            companyProvider
                                                                .btnController
                                                                .error();
                                                            mShowNotificationError(
                                                                heading:
                                                                    "Warning",
                                                                context:
                                                                    context,
                                                                message:
                                                                    "Please fill all required fields");
                                                            Timer(
                                                                const Duration(
                                                                    milliseconds:
                                                                        500),
                                                                () {
                                                              companyProvider
                                                                  .btnController
                                                                  .reset();
                                                            });
                                                            companyProvider
                                                                .ismShopsDataUploading(
                                                                    true);
                                                          }
                                                        },
                                                        child: const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(
                                                            "Upload",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    )),
          ),
        )),
      ),
    );
  }
}
