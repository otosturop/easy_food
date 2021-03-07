import 'package:easy_food/components/foundation_button.dart';
import 'package:easy_food/components/selectAddress.dart';
import 'package:easy_food/controllers/user/address_controller.dart';
import 'package:easy_food/screens/customer_filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartSelectBox extends StatelessWidget {
  final AddressController addressController = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 15.0),
          Text(
            'Kayıtlı Adreslerim',
            style: Theme.of(context).textTheme.headline5,
          ),
          Obx(() {
            if (addressController.loadingAllAddress.value) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 8,
                  child: Column(
                    children: [
                      ListTile(
                        trailing: IconButton(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              size: 48.0,
                            ),
                            onPressed: () => Get.to(SelectAddress())),
                        leading: IconButton(
                            icon: Icon(
                              Icons.home_sharp,
                              size: 48.0,
                            ),
                            onPressed: () {}),
                        title: Center(
                          child: Text(
                            addressController.firstAddress.value.addressTypeQw,
                            style: context.theme.textTheme.headline5,
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
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
          FoundationButton("Restoranları Listele", () {
            Get.to(CustomerFilter());
          })
        ],
      ),
    );
  }
}
