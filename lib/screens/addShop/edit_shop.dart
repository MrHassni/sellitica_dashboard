import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:erp_aspire/Utils/Utils.dart';
import 'package:erp_aspire/Utils/appConstants.dart';
import 'package:erp_aspire/provider/addRetailerProvider.dart';
import 'package:erp_aspire/provider/shopsProvider.dart';
import 'package:erp_aspire/provider/userProvider.dart';
import 'package:erp_aspire/screens/dashboard/components/header.dart';
import 'package:erp_aspire/widgets/regularWidgets.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../constants.dart';
import '../../responsive.dart';

class EditShop extends StatefulWidget {
  final ShopsProfile shopProfile;
  const EditShop({Key? key, required this.shopProfile}) : super(key: key);

  @override
  _EditShopState createState() => _EditShopState();
}

class _EditShopState extends State<EditShop> {
  GoogleMapController? mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();
  final List<String> items = [];

  @override
  void initState() {
    super.initState();
    getAvailableUsersData();
  }

  getAvailableUsersData() {
    _shopNameController.text = widget.shopProfile.shopName;
    _ownerNameController.text = widget.shopProfile.ownerName;
    _cnicController.text = widget.shopProfile.cnic;
    _phoneController.text = widget.shopProfile.phone;
    Provider.of<addRetailerProvider>(context, listen: false)
        .addressController
        .text = widget.shopProfile.address;
    selectedValue = widget.shopProfile.assignedto.first;
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

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final _shopNameController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _cnicController = TextEditingController();
  final _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      margin: const EdgeInsets.all(20),
      child: Scaffold(
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
                            Header(
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
                                      SizedBox(
                                          height: 150,
                                          width: 150,
                                          child: Image.network(
                                              widget.shopProfile.url)),
                                      const SizedBox(
                                        height: 20,
                                        width: double.infinity,
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
                                                        selectedValue != null;

                                                if (isReadyToUpload) {
                                                  await provider.updateShopData(
                                                    shopName:
                                                        _shopNameController
                                                            .text,
                                                    cnic: _cnicController.text,
                                                    ownerName:
                                                        _ownerNameController
                                                            .text,
                                                    phone:
                                                        _phoneController.text,
                                                    address: provider
                                                        .addressController.text,
                                                    lat: provider
                                                        .latlng!.latitude,
                                                    long: provider
                                                        .latlng!.longitude,
                                                    assignedTo: selectedValue!,
                                                    id: widget.shopProfile.id,
                                                    timeStamp: widget
                                                        .shopProfile.timestamp,
                                                    url: widget.shopProfile.url,
                                                  );

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
                                                    _shopNameController.clear();
                                                    _cnicController.clear();
                                                    _ownerNameController
                                                        .clear();
                                                    _phoneController.clear();
                                                    provider.shopImage = null;
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
                                                  "Update",
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
                                                          'shopMarkerId'),
                                                      position: provider.latlng ==
                                                              null
                                                          ? LatLng(
                                                              widget
                                                                  .shopProfile
                                                                  .latlong
                                                                  .latitude,
                                                              widget
                                                                  .shopProfile
                                                                  .latlong
                                                                  .longitude)
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
                                                style: TextStyle(
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
  }
}
