import 'package:flutter/material.dart';
import 'package:easy_food/controllers/product/product_controller.dart';
import 'package:easy_food/screens/food_detail.dart';
import 'package:get/get.dart';

class FoodItem extends StatefulWidget {
  final String categoryId;

  const FoodItem(this.categoryId);

  @override
  _FoodItemState createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItem> {
  final ProductController productController = Get.put(ProductController());
  List products;

  @override
  void initState() {
    super.initState();
    products = productController.getListForCategory(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    //debugPrint(widget.categoryId.toString());
    return Scaffold(
      body: GridView.extent(
        maxCrossAxisExtent: 200,
        primary: false,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 15.0,
        childAspectRatio: 0.8,
        children: <Widget>[
          for (var i in products)
            if (i.name != null && i.price != null) _buildCard(i),
        ],
      ),
    );
  }

  Widget _buildCard(product) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
      child: InkWell(
        onTap: () {
          Get.to(FoodDetail(product: product));
        },
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3.0,
                      blurRadius: 5.0)
                ],
                color: Colors.white),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    (1 != 0)
                        ? Icon(Icons.favorite,
                            color: Theme.of(context).colorScheme.primary)
                        : Icon(Icons.favorite_border,
                            color: Theme.of(context).colorScheme.primary)
                  ],
                ),
              ),
              if (product.photo != "")
                FadeInImage.assetNetwork(
                  placeholder: "assets/loading.gif",
                  image: productController.imgPath + product.photo,
                  height: Get.height * 0.1,
                ),
              if (product.photo == "")
                Container(
                  height: 75.0,
                  width: 75.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/cookiemint.jpg'),
                          fit: BoxFit.contain)),
                ),
              SizedBox(height: Get.height * 0.01),
              Text(
                "${product.price}₺",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontFamily: 'Varela',
                    fontSize: 14.0),
              ),
              SizedBox(height: Get.height * 0.01),
              Text(
                product.name,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontFamily: 'Varela',
                    fontSize: 14.0),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  color: Color(0xFFEBEBEB),
                  height: 1.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Add to cart',
                        style: TextStyle(
                            fontFamily: 'Varela',
                            color:
                                Theme.of(context).colorScheme.secondaryVariant,
                            fontSize: 14.0)),
                    Icon(
                      Icons.add_circle_outline,
                      color: Theme.of(context).colorScheme.secondaryVariant,
                      size: 14.0,
                    )
                  ],
                ),
              )
            ])),
      ),
    );
  }
}
