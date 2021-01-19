import 'package:easy_food/ui/app_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LastOrder extends StatefulWidget {
  LastOrder({Key key}) : super(key: key);

  @override
  _LastOrderState createState() => _LastOrderState();
}

class _LastOrderState extends State<LastOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBarItem(() {}, "Sipariş Onaylandı", Icon(Icons.logout)),
        preferredSize: Size.fromHeight(50.0),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your order is preparing',
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
