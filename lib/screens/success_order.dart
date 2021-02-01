import 'package:easy_food/controllers/bottom_bar_controller.dart';
import 'package:easy_food/main.dart';
import 'package:easy_food/ui/app_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LastOrder extends StatefulWidget {
  LastOrder({Key key}) : super(key: key);

  @override
  _LastOrderState createState() => _LastOrderState();
}

class _LastOrderState extends State<LastOrder> {
  final BottomBarController navController = Get.put(BottomBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBarItem(() {
          navController.navigationTransition(2);
          Get.to(MyHomePage());
        },
            "Siparişiniz Onaylandı",
            Icon(Icons.logout,
                color: Theme.of(context).colorScheme.primaryVariant)),
        preferredSize: Size.fromHeight(50.0),
      ),
      body: Center(
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
    );
  }
}
