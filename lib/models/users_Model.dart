import 'package:erp_aspire/Configs/Dbkeys.dart';

class users_Model {
  final String aboutMe;
  final String accountstatus;
  final String actionmessage;
  final int authenticationType;
  // final int bookings;
  final String company;
  final String currentDeviceID;
  final Map<String, dynamic> deviceDetails;
  final String email;
  final String id;
  final int joinedOn;
  final int lastLogin;
  final List notificationTokens;
  // final int orders;
  final String photoUrl;
  final String name;
  // final dynamic remainingshops;
  final dynamic targetorders;
  final dynamic targetshops;
  // final dynamic visitedshops;

  const users_Model({
    required this.email,
    required this.company,
    required this.aboutMe,
    required this.accountstatus,
    required this.actionmessage,
    required this.authenticationType,
    // required this.bookings,
    required this.currentDeviceID,
    required this.name,
    required this.deviceDetails,
    required this.id,
    required this.joinedOn,
    required this.lastLogin,
    required this.notificationTokens,
    // required this.orders,
    required this.photoUrl,
    // required this.remainingshops,
    required this.targetorders,
    required this.targetshops,
    // required this.visitedshops
  });

  factory users_Model.fromJson(Map<String, dynamic> parsedJson) {
    return users_Model(
      email: parsedJson[Dbkeys.email],
      name: parsedJson[Dbkeys.name],
      company: parsedJson[Dbkeys.company],
      aboutMe: parsedJson[Dbkeys.aboutMe],
      accountstatus: parsedJson[Dbkeys.accountstatus],
      actionmessage: parsedJson[Dbkeys.actionmessage],
      authenticationType: parsedJson[Dbkeys.authenticationType],
      // bookings: parsedJson[Dbkeys.bookings],
      currentDeviceID: parsedJson[Dbkeys.currentDeviceID],
      deviceDetails: parsedJson[Dbkeys.deviceDetails],
      id: parsedJson[Dbkeys.id],
      joinedOn: parsedJson[Dbkeys.joinedOn],
      lastLogin: parsedJson[Dbkeys.lastLogin],
      notificationTokens: parsedJson[Dbkeys.notificationTokens],
      // orders: parsedJson[Dbkeys.orders],
      photoUrl: parsedJson[Dbkeys.photoUrl],
      // remainingshops: parsedJson[Dbkeys.remainingshops],
      targetorders: parsedJson[Dbkeys.targetorders],
      targetshops: parsedJson[Dbkeys.targetshops],
      // visitedshops: parsedJson[Dbkeys.visitedshops],
    );
  }

  Map<String, dynamic> users_Model_To_Map() {
    return {
      "email": email,
      "name": name,
      "company": company,
      "aboutMe": aboutMe,
      "accountstatus": accountstatus,
      "actionmessage": actionmessage,
      "authenticationType": authenticationType,
      // "bookings": bookings,
      "currentDeviceID": currentDeviceID,
      "deviceDetails": deviceDetails,
      "id": id,
      "joinedOn": joinedOn,
      "lastLogin": lastLogin,
      "notificationTokens": notificationTokens,
      // "orders": orders,
      "photoUrl": photoUrl,
      // "remainingshops": remainingshops,
      "targetorders": targetorders,
      "targetshops": targetshops,
      // "visitedshops": visitedshops,
    };
  }
}
