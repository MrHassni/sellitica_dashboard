import 'dart:convert';

class CompanyModel {
  final String? companyName, companyId, companyImgUrl;

  CompanyModel({this.companyId, this.companyImgUrl, this.companyName});

  factory CompanyModel.fromJson(Map<String, dynamic> jsonData) {
    return CompanyModel(
      companyImgUrl: jsonData['imgUrl'],
      companyName: jsonData['companyName'],
      companyId: jsonData['companyId'],
    );
  }

  static Map<String, dynamic> toMap(CompanyModel model) => {
        'imgUrl': model.companyImgUrl,
        'companyName': model.companyName,
        'companyId': model.companyId
      };

  static String encode(List<CompanyModel> contacts) => json.encode(
        contacts
            .map<Map<String, dynamic>>((contact) => CompanyModel.toMap(contact))
            .toList(),
      );

  static List<CompanyModel> decode(String contacts) =>
      (json.decode(contacts) as List<dynamic>)
          .map<CompanyModel>((item) => CompanyModel.fromJson(item))
          .toList();
}
