import 'package:easy_food/controllers/customer/customer_controller.dart';
import 'package:easy_food/controllers/product/basket_controller.dart';
import 'package:easy_food/controllers/user/address_controller.dart';
import 'package:easy_food/ui/foundation_button.dart';
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
    } else if (basketController.addressId.value == null) {
      showToastMessage("Lütfen Adres Seçiniz", Colors.red);
    } else {
      basketController
          .sendCartToServer(totalPrice)
          .then((value) => basketController.setComplateOrder());
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
        if (!basketController.complateOrder.value) {
          return Column(
            children: [
              if (addressController.loadingAllAddress.value)
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: dropdownSelectAdress(context),
                ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: dropdownSelectPayment(context),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: orderNote(context),
              ),
              FoundationButton("Siparişi Tamala", () => completeOrder())
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
                  ],
                ),
              ),
            ],
          );
        }
      })),
    );
  }

  Widget dropdownSelectAdress(context) {
    return Container(
      height: Get.height * 0.05,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.onBackground, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
            isExpanded: true,
            value: basketController.addressId.value,
            items: [
              for (var i in addressController.allAddress)
                DropdownMenuItem<String>(
                    child: Text(i.addressTypeQw), value: i.frmUserAdressId),
            ],
            hint: Text("Address Seçiniz"),
            onChanged: (data) => basketController.selectedAddress(data)),
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
