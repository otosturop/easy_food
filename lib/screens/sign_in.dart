import 'package:easy_food/controllers/authentication_controller.dart';
import 'package:easy_food/ui/foundation_button.dart';
import 'package:easy_food/ui/social_log_in_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthenticationController authController =
      Get.put(AuthenticationController());

  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  String password, email, name, phone;

  void _validationLogin() {
    if (loginKey.currentState.validate()) {
      loginKey.currentState.save();
      if (name != null && password != null) {
        authController.loginControl(name, password);
      }
    }
  }

  void _validationSignUp() {
    if (signUpKey.currentState.validate()) {
      signUpKey.currentState.save();
      if (email != null && password != null) {
        authController.registerUser(name, email, phone, password);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 700),
                      height: MediaQuery.of(context).viewInsets.bottom > 0
                          ? 0
                          : Get.height * 0.3,
                      color: Colors.white,
                      child: Center(child: Image.asset("assets/logo.jpeg")),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(50))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                        child: TabBar(
                          labelStyle: Theme.of(context).textTheme.headline5,
                          unselectedLabelStyle:
                              Theme.of(context).textTheme.headline5,
                          labelColor: Colors.black,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Theme.of(context).colorScheme.primary,
                          indicatorWeight: 3,
                          tabs: [
                            Tab(text: "Giriş"),
                            Tab(text: "Kayıt Ol"),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  flex: 7,
                  child: TabBarView(children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Form(
                        key: loginKey,
                        child: Column(
                          children: [
                            Spacer(),
                            buildNameField(context),
                            buildPasswordField(context),
                            Spacer(),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Text("Şifremi Unuttum")),
                            Spacer(),
                            MediaQuery.of(context).viewInsets.bottom > 0
                                ? Spacer()
                                : SocialLoginButton(
                                    buttonText: "Google Hesabıyla Giriş Yap",
                                    onPressed: () {},
                                    buttonColor: Colors.white,
                                    textColor: Colors.black87,
                                    buttonIcon:
                                        Image.asset("assets/google.png"),
                                  ),
                            Spacer(),
                            FoundationButton(
                                "Giriş Yap", () => _validationLogin()),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                    // 2. tab bölgesi
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Form(
                        key: signUpKey,
                        child: Column(
                          children: [
                            Spacer(),
                            buildNameField(context),
                            buildPhoneNumberField(context),
                            buildEmailField(context),
                            buildPasswordField(context),
                            Spacer(),
                            FoundationButton(
                                "Kayıt Ol", () => _validationSignUp()),
                          ],
                        ),
                      ),
                    )
                  ])),
            ],
          ),
        ),
      ),
    );
  }

  Obx buildPasswordField(BuildContext context) {
    return Obx(() {
      return TextFormField(
        obscureText: authController.textPasswordType,
        validator: (value) {
          if (value.length < 6) return "Şifre en z 6 haneli olmalıdır!";
          return null;
        },
        decoration: InputDecoration(
            labelText: "Şifre",
            icon: Icon(
              Icons.lock,
              color: Theme.of(context).colorScheme.primary,
            ),
            suffix: IconButton(
              icon: Icon(authController.textPasswordType
                  ? Icons.remove_red_eye_outlined
                  : Icons.visibility_off),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                authController.changeTypePassword();
              },
            )),
        onSaved: (data) => password = data,
      );
    });
  }

  TextFormField buildEmailField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (!value.contains('@') || !value.contains('.'))
          return "Geçerli bir eposta adresi giriniz";
        return null;
      },
      decoration: InputDecoration(
          labelText: "E-posta",
          icon: Icon(
            Icons.email,
            color: Theme.of(context).colorScheme.primary,
          )),
      onSaved: (data) => email = data,
    );
  }

  TextFormField buildNameField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value.length < 3)
          return "Kullanıcı adı alanı en az 3 karakter olmalıdır";
        return null;
      },
      decoration: InputDecoration(
          labelText: "Kullanıcı Adı",
          icon: Icon(
            Icons.person,
            color: Theme.of(context).colorScheme.primary,
          )),
      onSaved: (data) => name = data,
    );
  }

  TextFormField buildPhoneNumberField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.length < 10)
          return "Telefon numarası en az 10 haneli olmalıdır.";
        return null;
      },
      decoration: InputDecoration(
          labelText: "Telefon Numarası",
          icon: Icon(
            Icons.phone,
            color: Theme.of(context).colorScheme.primary,
          )),
      onSaved: (data) => phone = data,
    );
  }
}
