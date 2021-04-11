import 'package:easy_food/controllers/customer/customer_controller.dart';
import 'package:easy_food/controllers/product/basket_controller.dart';
import 'package:easy_food/controllers/user/address_controller.dart';
import 'package:easy_food/components/foundation_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_food/controllers/bottom_bar_controller.dart';
import 'package:get/get.dart';

class SuccessOrder extends StatelessWidget {
  final String totalPrice;

  SuccessOrder({this.totalPrice});

  final BasketController basketController = Get.put(BasketController());
  final AddressController addressController = Get.put(AddressController());
  final CustomerController customerController = Get.put(CustomerController());
  final BottomBarController navController = Get.put(BottomBarController());

  void completeOrder() {
    if (basketController.paymentMethodId.value == null) {
      showToastMessage("Lütfen Ödeme Yöntemi Seçiniz", Colors.red);
    } else if (addressController.firstAddress.value == null) {
      showToastMessage("Lütfen Adres Seçiniz", Colors.red);
    } else {
      basketController
          .sendCartToServer(
              totalPrice, addressController.firstAddress.value.frmUserAdressId)
          .then((value) {
        basketController.setComplateOrder();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 2.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Theme.of(context).colorScheme.primaryVariant),
          onPressed: () => Get.back(),
        ),
        title: Text("Siparişi Tamamla",
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20.0,
                color: Theme.of(context).colorScheme.primaryVariant)),
      ),
      body: Container(child: Obx(() {
        print("eben: " + addressController.firstAddress.value.addressType);
        if (!basketController.complateOrder.value) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 8,
                  child: Column(
                    children: [
                      ListTile(
                        title: Center(
                          child: Text(
                            "Seçili Adres: " +
                                addressController
                                    .firstAddress.value.addressTypeQw,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(addressController
                            .firstAddress.value.complateAddress),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: dropdownSelectPayment(context),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: orderNote(context),
              ),
              FoundationButton("Siparişi Tamamla", () => completeOrder())
            ],
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Siparişiniz Hazırlanmaktadır.',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    FaIcon(
                      FontAwesomeIcons.checkCircle,
                      size: 96.0,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Sipariş Numarası: " +
                            basketController.orderNumber.value,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      })),
    );
  }

  Widget selectedAdress(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 8,
        child: Column(
          children: [
            ListTile(
              title: Center(
                child: Text(
                  "Seçili Adres: " +
                      addressController.firstAddress.value.addressTypeQw,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(addressController.firstAddress.value.complateAddress),
            ),
          ],
        ),
      ),
    );
  }

  Widget dropdownSelectPayment(context) {
    var paymentMethod =
        customerController.customer[0].paymentMethodId.split(',');
    return Container(
      height: Get.height * 0.05,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.onBackground, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: DropdownButtonHideUnderline(child: Obx(() {
        if (customerController.isLoadingPayment.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return DropdownButton<String>(
              isExpanded: true,
              value: basketController.paymentMethodId.value,
              items: [
                for (var i in paymentMethod)
                  DropdownMenuItem<String>(
                      child: Text(customerController.matchPaymentMethod(i)),
                      value: i),
              ],
              hint: Text("Ödeme Yöntemi Seçiniz"),
              onChanged: (data) => basketController.setPaymentMethod(data));
        }
      })),
    );
  }

  Container orderNote(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: TextFormField(
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.edit,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onBackground,
                  width: 2.0),
            ),
            labelText: "Sipariş Notu",
            labelStyle:
                TextStyle(color: Theme.of(context).colorScheme.onBackground)),
        maxLines: 6,
        minLines: 4,
        keyboardType: TextInputType.multiline,
        onChanged: (data) => basketController.setOrderNote(data),
      ),
    );
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
