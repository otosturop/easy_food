import 'package:easy_food/controllers/user/user_controller.dart';
import 'package:easy_food/ui/foundation_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 4,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0, 10))
                    ],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/user.png'),
                    )),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Obx(() {
              if (userController.loadingInfo.value) {
                return Column(
                  children: [
                    buildInputField(
                        context,
                        "Ad Soyad",
                        Icons.person,
                        TextInputType.text,
                        userController.fullName.value, (value) {
                      userController.setFullName(value);
                    }),
                    buildInputField(
                        context,
                        "Kullanıcı Adınız",
                        Icons.person_pin_circle,
                        TextInputType.text,
                        userController.userName.value, (value) {
                      userController.setUserName(value);
                    }),
                    buildInputField(
                        context,
                        "E-posta adresiniz",
                        Icons.email,
                        TextInputType.emailAddress,
                        userController.email.value, (value) {
                      userController.setEmail(value);
                    }),
                    buildInputField(
                        context,
                        "Telefon Numaranız",
                        Icons.phone,
                        TextInputType.phone,
                        userController.phone.value, (value) {
                      userController.setPhone(value);
                    }),
                    FoundationButton("Kaydet", () => _validation()),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
          )
        ],
      ),
    );
  }

  Widget buildInputField(BuildContext context, String inputText, icon, type,
      String inputValue, textChange) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        keyboardType: type,
        controller: TextEditingController.fromValue(TextEditingValue(
            text: inputValue,
            selection: TextSelection.collapsed(
                offset: inputValue != null ? inputValue.length : 0))),
        autofocus: true,
        decoration: InputDecoration(
            labelText: inputText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            prefixIcon: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
            )),
        onChanged: textChange,
      ),
    );
  }

  _validation() {
    if (userController.phone.value == "" ||
        userController.email.value == "" ||
        userController.userName.value == "" ||
        userController.fullName.value == "") {
      showToastMessage(
          "Lütfen profil bilgilerini eksiksiz giriniz", Colors.red);
    } else {
      userController.updateUser();
    }
  }

  void showToastMessage(String message, Color toastColor) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: toastColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
