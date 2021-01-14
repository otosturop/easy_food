import 'package:easy_food/controllers/product/basket_controller.dart';
import 'package:easy_food/controllers/product/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:easy_food/ui/food_item.dart';
import 'package:get/get.dart';

class Food extends StatefulWidget {
  final String customerId;

  const Food(this.customerId);
  @override
  _FoodState createState() => _FoodState();
}

class _FoodState extends State<Food> with SingleTickerProviderStateMixin {
  TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final CategoryController categoryController = Get.put(CategoryController());
  final BasketController basketController = Get.put(BasketController());

  Future getCategoryLength() async {
    await categoryController.fetchCategory(widget.customerId);
    int categoryLength = categoryController.categoryList.length;
    return categoryLength;
  }

  @override
  initState() {
    basketController.assignCustomerId(widget.customerId);
    getCategoryLength().then((value) {
      _tabController = TabController(length: value, vsync: this);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade400,
          elevation: 2.0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text('Products',
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 20.0,
                  color: Color(0xFF545D68))),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_cart, color: Color(0xFF545D68)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.only(left: 20),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: SizedBox(
                height: Get.height * 0.05,
                child: Text(
                  'Categories',
                  style: context.theme.textTheme.headline5,
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.075,
              child: Obx(() {
                if (categoryController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.transparent,
                    labelColor: Color(0xFFC88D67),
                    isScrollable: true,
                    labelPadding: EdgeInsets.only(right: 45.0),
                    unselectedLabelColor: Color(0xFFCDCDCD),
                    tabs: [
                      for (var i in categoryController.categoryList)
                        Tab(
                          child: Text(i.name.toString(),
                              style: TextStyle(
                                fontFamily: 'Varela',
                                fontSize: 21.0,
                              )),
                        ),
                    ],
                  );
                }
              }),
            ),
            SizedBox(
              height: Get.height * 0.67,
              child: Obx(() {
                if (categoryController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Container(
                    width: double.infinity,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        for (var i in categoryController.categoryList)
                          FoodItem(i.frmProductCategoriesId),
                      ],
                    ),
                  );
                }
              }),
            ),
          ],
        ));
  }
}
