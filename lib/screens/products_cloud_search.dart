import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erp_aspire/provider/productsProvider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Configs/Dbpaths.dart';
import '../constants.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

String upperLetter(String value) {
  return value.toTitleCase();
}

class ProductsCloudFirestoreSearch extends StatefulWidget {
  final String company;
  const ProductsCloudFirestoreSearch({Key? key, required this.company})
      : super(key: key);

  @override
  _ProductsCloudFirestoreSearchState createState() =>
      _ProductsCloudFirestoreSearchState();
}

class _ProductsCloudFirestoreSearchState
    extends State<ProductsCloudFirestoreSearch> {
  String? name = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(15),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue, width: 1),
                borderRadius: BorderRadius.circular(15),
              ),
              prefixIcon: const Icon(Icons.search),
              hintText: 'Search...'),
          onChanged: (val) {
            setState(() {
              name = val;
            });
          },
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: StreamBuilder<QuerySnapshot>(
            stream: (name != "" && name != null)
                ? FirebaseFirestore.instance
                    .collection(DbPaths.companies)
                    .doc(widget.company)
                    .collection(DbPaths.products)
                    .orderBy('name')
                    .startAt([upperLetter(name!)]).endAt(
                        [upperLetter(name!) + '\uf8ff']).snapshots()
                : FirebaseFirestore.instance
                    .collection(DbPaths.companies)
                    .doc(widget.company)
                    .collection(DbPaths.products)
                    .orderBy('lastUpdateTime')
                    .limit(10)
                    .snapshots(),
            builder: (context, snapshot) {
              return (snapshot.connectionState == ConnectionState.waiting &&
                      !snapshot.hasData)
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot data = snapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 0),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            color: Colors.white,
                            elevation: 5,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      child: Text(
                                        data['name'],
                                        style: const TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      alignment: Alignment.centerLeft,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Text(
                                        data['description'],
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    MediaQuery.of(context).size.width > 450
                                        ? Wrap(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFFFA113)
                                                            .withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text.rich(TextSpan(
                                                      text:
                                                          'Quantity Available  ',
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Color(0xFFFFA113),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      children: <InlineSpan>[
                                                        TextSpan(
                                                          text: data['quantity']
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              letterSpacing:
                                                                  0.5,
                                                              color: Color(
                                                                  0xFFFFA113),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ])),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: primaryColor
                                                        .withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text.rich(TextSpan(
                                                      text: 'Price  ',
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: primaryColor,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      children: <InlineSpan>[
                                                        TextSpan(
                                                          text: data['price'],
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              letterSpacing:
                                                                  0.5,
                                                              color:
                                                                  primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ])),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFFFA113)
                                                            .withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text.rich(TextSpan(
                                                      text:
                                                          'Quantity Available  ',
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Color(0xFFFFA113),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      children: <InlineSpan>[
                                                        TextSpan(
                                                          text: data['quantity']
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              letterSpacing:
                                                                  0.5,
                                                              color: Color(
                                                                  0xFFFFA113),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ])),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: primaryColor
                                                        .withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text.rich(TextSpan(
                                                      text: 'Price  ',
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: primaryColor,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      children: <InlineSpan>[
                                                        TextSpan(
                                                          text: data['price']
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              letterSpacing:
                                                                  0.5,
                                                              color:
                                                                  primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ])),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: MaterialButton(
                                            onPressed: () async {
                                              final response =
                                                  await showOkCancelAlertDialog(
                                                      context: context,
                                                      title: "Are you sure ?",
                                                      message:
                                                          "You want to delete this product...?");
                                              if (response.toString() ==
                                                  "OkCancelResult.ok") {
                                                if (kDebugMode) {
                                                  Provider.of<ProductsProvider>(
                                                          context,
                                                          listen: false)
                                                      .mDeleteProducts(
                                                          data['id']);
                                                }
                                              }
                                            },
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            padding: EdgeInsets.zero,
                                            child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  color: Colors.red
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10)),
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                    size: 17,
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
            },
          ),
        ),
      ],
    );
  }
}
