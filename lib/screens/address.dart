import 'package:easy_food/controllers/user/address_controller.dart';
import 'package:easy_food/ui/foundation_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Address extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AddressController addressController = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        children: [
          SizedBox(height: 15.0),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Kayıtlı Adreslerim',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Ink(
                    decoration: ShapeDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: CircleBorder()),
                    child: Obx(() {
                      return IconButton(
                          icon: addressController.iconStatus(),
                          color: Colors.white,
                          onPressed: () {
                            addressController.addAdressStatusChange();
                          });
                    })),
              ],
            ),
          ),
          SizedBox(height: 15.0),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Obx(() {
              if (addressController.insertAddressStatus.value) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    dropdownSelectItemsType(
                        context, addressController.adressType),
                    SizedBox(height: 30.0),
                    dropdownSelectCity(context),
                    SizedBox(height: 15.0),
                    if (addressController.loadingCounties.value)
                      dropdownSelectItems(
                          context, addressController.selectedCounties),
                    SizedBox(height: 15.0),
                    if (addressController.loadingArea.value)
                      dropdownSelectItemsArea(
                          context, addressController.selectedAreas),
                    SizedBox(height: 15.0),
                    if (addressController.loadingNeighborhood.value)
                      dropdownSelectNeighborhood(
                          context, addressController.selectedNeighborhoods),
                    SizedBox(height: 15.0),
                    myAdress(context),
                    SizedBox(height: 15.0),
                    FoundationButton("Adres Ekle", () {})
                  ],
                );
              } else {
                return Column(children: [
                  for (var i in addressController.allAddress)
                    Card(
                      elevation: 8,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.home,
                              size: 36.0,
                            ),
                            title: Center(
                              child: Text(
                                i.addressTypeQw,
                                style: context.theme.textTheme.headline5,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(i.complateAddress),
                          ),
                        ],
                      ),
                    ),
                ]);
              }
            }),
          )
        ],
      ),
    );
  }

  Container myAdress(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: TextField(
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.edit,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onBackground,
                  width: 2.0),
            ),
            labelText: "Açık Adresinizi Giriniz",
            labelStyle:
                TextStyle(color: Theme.of(context).colorScheme.onBackground)),
        maxLines: 6,
        minLines: 4,
        keyboardType: TextInputType.multiline,
      ),
    );
  }

  Widget dropdownSelectItemsType(context, itemsArray) {
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
            value: addressController.tempTypeVal.value,
            items: [
              for (var i in itemsArray)
                DropdownMenuItem<String>(child: Text(i['type']), value: i['id'])
            ],
            hint: Text("Adres Tipi Seçiniz"),
            onChanged: (value) {
              addressController.selectedType(value);
            }),
      ),
    );
  }

  Widget dropdownSelectCity(context) {
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
            value: "7",
            items: [
              DropdownMenuItem<String>(child: Text("Ankara"), value: "7"),
            ],
            hint: Text("İl Seçiniz"),
            onChanged: (value) {
              print("tipi: " + value.runtimeType.toString());
            }),
      ),
    );
  }

  Widget dropdownSelectItems(context, itemsArray) {
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
            value: addressController.tempCountyVal.value,
            items: [
              for (var i in itemsArray)
                DropdownMenuItem<String>(
                    child: Text(i.countyname), value: i.countiesId),
            ],
            hint: Text("İlçe Seçiniz"),
            onChanged: (value) {
              addressController.selectedCounty(value);
              addressController.getArea(value);
            }),
      ),
    );
  }

  Widget dropdownSelectItemsArea(context, itemsArray) {
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
            value: addressController.tempAreaVal.value,
            items: [
              for (var i in itemsArray)
                DropdownMenuItem<String>(
                    child: Text(i.areaname), value: i.areasId)
            ],
            hint: Text("Bölge Seçiniz"),
            onChanged: (value) {
              addressController.selectedArea(value);
              addressController.getNeighborhood(value);
            }),
      ),
    );
  }

  Widget dropdownSelectNeighborhood(context, itemsArray) {
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
            value: addressController.tempNeighborhoodVal.value,
            items: [
              for (var i in itemsArray)
                DropdownMenuItem<String>(child: Text(i.dsc), value: i.id),
            ],
            hint: Text("Mahalle Seçiniz"),
            onChanged: (value) {
              addressController.selectedNeighborhood(value.toString());
            }),
      ),
    );
  }
}
