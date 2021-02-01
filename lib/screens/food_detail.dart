import 'package:easy_food/controllers/bottom_bar_controller.dart';
import 'package:easy_food/controllers/product/basket_controller.dart';
import 'package:easy_food/ui/foundation_button.dart';
import 'package:flutter/material.dart';
import 'package:easy_food/controllers/product/menu_controller.dart';
import 'package:easy_food/controllers/product/product_controller.dart';
import 'package:easy_food/controllers/product/material_controller.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FoodDetail extends StatefulWidget {
  final product;

  FoodDetail({this.product});

  @override
  _FoodDetailState createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  final BottomBarController navController = Get.put(BottomBarController());
  final ProductController productController = Get.put(ProductController());
  final MaterialController materialController = Get.put(MaterialController());
  final MenuController menuController = Get.put(MenuController());
  final BasketController basketController = Get.put(BasketController());
  bool alreadyMaterial = false;

  Future<void> getMaterial(userId) async {
    await materialController.fetchMaterial(userId).then((value) {
      if (widget.product.materialsRemoved != "") {
        List matArr = widget.product.materialsRemoved.split(',');
        materialController.getListForMaterial(matArr);
      }
      if (widget.product.productMaterials != "") {
        List extraArr = widget.product.productMaterials.split(",");
        materialController.getListExtraMaterial(extraArr);
      }
    });
  }

  Future<void> getMenuList(productId) async {
    await menuController.fetchMenu(productId);
  }

  @override
  void initState() {
    super.initState();
    debugPrint("ürün id " + widget.product.frmProductId);
    //basket initial
    basketController.getProductAmount(widget.product.frmProductId,
        widget.product.name, "1", double.parse(widget.product.price));
    menuController.assignTempVal(00, "temp");
    menuController.clearSelectedMenu();
    materialController.resetMaterials();
    if (widget.product.isMenu) {
      debugPrint("menu var");
      getMenuList(widget.product.frmProductId);
    }
    if (widget.product.productMaterials != "") {
      debugPrint("material var");
      alreadyMaterial = true;
      getMaterial(basketController.customerId.value);
    }
    if (widget.product.materialsRemoved != "") {
      if (alreadyMaterial) {
        getMaterial(basketController.customerId.value);
      }
      debugPrint("kaldırılabilir material var");
    }
  }

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
        title: Text('Product Detail',
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20.0,
                color: Theme.of(context).colorScheme.primaryVariant)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart,
                color: Theme.of(context).colorScheme.primaryVariant),
            onPressed: () {
              navController.navigationTransition(4);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //ürün Adı Başlığı
          Expanded(
            flex: 2,
            child: SizedBox(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  widget.product.name,
                  style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
          ),
          //Ürün Resmi
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              child: FadeInImage.assetNetwork(
                placeholder: "assets/loading.gif",
                image: productController.imgPath + widget.product.photo,
                fit: BoxFit.contain,
              ),
            ),
          ),
          //Ürüb adet seçimi ve fiyatı
          Expanded(
            flex: 2,
            child: Obx(() {
              return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        width: Get.width * 0.4,
                        height: Get.height * 0.05,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: basketController.productAmount.toString(),
                            items: [
                              for (int i = 1; i < 11; i++)
                                DropdownMenuItem(
                                  child: Text(i.toString() + " adet"),
                                  value: i.toString(),
                                )
                            ],
                            onChanged: (value) {
                              basketController.getProductAmount(
                                  widget.product.frmProductId,
                                  widget.product.name,
                                  value,
                                  double.parse(widget.product.price));
                            },
                          ),
                        )),
                    Text("${widget.product.price}₺",
                        style: TextStyle(
                            fontFamily: 'Varela',
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary)),
                  ]);
            }),
          ),
          //Ürün Açıklaması
          Expanded(
            flex: 2,
            child: Center(
              child: Text(widget.product.description,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontFamily: 'Varela',
                      fontSize: 12.0)),
            ),
          ),
          if (widget.product.materialsRemoved != "")
            Expanded(
              flex: 3,
              child: Obx(() {
                if (materialController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (materialController.filterMaterial.length > 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 5.0, bottom: 0, left: 16.0, right: 5.0),
                          child: Text(
                            'Malzemeler',
                            style: TextStyle(
                                fontFamily: 'Varela',
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.all(2.0),
                          child: buildChipListTile(),
                        ),
                      ],
                    );
                  } else {
                    return Container(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Malzeme Bulunamadı",
                          style:
                              TextStyle(fontFamily: 'Varela', fontSize: 14.0),
                        ),
                      ),
                    );
                  }
                }
              }),
            ),
          if (widget.product.productMaterials != "")
            Expanded(
                flex: 3,
                child: Obx(() {
                  if (materialController.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 0, bottom: 0, right: 8.0),
                      child: MultiSelectChipField(
                        items: materialController.multiSelectExtraMaterials,
                        icon: Icon(Icons.check),
                        title: Text(
                          "Extra Material",
                          style: TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.bold),
                        ),
                        headerColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.5),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.onPrimary,
                              width: 1.8),
                        ),
                        selectedChipColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.5),
                        selectedTextStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 12.0),
                        onTap: (values) {
                          /*values
                              .map((e) => print("detail " + e.name))
                              .toString();
                          print("--bitti--"); */
                          materialController.selectExtraMaterial(values);
                        },
                      ),
                    );
                  }
                })),
          if ((widget.product.materialsRemoved == "" ||
                  widget.product.productMaterials == "") &&
              widget.product.isMenu)
            Expanded(
              flex: 7,
              child: Obx(() {
                if (menuController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Column(children: [
                    Text(
                      'Menu Seçimleri',
                      style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                          width: Get.width * 0.9,
                          child: Obx(() {
                            if (menuController.isLoading.value) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              return Column(
                                children: [
                                  for (int m = 0;
                                      m < menuController.menuList.length;
                                      m++)
                                    dropdownSelectItems(m,
                                        menuController.menuList[m].productIds),
                                ],
                              );
                            }
                          })),
                    ),
                  ]);
                }
              }),
            ),
          Expanded(
            flex: 2,
            child: FoundationButton("Sepete Ekle", () {
              basketController.addProductinMyBasket(
                  materialController.selectedMaterial.toList(),
                  materialController.removedMaterials.toList(),
                  menuController.selectedMenu.toList());

              showToastMessage("Ürün sepete başarıyla eklendi",
                  Theme.of(context).colorScheme.onSecondary);
              Get.back();
            }),
          )
        ],
      ),
    );
  }

  Widget buildChipListTile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // filterMaterial state saçma bir şekilde güncellenmediği için böyle bir gereksiz if koydum
        if (materialController.removeMetarialState.value ||
            !materialController.removeMetarialState.value)
          for (var x in materialController.filterMaterial)
            Container(
              margin: EdgeInsets.all(5.0),
              child: Chip(
                label: Text(x.productMaterials),
                elevation: 6,
                deleteIcon: Icon(Icons.cancel),
                onDeleted: () {
                  //debugPrint("delete chip materialid" + x.frmProductMaterialsId);
                  materialController.removeMaterial(x.frmProductMaterialsId);
                },
              ),
            ),
      ],
    );
  }

  //menu select listesi
  Widget dropdownSelectItems(index, menus) {
    var menuItem = menus.split(',');
    return Container(
      height: Get.height * 0.05,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.onBackground, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
            isExpanded: true,
            value: menuController.tempMenuVal[index],
            items: [
              for (var i in menuItem)
                DropdownMenuItem(
                    child: Text(productController.getProduct(i).name +
                        " - " +
                        productController.getProduct(i).price +
                        "₺"),
                    value:
                        "${productController.getProduct(i).frmProductId},${productController.getProduct(i).name}")
            ],
            hint: Text("Select Menu Items"),
            onChanged: (value) {
              //menu listesi ve değerleri
              menuController.assignTempVal(index, value);
            }),
      ),
    );
  }

  void showToastMessage(String message, Color toastColor) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: toastColor,
        textColor: Theme.of(context).colorScheme.surface,
        fontSize: 16.0);
  }
}
