import 'dart:convert';
import 'package:easy_food/model/AssignRoleModel.dart';
import 'package:easy_food/model/LoginModel.dart';
import 'package:easy_food/model/RegisterModel.dart';
import 'package:http/http.dart' as http;

class RegisterApi {
  static const baseUrl =
      "http://206.189.55.20:8080/rest/276ce05d-837b-4aa1-8f6f-ff02597a0e01/";
  final Map<String, String> headers = {"content-type": "application/json"};
  var client = http.Client();

  Future<RegisterModel> register(fullname, email, phone, password) async {
    final apiUrl = Uri.parse(baseUrl + "Users/createUser");
    final postBody = jsonEncode({
      'full_name': fullname,
      'pass_word': password,
      'email': email,
      'phone': phone,
      'user_name': fullname
    });
    var responseRegister =
        await client.post(apiUrl, headers: headers, body: postBody);
    if (responseRegister != null && responseRegister.statusCode == 200) {
      Map result = json.decode(responseRegister.body);
      return RegisterModel.fromJson(result);
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<AssignRoleModel> assignRole(userId) async {
    final apiUrl = Uri.parse(baseUrl + "Users/addUserRole");
    final postBody = jsonEncode({
      'user_id': userId,
      "role_id": "1",
    });
    var responseRole =
        await client.post(apiUrl, headers: headers, body: postBody);
    if (responseRole != null && responseRole.statusCode == 200) {
      Map result = json.decode(responseRole.body);
      return AssignRoleModel.fromJson(result);
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<LoginModel> doLogin(userName, password) async {
    final apiUrl = Uri.parse(baseUrl + "Users/login");
    final postBody = {
      'userName': userName,
      "passWord": password,
    };
    var responseStatus = await client.post(apiUrl, body: postBody);
    if (responseStatus != null && responseStatus.statusCode == 200) {
      Map result = json.decode(responseStatus.body);
      return LoginModel.fromJson(result);
    } else {
      throw Exception("Something went wrong");
    }
  }
}
