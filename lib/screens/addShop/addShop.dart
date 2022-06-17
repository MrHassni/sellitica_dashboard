import 'dart:async';
import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:erp_aspire/Utils/Utils.dart';
import 'package:erp_aspire/Utils/appConstants.dart';
import 'package:erp_aspire/provider/addRetailerProvider.dart';
import 'package:erp_aspire/provider/userProvider.dart';
import 'package:erp_aspire/screens/dashboard/components/header.dart';
import 'package:erp_aspire/widgets/regularWidgets.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../constants.dart';
import '../../responsive.dart';

class addShop extends StatefulWidget {
  const addShop({Key? key}) : super(key: key);

  @override
  _addShopState createState() => _addShopState();
}

class _addShopState extends State<addShop> {
  GoogleMapController? mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();
  final List<String> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAvailableUsersData();
  }

  getAvailableUsersData() {
    Provider.of<userProvider>(context, listen: false).mGetAllUsers();
    int length =
        Provider.of<userProvider>(context, listen: false).allusers.length;
    for (int i = 0; i < length; i++) {
      items.add(
          Provider.of<userProvider>(context, listen: false).allusers[i].email);
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  // File _file = File("zz");
  // Uint8List webImage = Uint8List(10);
  // PickedFile? file;
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final _shopNameController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _cnicController = TextEditingController();
  final _phoneController = TextEditingController();

  // ScrollController? _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      margin: const EdgeInsets.all(20),
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: Container(
          height: height,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: SafeArea(
              child: Consumer2<addRetailerProvider, userProvider>(
                  builder: (context, provider, userprovider, _child) =>
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Header(
                              title: 'Add Retailer/ Shop',
                            ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      (provider.shopImage == null)
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
                                                      provider.webImage))
                                              : SizedBox(
                                                  height: 150,
                                                  width: 200,
                                                  child: Image.memory(
                                                      provider.webImage)),
                                      const SizedBox(
                                        height: 20,
                                        width: double.infinity,
                                      ),
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
                                        controller: _shopNameController,
                                        decoration: inputdecoration(
                                            label:
                                                'Company/ Organization Name'),
                                      ),
                                      const SizedBox(height: defaultPadding),
                                      TextFormField(
                                        controller: _ownerNameController,
                                        decoration: inputdecoration(
                                            label: 'Owner Name'),
                                      ),
                                      const SizedBox(height: defaultPadding),
                                      TextFormField(
                                          controller:
                                              provider.addressController,
                                          decoration: inputdecoration(
                                              label: 'Address')),
                                      const SizedBox(height: defaultPadding),
                                      TextFormField(
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            Utils.phonemaskFormatter
                                          ],
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: (input) => Utils
                                                  .isValidPhone(input!)
                                              ? null
                                              : "Please enter correct phone #",
                                          controller: _phoneController,
                                          decoration:
                                              inputdecoration(label: 'Phone')),
                                      const SizedBox(height: defaultPadding),
                                      TextFormField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          Utils.cnicmaskFormatter
                                        ],
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (input) =>
                                            Utils.isValidCnic(input!)
                                                ? null
                                                : "Please enter correct cnic #",
                                        controller: _cnicController,
                                        decoration: inputdecoration(
                                            label: 'Cnic (optional)'),
                                      ),
                                      const SizedBox(height: defaultPadding),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton2(
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 5),
                                            isExpanded: true,
                                            hint: Text(
                                              'Select Sales Man',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color:
                                                    Theme.of(context).hintColor,
                                              ),
                                            ),
                                            items: items
                                                .map((item) =>
                                                    DropdownMenuItem<String>(
                                                      value: item,
                                                      child: Text(
                                                        item,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                            value: selectedValue,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedValue = value as String;
                                              });
                                            },
                                            buttonHeight: 40,
                                            buttonWidth: 200,
                                            itemHeight: 40,
                                            dropdownMaxHeight: 200,
                                            searchController:
                                                textEditingController,
                                            searchInnerWidget: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8,
                                                bottom: 4,
                                                right: 8,
                                                left: 8,
                                              ),
                                              child: TextFormField(
                                                controller:
                                                    textEditingController,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    horizontal: 10,
                                                    vertical: 8,
                                                  ),
                                                  hintText:
                                                      'Search for an item...',
                                                  hintStyle: const TextStyle(
                                                      fontSize: 12),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            searchMatchFn: (item, searchValue) {
                                              return (item.value
                                                  .toString()
                                                  .contains(searchValue));
                                            },
                                            //This to clear the search value when you close the menu
                                            onMenuStateChange: (isOpen) {
                                              if (!isOpen) {
                                                textEditingController.clear();
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: defaultPadding),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: 150,
                                            child: RoundedLoadingButton(
                                              borderRadius: 10,
                                              controller: _btnController,
                                              color: primaryColor,
                                              onPressed: () async {
                                                log(provider.latlng!
                                                    .toString());

                                                provider.ismShopsDataUploading(
                                                    true);

                                                bool isCnicValid =
                                                    _cnicController.text.isEmpty
                                                        ? true
                                                        : Utils.isValidCnic(
                                                            _cnicController
                                                                .text);

                                                bool isphoneValid =
                                                    Utils.isValidPhone(
                                                        _phoneController.text);

                                                // bool isLocationFormatChosen =
                                                //     provider.useCurrentLocation
                                                //         ? true
                                                //         : provider
                                                //                 .isShopLocationSelectedFromMap
                                                //             ? true
                                                //             : false;

                                                bool isReadyToUpload =
                                                    _shopNameController
                                                            .text.isNotEmpty &&
                                                        _ownerNameController
                                                            .text.isNotEmpty &&
                                                        provider
                                                            .addressController
                                                            .text
                                                            .isNotEmpty &&
                                                        isCnicValid &&
                                                        // isLocationFormatChosen &&
                                                        isphoneValid &&
                                                        selectedValue != null &&
                                                        provider.shopImage !=
                                                            null;

                                                if (isReadyToUpload) {
                                                  await provider.postUploadShopData(
                                                      shopName:
                                                          _shopNameController
                                                              .text,
                                                      cnic:
                                                          _cnicController.text,
                                                      ownerName:
                                                          _ownerNameController
                                                              .text,
                                                      phone:
                                                          _phoneController.text,
                                                      address: provider
                                                          .addressController
                                                          .text,
                                                      lat: provider
                                                          .latlng!.latitude,
                                                      long: provider
                                                          .latlng!.longitude,
                                                      assignedTo:
                                                          selectedValue!);

                                                  // addRetailerProvider.ismShopsDataUploading(false);
                                                  // Utils.toast("Done");
                                                  // Navigator.pop(context);
                                                  // print("LOG_D UPLOADED");
                                                  mShowNotification(
                                                      heading: "Success",
                                                      context: context,
                                                      message:
                                                          "Shop added successfully");
                                                  _btnController.success();
                                                  Provider.of<userProvider>(
                                                          context,
                                                          listen: false)
                                                      .mGetAllUsers();
                                                  Timer(
                                                      const Duration(
                                                          milliseconds: 600),
                                                      () {
                                                    _btnController.reset();
                                                  });
                                                } else {
                                                  _btnController.error();
                                                  Timer(
                                                      const Duration(
                                                          milliseconds: 600),
                                                      () {
                                                    _btnController.reset();
                                                  });

                                                  // Utils.toast(
                                                  //     "Please Fill all fields");
                                                  mShowNotificationError(
                                                      heading: "Warning",
                                                      context: context,
                                                      message:
                                                          "Please provide required data");
                                                  provider
                                                      .ismShopsDataUploading(
                                                          false);
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
                                ),
                                if (!Responsive.isMobile(context))
                                  const SizedBox(width: defaultPadding),
                                // On Mobile means if the screen is less than 850 we dont want to show it
                                if (!Responsive.isMobile(context))
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Choose Shop location",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor),
                                        ),
                                        Card(
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: SizedBox(
                                              height: height / 1.5,
                                              child: GoogleMap(
                                                zoomGesturesEnabled: true,
                                                myLocationEnabled: true,
                                                myLocationButtonEnabled: false,
                                                zoomControlsEnabled: true,
                                                onMapCreated: _onMapCreated,
                                                markers: <Marker>{
                                                  Marker(
                                                      markerId: const MarkerId(
                                                          'shopmarkerId'),
                                                      position: provider
                                                                  .latlng ==
                                                              null
                                                          ? const LatLng(
                                                              31.4825735,
                                                              74.3227862)
                                                          : provider.latlng!,
                                                      draggable: true,
                                                      onDragEnd: (latlong) {
                                                        provider
                                                            .mUpdateShopLocation(
                                                                latlong);
                                                      })
                                                },
                                                initialCameraPosition:
                                                    CameraPosition(
                                                  target:
                                                      provider.latlng == null
                                                          ? const LatLng(
                                                              31.4825735,
                                                              74.3227862)
                                                          : provider.latlng!,
                                                  zoom: 13.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Center(
                                          child: MaterialButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            color: primaryColor,
                                            onPressed: () {
                                              provider.reverseGeocoding();
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "Get Address",
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
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
                      ))),
        ),
      ),
    );

    // return Consumer<MenuController>(builder: (context, provider, _child) {
    //   return Scaffold(
    //     key: provider.scaffoldKey,
    //     drawer: SideMenu(),
    //     body: SafeArea(
    //       child: Row(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           // We want this side menu only for large screen
    //           if (Responsive.isDesktop(context))
    //             Expanded(
    //               // default flex = 1
    //               // and it takes 1/6 part of the screen
    //               child: SideMenu(),
    //             ),
    //           Expanded(
    //             // It takes 5/6 part of the screen
    //             flex: 5,
    //             child: addShopForm(),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // });
  }

  uploadImage() async {
    if (kIsWeb) {
      PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
      );
      var f = await pickedFile!.readAsBytes();
      Provider.of<addRetailerProvider>(context, listen: false)
          .setShopImage(webImage: f, image: pickedFile);

      // setState(() {
      //   _file = File("a");
      //   file = pickedFile;
      //   webImage = f;
      // });

      // final ImagePicker _picker = ImagePicker();
      // XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      // if (image != null) {
      //   var f = await image.readAsBytes();
      //   setState(() {
      //     _file = File("a");
      //     webImage = f;
      //   });
      // } else {
      //   print("NO FILE SELECT");
      // }
    } else {
      print("NO PERMISSION");
    }
  }
}
