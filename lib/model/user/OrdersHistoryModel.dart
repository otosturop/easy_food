class OrdersHistoryModel {
  List<Data> data;

  OrdersHistoryModel({this.data});

  OrdersHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String frmOrdersId;
  String addressId;
  String paymentMethods;
  String paymentMethodsQw;
  String orderDescription;
  String totalPrice;
  String orderNumber;
  String orderStatusId;
  String orderStatusIdQw;
  String assignedDriverUserId;
  String orderAddress;
  String userId;
  String customerId;
  String orderDate;
  String sendDate;
  String cancelNote;

  Data(
      {this.frmOrdersId,
      this.addressId,
      this.paymentMethods,
      this.paymentMethodsQw,
      this.orderDescription,
      this.totalPrice,
      this.orderNumber,
      this.orderStatusId,
      this.orderStatusIdQw,
      this.assignedDriverUserId,
      this.orderAddress,
      this.userId,
      this.customerId,
      this.orderDate,
      this.sendDate,
      this.cancelNote});

  Data.fromJson(Map<String, dynamic> json) {
    frmOrdersId = json['frm_orders_id'];
    addressId = json['address_id'];
    paymentMethods = json['payment_methods'];
    paymentMethodsQw = json['payment_methods_qw_'];
    orderDescription = json['order_description'];
    totalPrice = json['total_price'];
    orderNumber = json['order_number'];
    orderStatusId = json['order_status_id'];
    orderStatusIdQw = json['order_status_id_qw_'];
    assignedDriverUserId = json['assigned_driver_user_id'];
    orderAddress = json['order_address'];
    userId = json['user_id'];
    customerId = json['customer_id'];
    orderDate = json['order_date'];
    sendDate = json['send_date'];
    cancelNote = json['cancel_note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['frm_orders_id'] = this.frmOrdersId;
    data['address_id'] = this.addressId;
    data['payment_methods'] = this.paymentMethods;
    data['payment_methods_qw_'] = this.paymentMethodsQw;
    data['order_description'] = this.orderDescription;
    data['total_price'] = this.totalPrice;
    data['order_number'] = this.orderNumber;
    data['order_status_id'] = this.orderStatusId;
    data['order_status_id_qw_'] = this.orderStatusIdQw;
    data['assigned_driver_user_id'] = this.assignedDriverUserId;
    data['order_address'] = this.orderAddress;
    data['user_id'] = this.userId;
    data['customer_id'] = this.customerId;
    data['order_date'] = this.orderDate;
    data['send_date'] = this.sendDate;
    data['cancel_note'] = this.cancelNote;
    return data;
  }
}
