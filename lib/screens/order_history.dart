import 'package:easy_food/controllers/customer/customer_controller.dart';
import 'package:easy_food/controllers/user/orders_history_controller.dart';
import 'package:easy_food/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderHistory extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final OrdersHistoryController order = Get.put(OrdersHistoryController());
  final CustomerController customer = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Obx(() {
        if (order.isLogin.value) {
          if (!order.loadingOrders.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView(
              children: [
                for (var i in order.allOrdersHistory.reversed)
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Obx(() {
                      if (customer.isLoading.value) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          elevation: 4,
                          child: Column(children: [
                            ListTile(
                              leading: FadeInImage.assetNetwork(
                                placeholder: "assets/loading.gif",
                                image: customer.imgPath +
                                    customer.getCustomer(i.customerId).logoPath,
                                width: Get.width * 0.25,
                              ),
                              title: Text(
                                customer.getCustomer(i.customerId).name,
                                style: context.theme.textTheme.headline6,
                              ),
                              subtitle: Text("Tarih: " + i.orderDate),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                "Sipariş Numarası: " + i.frmOrdersId,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Tutar: " + i.totalPrice + "₺",
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                  Container(
                                    child: IconButton(
                                      icon: Icon(Icons.arrow_forward_ios),
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      onPressed: () {
                                        // Get.to(Food(i.frmCustomerId));
                                      },
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ]),
                        );
                      }
                    }),
                  )
              ],
            );
          }
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Lütfen Giriş Yapınız",
                  style: Theme.of(context).textTheme.headline6,
                ),
                TextButton(
                    child: Text('Giriş Yapmak için Tıklayınız.'),
                    onPressed: () {
                      Get.to(SignIn());
                    })
              ],
            ),
          );
        }
      }),
    );
  }
}
