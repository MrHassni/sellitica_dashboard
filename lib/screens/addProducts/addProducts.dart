import 'dart:async';

import 'package:erp_aspire/Utils/appConstants.dart';
import 'package:erp_aspire/provider/productsProvider.dart';
import 'package:erp_aspire/screens/dashboard/components/header.dart';
import 'package:erp_aspire/screens/main/components/side_menu.dart';
import 'package:erp_aspire/widgets/regularWidgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../constants.dart';
import '../../responsive.dart';
import '../../shared_prefrences/shared_prefrence_functions.dart';
import '../products_cloud_search.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({Key? key}) : super(key: key);

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  @override
  void initState() {
    Provider.of<ProductsProvider>(context, listen: false).mGetAllProducts();
    getCompany();
    super.initState();
  }

  uploadImage() async {
    if (kIsWeb) {
      PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
      );
      var f = await pickedFile!.readAsBytes();
      Provider.of<ProductsProvider>(context, listen: false)
          .setProductImage(webImage: f, image: pickedFile);
    } else {
      print("NO PERMISSION");
    }
  }

  String? company;
  getCompany() async {
    company = await SharedPreferenceFunctions.getCompanyIDSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: const SideMenu(),
      appBar: width < 1100
          ? AppBar(
              foregroundColor: Colors.black,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text('Manage Products'),
            )
          : PreferredSize(
              child: Container(), preferredSize: const Size.fromHeight(0)),
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.all(20),
        height: height,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Consumer<ProductsProvider>(
            builder: (context, productProvider, _child) =>
                SingleChildScrollView(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      width > 1100
                          ? const Header(
                              title: 'Manage Products',
                            )
                          : Container(),
                      const SizedBox(height: defaultPadding),
                      ///////FORM WIDTH WILL BE FULL IN MOBILE VIEW AND HALF IN THE DESKTOP VIEW.
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Align(
                                //   alignment: Alignment.centerRight,
                                //   child: InkWell(
                                //       onTap: () {
                                //         log(company.toString());
                                //         Navigator.push(
                                //             context,
                                //             MaterialPageRoute(
                                //                 builder: (context) =>
                                //                     CloudFirestoreSearch(
                                //                       company: company!,
                                //                     )));
                                //       },
                                //       child: Card(
                                //         elevation: 5,
                                //         child: Container(
                                //           padding: const EdgeInsets.all(10),
                                //           width: 130,
                                //           decoration: BoxDecoration(
                                //             borderRadius:
                                //                 BorderRadius.circular(15),
                                //           ),
                                //           child: Row(
                                //             children: const [
                                //               Icon(Icons.search),
                                //               Text('Search ')
                                //             ],
                                //           ),
                                //         ),
                                //       )),
                                // ),
                                if (Responsive.isMobile(context))
                                  Column(
                                    children: [
                                      (productProvider.productImage == null)
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
                                                      productProvider.webImage))
                                              : SizedBox(
                                                  height: 150,
                                                  width: 200,
                                                  child: Image.memory(
                                                      productProvider
                                                          .webImage)),
                                      const SizedBox(height: defaultPadding),
                                      SizedBox(
                                        width: 100,
                                        height: 30,
                                        child: MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          color: primaryColor,
                                          onPressed: () => uploadImage(),
                                          child: const Text(
                                            "Pick image",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: defaultPadding),
                                      TextFormField(
                                        controller: productProvider
                                            .productNameController,
                                        decoration: inputdecoration(
                                            label: 'Product Name'),
                                      ),
                                      const SizedBox(height: defaultPadding),
                                      TextFormField(
                                        controller: productProvider
                                            .productCountController,
                                        keyboardType: TextInputType.number,
                                        decoration: inputdecoration(
                                            label: 'Product Quantity'),
                                      ),
                                      const SizedBox(height: defaultPadding),
                                      TextFormField(
                                        controller: productProvider
                                            .productPriceController,
                                        keyboardType: TextInputType.number,
                                        decoration: inputdecoration(
                                            label: 'Product Price'),
                                      ),
                                      const SizedBox(height: defaultPadding),
                                      TextFormField(
                                        maxLines: 5,
                                        controller: productProvider
                                            .productDescriptionController,
                                        decoration: inputdecoration(
                                            label: 'Product Description'),
                                      ),
                                      const SizedBox(height: defaultPadding),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: 150,
                                            child: RoundedLoadingButton(
                                              borderRadius: 12,
                                              controller:
                                                  productProvider.btnController,
                                              color: primaryColor,
                                              onPressed: () async {
                                                if (productProvider
                                                        .productNameController
                                                        .text
                                                        .isNotEmpty &&
                                                    productProvider
                                                        .productPriceController
                                                        .text
                                                        .isNotEmpty &&
                                                    productProvider
                                                        .productCountController
                                                        .text
                                                        .isNotEmpty &&
                                                    productProvider
                                                        .productCountController
                                                        .text
                                                        .isNotEmpty) {
                                                  productProvider.uploadProductData(
                                                      productName: productProvider
                                                          .productNameController
                                                          .text,
                                                      productQuantity:
                                                          productProvider
                                                              .productCountController
                                                              .text,
                                                      productPrice: productProvider
                                                          .productPriceController
                                                          .text,
                                                      productDescription:
                                                          productProvider
                                                              .productDescriptionController
                                                              .text);
                                                } else {
                                                  productProvider.btnController
                                                      .error();
                                                  mShowNotificationError(
                                                      heading: "Warning",
                                                      context: context,
                                                      message:
                                                          "Please fill all required fields");
                                                  Timer(
                                                      const Duration(
                                                          milliseconds: 500),
                                                      () {
                                                    productProvider
                                                        .btnController
                                                        .reset();
                                                  });
                                                }
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
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
                                  ),

                                company == null
                                    ? Container()
                                    : ProductsCloudFirestoreSearch(
                                        company: company!),

                                // ListView.separated(
                                //   shrinkWrap: true,
                                //   // primary: false,
                                //   physics: width > 1100
                                //       ? const BouncingScrollPhysics()
                                //       : const NeverScrollableScrollPhysics(),
                                //   padding:
                                //       const EdgeInsets.symmetric(horizontal: 3),
                                //   // itemCount: 20,
                                //   itemCount: productProvider.allProducts.length,
                                //   scrollDirection: Axis.vertical,
                                //   itemBuilder: (context, index) {
                                //     // List<ShopsProfile> allShops =
                                //     //     Provider.of<shopsProvider>(context,
                                //     //             listen: false)
                                //     //         .shops;
                                //     // int assignedNo = 0;
                                //     // for (int i = 0;
                                //     //     i < allShops.length;
                                //     //     i++) {
                                //     //   if (allShops[i].assignedto.first ==
                                //     //       productProvider
                                //     //           .allProducts[index].email) {
                                //     //     assignedNo++;
                                //     //   }
                                //     // }
                                //
                                //     return Padding(
                                //       padding: const EdgeInsets.symmetric(
                                //           vertical: 5, horizontal: 0),
                                //       child: MaterialButton(
                                //         shape: RoundedRectangleBorder(
                                //             borderRadius:
                                //                 BorderRadius.circular(12)),
                                //         color: Colors.white,
                                //         elevation: 5,
                                //         padding: const EdgeInsets.symmetric(
                                //             horizontal: 20, vertical: 20),
                                //         onPressed: () {},
                                //         child: Row(
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.spaceBetween,
                                //           children: [
                                //             Column(
                                //               mainAxisSize: MainAxisSize.min,
                                //               mainAxisAlignment:
                                //                   MainAxisAlignment.start,
                                //               crossAxisAlignment:
                                //                   CrossAxisAlignment.start,
                                //               children: [
                                //                 Align(
                                //                   child: Text(
                                //                     productProvider
                                //                         .allProducts[index]
                                //                         .productName!,
                                //                     style: const TextStyle(
                                //                         color: Colors.black54,
                                //                         fontWeight:
                                //                             FontWeight.w700),
                                //                   ),
                                //                   alignment:
                                //                       Alignment.centerLeft,
                                //                 ),
                                //                 const SizedBox(
                                //                   height: 5,
                                //                 ),
                                //                 SizedBox(
                                //                   width: MediaQuery.of(context)
                                //                           .size
                                //                           .width *
                                //                       0.5,
                                //                   child: Text(
                                //                     productProvider
                                //                         .allProducts[index]
                                //                         .productDescription!,
                                //                     overflow:
                                //                         TextOverflow.ellipsis,
                                //                     maxLines: 2,
                                //                     style: const TextStyle(
                                //                         color: Colors.grey,
                                //                         fontWeight:
                                //                             FontWeight.w500),
                                //                   ),
                                //                 ),
                                //                 const SizedBox(
                                //                   height: 5,
                                //                 ),
                                //                 width > 450
                                //                     ? Wrap(
                                //                         children: [
                                //                           Container(
                                //                             decoration: BoxDecoration(
                                //                                 color: const Color(
                                //                                         0xFFFFA113)
                                //                                     .withOpacity(
                                //                                         0.1),
                                //                                 borderRadius:
                                //                                     BorderRadius
                                //                                         .circular(
                                //                                             8)),
                                //                             child: Padding(
                                //                               padding:
                                //                                   const EdgeInsets
                                //                                       .all(8.0),
                                //                               child: Text.rich(TextSpan(
                                //                                   text:
                                //                                       'Quantity Available  ',
                                //                                   style: const TextStyle(
                                //                                       fontSize:
                                //                                           12,
                                //                                       color: Color(
                                //                                           0xFFFFA113),
                                //                                       fontWeight:
                                //                                           FontWeight
                                //                                               .w500),
                                //                                   children: <
                                //                                       InlineSpan>[
                                //                                     TextSpan(
                                //                                       text: productProvider
                                //                                           .allProducts[
                                //                                               index]
                                //                                           .productQuantity
                                //                                           .toString(),
                                //                                       style: const TextStyle(
                                //                                           fontSize:
                                //                                               12,
                                //                                           letterSpacing:
                                //                                               0.5,
                                //                                           color: Color(
                                //                                               0xFFFFA113),
                                //                                           fontWeight:
                                //                                               FontWeight.bold),
                                //                                     )
                                //                                   ])),
                                //                             ),
                                //                           ),
                                //                           const SizedBox(
                                //                             width: 15,
                                //                           ),
                                //                           Container(
                                //                             decoration: BoxDecoration(
                                //                                 color: primaryColor
                                //                                     .withOpacity(
                                //                                         0.1),
                                //                                 borderRadius:
                                //                                     BorderRadius
                                //                                         .circular(
                                //                                             8)),
                                //                             child: Padding(
                                //                               padding:
                                //                                   const EdgeInsets
                                //                                       .all(8.0),
                                //                               child: Text.rich(TextSpan(
                                //                                   text:
                                //                                       'Price  ',
                                //                                   style: const TextStyle(
                                //                                       fontSize:
                                //                                           12,
                                //                                       color:
                                //                                           primaryColor,
                                //                                       fontWeight:
                                //                                           FontWeight
                                //                                               .w500),
                                //                                   children: <
                                //                                       InlineSpan>[
                                //                                     TextSpan(
                                //                                       text: productProvider
                                //                                           .allProducts[
                                //                                               index]
                                //                                           .productPrice
                                //                                           .toString(),
                                //                                       // userprovider
                                //                                       //     .allusers[
                                //                                       //         index]
                                //                                       //     .targetshops
                                //                                       //     .toString(),
                                //                                       style: const TextStyle(
                                //                                           fontSize:
                                //                                               12,
                                //                                           letterSpacing:
                                //                                               0.5,
                                //                                           color:
                                //                                               primaryColor,
                                //                                           fontWeight:
                                //                                               FontWeight.bold),
                                //                                     )
                                //                                   ])),
                                //                             ),
                                //                           ),
                                //                         ],
                                //                       )
                                //                     : Column(
                                //                         crossAxisAlignment:
                                //                             CrossAxisAlignment
                                //                                 .start,
                                //                         children: [
                                //                           Container(
                                //                             decoration: BoxDecoration(
                                //                                 color: const Color(
                                //                                         0xFFFFA113)
                                //                                     .withOpacity(
                                //                                         0.1),
                                //                                 borderRadius:
                                //                                     BorderRadius
                                //                                         .circular(
                                //                                             8)),
                                //                             child: Padding(
                                //                               padding:
                                //                                   const EdgeInsets
                                //                                       .all(8.0),
                                //                               child: Text.rich(TextSpan(
                                //                                   text:
                                //                                       'Quantity Available  ',
                                //                                   style: const TextStyle(
                                //                                       fontSize:
                                //                                           12,
                                //                                       color: Color(
                                //                                           0xFFFFA113),
                                //                                       fontWeight:
                                //                                           FontWeight
                                //                                               .w500),
                                //                                   children: <
                                //                                       InlineSpan>[
                                //                                     TextSpan(
                                //                                       text: productProvider
                                //                                           .allProducts[
                                //                                               index]
                                //                                           .productQuantity
                                //                                           .toString(),
                                //                                       style: const TextStyle(
                                //                                           fontSize:
                                //                                               12,
                                //                                           letterSpacing:
                                //                                               0.5,
                                //                                           color: Color(
                                //                                               0xFFFFA113),
                                //                                           fontWeight:
                                //                                               FontWeight.bold),
                                //                                     )
                                //                                   ])),
                                //                             ),
                                //                           ),
                                //                           const SizedBox(
                                //                             height: 15,
                                //                           ),
                                //                           Container(
                                //                             decoration: BoxDecoration(
                                //                                 color: primaryColor
                                //                                     .withOpacity(
                                //                                         0.1),
                                //                                 borderRadius:
                                //                                     BorderRadius
                                //                                         .circular(
                                //                                             8)),
                                //                             child: Padding(
                                //                               padding:
                                //                                   const EdgeInsets
                                //                                       .all(8.0),
                                //                               child: Text.rich(TextSpan(
                                //                                   text:
                                //                                       'Price  ',
                                //                                   style: const TextStyle(
                                //                                       fontSize:
                                //                                           12,
                                //                                       color:
                                //                                           primaryColor,
                                //                                       fontWeight:
                                //                                           FontWeight
                                //                                               .w500),
                                //                                   children: <
                                //                                       InlineSpan>[
                                //                                     TextSpan(
                                //                                       text: productProvider
                                //                                           .allProducts[
                                //                                               index]
                                //                                           .productPrice
                                //                                           .toString(),
                                //                                       // userprovider
                                //                                       //     .allusers[
                                //                                       //         index]
                                //                                       //     .targetshops
                                //                                       //     .toString(),
                                //                                       style: const TextStyle(
                                //                                           fontSize:
                                //                                               12,
                                //                                           letterSpacing:
                                //                                               0.5,
                                //                                           color:
                                //                                               primaryColor,
                                //                                           fontWeight:
                                //                                               FontWeight.bold),
                                //                                     )
                                //                                   ])),
                                //                             ),
                                //                           ),
                                //                         ],
                                //                       ),
                                //               ],
                                //             ),
                                //             Column(
                                //               children: [
                                //                 Row(
                                //                   children: [
                                //                     // SizedBox(
                                //                     //   height: 40,
                                //                     //   width: 40,
                                //                     //   child: MaterialButton(
                                //                     //     onPressed: () {},
                                //                     //     shape: RoundedRectangleBorder(
                                //                     //         borderRadius:
                                //                     //             BorderRadius
                                //                     //                 .circular(
                                //                     //                     10)),
                                //                     //     padding:
                                //                     //         EdgeInsets.zero,
                                //                     //     child: Container(
                                //                     //         // padding: EdgeInsets.all(
                                //                     //         //     defaultPadding *
                                //                     //         //         0.75),
                                //                     //
                                //                     //         height: 40,
                                //                     //         width: 40,
                                //                     //         decoration:
                                //                     //             BoxDecoration(
                                //                     //           color: primaryColor
                                //                     //               .withOpacity(
                                //                     //                   0.1),
                                //                     //           borderRadius: const BorderRadius
                                //                     //                   .all(
                                //                     //               Radius.circular(
                                //                     //                   10)),
                                //                     //         ),
                                //                     //         child:
                                //                     //             const Center(
                                //                     //           child: Icon(
                                //                     //             Icons.edit,
                                //                     //             color:
                                //                     //                 primaryColor,
                                //                     //             size: 17,
                                //                     //           ),
                                //                     //         )
                                //                     //         // SvgPicture.asset(
                                //                     //         //   info.svgSrc!,
                                //                     //         //   color: info.color,
                                //                     //         // ),
                                //                     //         ),
                                //                     //   ),
                                //                     // ),
                                //                     // const SizedBox(
                                //                     //   width: 10,
                                //                     // ),
                                //                     SizedBox(
                                //                       height: 40,
                                //                       width: 40,
                                //                       child: MaterialButton(
                                //                         onPressed: () async {
                                //                           final response =
                                //                               await showOkCancelAlertDialog(
                                //                                   context:
                                //                                       context,
                                //                                   title:
                                //                                       "Are you sure ?",
                                //                                   message:
                                //                                       "You want to delete this product...?");
                                //                           if (response
                                //                                   .toString() ==
                                //                               "OkCancelResult.ok") {
                                //                             if (kDebugMode) {
                                //                               // print(userprovider
                                //                               //     .allusers[
                                //                               //         index]
                                //                               //     .id);
                                //
                                //                               productProvider.mDeleteProducts(
                                //                                   productProvider
                                //                                       .allProducts[
                                //                                           index]
                                //                                       .id!);
                                //                             }
                                //                           }
                                //                         },
                                //                         shape: RoundedRectangleBorder(
                                //                             borderRadius:
                                //                                 BorderRadius
                                //                                     .circular(
                                //                                         10)),
                                //                         padding:
                                //                             EdgeInsets.zero,
                                //                         child: Container(
                                //                             // padding: EdgeInsets.all(
                                //                             //     defaultPadding *
                                //                             //         0.75),
                                //
                                //                             height: 40,
                                //                             width: 40,
                                //                             decoration:
                                //                                 BoxDecoration(
                                //                               color: Colors.red
                                //                                   .withOpacity(
                                //                                       0.1),
                                //                               borderRadius:
                                //                                   const BorderRadius
                                //                                           .all(
                                //                                       Radius.circular(
                                //                                           10)),
                                //                             ),
                                //                             child: const Center(
                                //                               child: Icon(
                                //                                 Icons.delete,
                                //                                 color:
                                //                                     Colors.red,
                                //                                 size: 17,
                                //                               ),
                                //                             )
                                //                             // SvgPicture.asset(
                                //                             //   info.svgSrc!,
                                //                             //   color: info.color,
                                //                             // ),
                                //                             ),
                                //                       ),
                                //                     ),
                                //                   ],
                                //                 ),
                                //               ],
                                //             )
                                //           ],
                                //         ),
                                //       ),
                                //     );
                                //   },
                                //   separatorBuilder:
                                //       (BuildContext context, int index) {
                                //     return const SizedBox(
                                //       width: 20,
                                //     );
                                //   },
                                // ),
                              ],
                            ),
                          ),
                          if (!Responsive.isMobile(context))
                            const SizedBox(width: defaultPadding),
                          // On Mobile means if the screen is less than 850 we dont want to show it
                          if (!Responsive.isMobile(context))
                            Expanded(
                              flex: 2,
                              child:
                                  // SizedBox()
                                  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Add Products",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor),
                                  ),
                                  SizedBox(
                                    height: height / 1.25,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          (productProvider.productImage == null)
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
                                                          productProvider
                                                              .webImage))
                                                  : SizedBox(
                                                      height: 150,
                                                      width: 200,
                                                      child: Image.memory(
                                                          productProvider
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
                                            controller: productProvider
                                                .productNameController,
                                            decoration: inputdecoration(
                                                label: 'Product Name'),
                                          ),
                                          const SizedBox(
                                              height: defaultPadding),
                                          TextFormField(
                                            controller: productProvider
                                                .productCountController,
                                            keyboardType: TextInputType.number,
                                            decoration: inputdecoration(
                                                label: 'Product Quantity'),
                                          ),
                                          const SizedBox(
                                              height: defaultPadding),
                                          TextFormField(
                                            controller: productProvider
                                                .productPriceController,
                                            keyboardType: TextInputType.number,
                                            decoration: inputdecoration(
                                                label: 'Product Price'),
                                          ),
                                          const SizedBox(
                                              height: defaultPadding),
                                          TextFormField(
                                            controller: productProvider
                                                .productDescriptionController,
                                            maxLines: 5,
                                            decoration: inputdecoration(
                                                label: 'Product Description'),
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
                                                  controller: productProvider
                                                      .btnController,
                                                  color: primaryColor,
                                                  onPressed: () async {
                                                    productProvider
                                                        .ismShopsDataUploading(
                                                            true);

                                                    if (productProvider.productNameController.text.isNotEmpty &&
                                                        productProvider
                                                            .productCountController
                                                            .text
                                                            .isNotEmpty &&
                                                        productProvider
                                                            .productPriceController
                                                            .text
                                                            .isNotEmpty &&
                                                        productProvider
                                                            .productDescriptionController
                                                            .text
                                                            .isNotEmpty &&
                                                        productProvider
                                                                .productImage !=
                                                            null) {
                                                      productProvider.uploadProductData(
                                                          productName:
                                                              productProvider
                                                                  .productNameController
                                                                  .text,
                                                          productQuantity:
                                                              productProvider
                                                                  .productCountController
                                                                  .text,
                                                          productPrice:
                                                              productProvider
                                                                  .productPriceController
                                                                  .text,
                                                          productDescription:
                                                              productProvider
                                                                  .productDescriptionController
                                                                  .text);

                                                      mShowNotification(
                                                          heading: "Success",
                                                          context: context,
                                                          message:
                                                              "Shop added successfully");
                                                      productProvider
                                                          .btnController
                                                          .success();
                                                      productProvider
                                                          .mGetAllProducts();
                                                      Timer(
                                                          const Duration(
                                                              milliseconds:
                                                                  600), () {
                                                        productProvider
                                                            .btnController
                                                            .reset();
                                                      });
                                                    } else {
                                                      productProvider
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
                                                        productProvider
                                                            .btnController
                                                            .reset();
                                                      });
                                                      productProvider
                                                          .ismShopsDataUploading(
                                                              true);
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
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                )),
      )),
    );
  }
}
