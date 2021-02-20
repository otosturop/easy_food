import 'package:easy_food/controllers/product/basket_controller.dart';
import 'package:flutter/material.dart';
import 'package:easy_food/main.dart';
import 'package:easy_food/controllers/bottom_bar_controller.dart';
import 'package:get/get.dart';

class AppBarBasket extends StatelessWidget {
  final BottomBarController navController = Get.put(BottomBarController());
  final BasketController basketController = Get.put(BasketController());

  @override
  Widget build(BuildContext context) => Obx(() {
        if (basketController.myBasket.length.isEqual(0)) {
          return IconButton(
            icon: Icon(Icons.shopping_cart,
                color: Theme.of(context).colorScheme.primaryVariant),
            onPressed: () {
              navController.navigationTransition(4);
              Get.to(MyHomePage());
            },
          );
        } else {
          return ActionChip(
              avatar: Icon(Icons.shopping_cart,
                  color: Theme.of(context).colorScheme.primaryVariant),
              label: Text(basketController.myBasket.length.toString()),
              onPressed: () {
                navController.navigationTransition(4);
                Get.to(MyHomePage());
              });
        }
      });
}
