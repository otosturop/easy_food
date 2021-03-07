import 'dart:convert';

import 'package:easy_food/model/user/UpdateUserInfoModel.dart';
import 'package:easy_food/model/user/UserInfoModel.dart';
import 'package:http/http.dart' as http;

class Infoapi {
  static const baseUrl =
      "http://206.189.55.20:8080/rest/276ce05d-837b-4aa1-8f6f-ff02597a0e01/";
  var client = http.Client();
  final Map<String, String> headers = {"content-type": "application/json"};

  Future<UserInfoModel> getUserInfo(userId) async {
    final apiUrl = Uri.parse(baseUrl + "Users/getUserInfo?xuser_id=" + userId);
    var responseInfo = await client.get(apiUrl);
    if (responseInfo != null && responseInfo.statusCode == 200) {
      final resJson = jsonDecode(responseInfo.body);
      return UserInfoModel.fromJson(resJson);
    } else {
      throw Exception("Veri Getirilemedi");
    }
  }

  Future<UpdateUserInfoModel> updateUserInfo(
      userId, fullName, userName, email, phone) async {
    final apiUrl = Uri.parse(baseUrl + "Users/updateUser");
    final postBody = jsonEncode({
      'tuser_id': userId,
      "full_name": fullName,
      "user_name": userName,
      "email": email,
      "phone": phone,
    });
    var response = await client.post(apiUrl, headers: headers, body: postBody);

    if (response != null && response.statusCode == 200) {
      final resJson = jsonDecode(response.body);
      return UpdateUserInfoModel.fromJson(resJson);
    } else {
      throw Exception("Something went wrong");
    }
  }
}
