import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_food/controllers/user/address_controller.dart';

class SelectAddress extends StatelessWidget {
  final AddressController addressController = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 2.0,
          centerTitle: true,
          title: Text('Adres Seç',
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 20.0,
                  color: Theme.of(context).colorScheme.primaryVariant)),
        ),
        body: Obx(() {
          if (addressController.loadingAllAddress.value) {
            return Column(children: [
              for (var i in addressController.allAddress)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () {
                      addressController.selectNewAddres(i.frmUserAdressId);
                      Get.back();
                    },
                    child: Card(
                      elevation: 8,
                      child: Column(
                        children: [
                          ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  i.addressTypeQw,
                                  style: context.theme.textTheme.headline5,
                                ),
                                Obx(() {
                                  if (i.frmUserAdressId ==
                                      addressController
                                          .firstAddress.value.frmUserAdressId) {
                                    return Icon(
                                      Icons.check_circle,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    );
                                  } else
                                    return Container();
                                })
                              ],
                            ),
                            leading: i.addressTypeQw == "Ev"
                                ? Icon(
                                    Icons.home,
                                    size: 28.0,
                                    color: Colors.black,
                                  )
                                : Icon(Icons.work,
                                    size: 28.0, color: Colors.black),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(i.complateAddress),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ]);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }));
  }
}
