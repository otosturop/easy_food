import 'package:easy_food/components/cardSelectBox.dart';
import 'package:easy_food/components/status_button.dart';
import 'package:easy_food/controllers/customer/customer_controller.dart';
import 'package:easy_food/controllers/product/product_controller.dart';
import 'package:easy_food/screens/food.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Customer extends StatefulWidget {
  @override
  _CustomerState createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  final CustomerController customerController = Get.put(CustomerController());
  final ProductController productController = Get.put(ProductController());

  @override
  void initState() {
    productController.fetchAllProducts();
    customerController.getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      if (customerController.isLogin.value) {
        return CartSelectBox();
      } else {
        if (customerController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
          );
        }
      }
    }));
  }
}
