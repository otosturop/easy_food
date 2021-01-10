import 'package:easy_food/data/products/material_api.dart';
import 'package:easy_food/model/MaterialModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class MaterialController extends GetxController {
  var isLoading = true.obs;
  var materialList = List<Data>.empty().obs;
  var filterMaterial = List<Data>.empty().obs;
  var extraMaterial = List<Data>.empty().obs;
  var multiSelectExtraMaterials = List<MultiSelectItem<ExMaterial>>.empty().obs;
  var selectedMaterial = List<ExMaterial>.empty().obs;
  var removeMetarialState = false.obs;
  MaterialApi _api = MaterialApi();

  @override
  void onInit() async {
    super.onInit();
  }

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
      filterMaterial = RxList<Data>(null);
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
      extraMaterial = RxList<Data>();
      List<Data> tempExtraMAterial = [];
      for (var i in extraMaterialId) {
        tempExtraMAterial.add(materialList.firstWhere(
            (e) => e.frmProductMaterialsId == i,
            orElse: () => null));
      }
      if (tempExtraMAterial[0] != null) {
        extraMaterial(tempExtraMAterial);

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
      }
    }
  }

  selectExtraMaterial(extraMaterial) {
    selectedMaterial(extraMaterial);
  }

  removeMaterial(String materialId) {
    removeMetarialState(!removeMetarialState.value);
    var item =
        filterMaterial.firstWhere((x) => x.frmProductMaterialsId == materialId);
    filterMaterial.remove(item);
  }

  void resetMaterials() {
    selectedMaterial.clear();
    filterMaterial.clear();
  }
}

class ExMaterial {
  final int id;
  final String name;
  final double price;
  ExMaterial(this.id, this.name, this.price);
}
