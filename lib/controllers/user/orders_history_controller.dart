import 'package:easy_food/data/user/orders_history_api.dart';
import 'package:easy_food/model/user/OrdersHistoryModel.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersHistoryController extends GetxController {
  var allOrdersHistory = List<Data>.empty().obs;
  var loadingOrders = false.obs;
  var isLogin = true.obs;
  OrdersHistory _orderHistoryApi = OrdersHistory();

  Future getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('token')) {
      isLogin.value = false;
    } else {
      isLogin.value = true;
      update();
      String userId = prefs.getString('userId');
      return userId;
    }
  }

  @override
  void onInit() async {
    String userId = await getUserId();
    if (isLogin.value) getOrdersHistory(userId);
    super.onInit();
  }

  Future<void> getOrdersHistory(userId) async {
    try {
      loadingOrders(false);
      var allOrders = await _orderHistoryApi.getOrdersHistory(userId);

      if (allOrders != null) {
        allOrdersHistory(allOrders.data);
      }
    } finally {
      loadingOrders(true);
    }
  }
}
