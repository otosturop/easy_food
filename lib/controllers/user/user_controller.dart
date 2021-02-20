import 'package:easy_food/data/user/info_api.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  var fullName = RxString(null);
  var userName = RxString(null);
  var email = RxString(null);
  var phone = RxString(null);
  var loadingInfo = false.obs;
  Infoapi _infoApi = Infoapi();

  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId');
    return userId;
  }

  @override
  void onInit() async {
    String userId = await getUserId();
    getUserInfo(userId);
    super.onInit();
  }

  void setFullName(value) => fullName.value = value;

  void setUserName(value) => userName.value = value;

  void setEmail(value) => email.value = value;

  void setPhone(value) => phone.value = value;

  Future<void> getUserInfo(userId) async {
    try {
      loadingInfo(false);
      var userInfo = await _infoApi.getUserInfo(userId);
      if (userInfo != null) {
        var tempData = userInfo.data[0];
        fullName.value = tempData.fullName;
        userName.value = tempData.userName;
        email.value = tempData.email;
        phone.value = tempData.phone;
      }
    } finally {
      loadingInfo(true);
    }
  }

  Future<void> updateUser() async {
    String userId = await getUserId();
    try {
      var status = await _infoApi.updateUserInfo(
          userId, fullName.value, userName.value, email.value, phone.value);
      if (status.success) {
        getUserInfo(userId);
      }
    } finally {}
  }
}