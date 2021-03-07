import 'package:easy_food/components/status_button.dart';
import 'package:easy_food/controllers/customer/customer_controller.dart';
import 'package:easy_food/controllers/user/address_controller.dart';
import 'package:easy_food/screens/food.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerFilter extends StatelessWidget {
  final CustomerController customerController = Get.put(CustomerController());
  final AddressController addressController = Get.put(AddressController());

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
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(addressController.firstAddress.value.addressTypeQw,
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20.0,
                color: Theme.of(context).colorScheme.primaryVariant)),
      ),
      body: ListView(
        children: [
          for (var i in customerController.allCustomers)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                elevation: 4,
                child: Column(
                  children: [
                    ListTile(
                      leading: FadeInImage.assetNetwork(
                        placeholder: "assets/loading.gif",
                        image: customerController.imgPath + i.logoPath,
                        width: Get.width * 0.2,
                      ),
                      title: Text(
                        i.name,
                        style: context.theme.textTheme.headline6,
                      ),
                      subtitle: Text(i.metaData),
                      trailing: Container(
                        child: IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          color: Theme.of(context).colorScheme.surface,
                          onPressed: () {
                            Get.to(Food(i.frmCustomerId));
                          },
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (i.customerStatusQw == "Open")
                          StatusButton("Açık", Colors.green),
                        if (i.customerStatusQw != "Open")
                          StatusButton("Kapalı", Colors.red),
                        Column(
                          children: [
                            Center(
                              child: Text(
                                "Çalışma Saatleri",
                                style: context.theme.textTheme.headline6,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(i.workTimeStart + " - "),
                                Text(i.workTimeEnd)
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_outlined,
                                size: 16,
                              ),
                              Text(i.orderTime)
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                size: 16,
                              ),
                              Text(i.phoneNumber)
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
