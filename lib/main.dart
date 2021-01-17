import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_food/screens/customer.dart';
import 'package:easy_food/ui/theme/app_theme_light.dart';
import 'package:flutter/material.dart';
import 'package:easy_food/controllers/bottom_bar_controller.dart';
import 'package:easy_food/screens/food_basket.dart';
import 'package:easy_food/screens/home.dart';
import 'package:easy_food/screens/profile.dart';
import 'package:easy_food/screens/search.dart';
import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Food',
      theme: AppThemeLight.instance.theme,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final BottomBarController navController = Get.put(BottomBarController());

  final screens = <Widget>[
    Home(),
    Profile(),
    Customer(),
    Search(),
    FoodBasket(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return buildHomePage(currentIndex: navController.selectedIndex);
  }

  Scaffold buildHomePage({int currentIndex}) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 2.0,
        centerTitle: true,
        title: Obx(() {
          return Text(
            navController.pageTitle[navController.selectedIndex],
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20.0,
                color: Theme.of(context).colorScheme.primaryVariant),
          );
        }),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout,
                color: Theme.of(context).colorScheme.primaryVariant),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() => PageStorage(
            bucket: bucket,
            child: screens[navController.selectedIndex],
          )),
      bottomNavigationBar: Obx(() => CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: navController.selectedIndex,
            height: Get.height * 0.065,
            items: <Widget>[
              Icon(Icons.home,
                  size: 25, color: navController.currentIconColor[0]),
              Icon(Icons.person_outline,
                  size: 25, color: navController.currentIconColor[1]),
              Icon(Icons.fastfood,
                  size: 25, color: navController.currentIconColor[2]),
              Icon(Icons.search,
                  size: 25, color: navController.currentIconColor[3]),
              Icon(Icons.shopping_basket,
                  size: 25, color: navController.currentIconColor[4]),
            ],
            color: Theme.of(context).colorScheme.background,
            backgroundColor: Theme.of(context).colorScheme.surface,
            buttonBackgroundColor: Theme.of(context).colorScheme.background,
            animationCurve: Curves.bounceInOut,
            animationDuration: Duration(milliseconds: 300),
            onTap: (index) {
              navController.navigationTransition(index);
            },
          )),
    );
  }
}
