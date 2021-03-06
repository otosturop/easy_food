import 'package:easy_food/data/products/material_api.dart';
import 'package:easy_food/model/MaterialModel.dart';
import 'package:get/state_manager.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class MaterialController extends GetxController {
  var isLoading = true.obs;
  var materialList = List<Data>.empty().obs;
  var filterMaterial = List<Data>.empty().obs;
  var removedMaterials = List<Data>.empty().obs;

  var extraMaterial = List<Data>.empty().obs;
  var multiSelectExtraMaterials = List<MultiSelectItem<ExMaterial>>.empty().obs;
  var selectedMaterial = List<ExMaterial>.empty().obs;
  var removeMetarialState = false.obs;
  MaterialApi _api = MaterialApi();

  Future fetchMaterial(String userId) async {
    try {
      isLoading(true);
      var materials = await _api.getMaterials(userId);
      if (materials != null) {
        materialList(materials.data);
      }
    } finally {
      isLoading(false);
    }
  }

  getListForMaterial(List materialListId) {
    if (materialList.length > 0) {
      filterMaterial.clear();
      List<Data> temp = [];
      for (var i in materialListId) {
        temp.add(materialList.firstWhere((e) => e.frmProductMaterialsId == i,
            orElse: () => null));
      }
      if (temp[0] != null) {
        filterMaterial(temp).toList();
      }
    }
  }

  getListExtraMaterial(List extraMaterialId) {
    if (materialList.length > 0) {
      extraMaterial.clear();
      List<Data> tempExtraMaterial = [];
      for (var i in extraMaterialId) {
        tempExtraMaterial.add(materialList.firstWhere(
            (e) => e.frmProductMaterialsId == i,
            orElse: () => null));
      }
      if (tempExtraMaterial[0] != null) {
        extraMaterial(tempExtraMaterial);

        List<ExMaterial> exMaterials = [];

        extraMaterial.forEach((i) {
          exMaterials.add(ExMaterial(
              int.parse(i.frmProductMaterialsId),
              i.productMaterials +
                  " - " +
                  double.parse(i.amount).toStringAsFixed(2) +
                  "₺",
              double.parse(i.amount)));
        });

        var temp = exMaterials
            .map((e) => MultiSelectItem<ExMaterial>(e, e.name))
            .toList();
        multiSelectExtraMaterials(temp);
        update();
      }
    }
  }

  // ekstara materyal ekleme
  selectExtraMaterial(extraMaterial) {
    selectedMaterial.clear();
    var ids = extraMaterial.map((e) => e.id).toSet().toList();
    ids.forEach((item) {
      var tempEx = extraMaterial.firstWhere((ex) => ex.id == item);
      //print("name extramaterial: " + tempEx.name);
      var tempName = tempEx.name.split("-");
      tempEx.name = tempName[0].toString();
      selectedMaterial.add(tempEx);
    });
  }

  removeMaterial(String materialId) {
    removeMetarialState(!removeMetarialState.value);
    var item =
        filterMaterial.firstWhere((x) => x.frmProductMaterialsId == materialId);
    filterMaterial.remove(item);
    removedMaterials.add(item);
  }

  void resetMaterials() {
    selectedMaterial.clear();
    filterMaterial.clear();
  }
}

class ExMaterial {
  final int id;
  String name;
  final double price;
  ExMaterial(this.id, this.name, this.price);
}
