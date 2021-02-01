class RegisterModel {
  bool success;
  Outs outs;

  RegisterModel({this.success, this.outs});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    outs = json['outs'] != null ? new Outs.fromJson(json['outs']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.outs != null) {
      data['outs'] = this.outs.toJson();
    }
    return data;
  }
}

class Outs {
  int userId;

  Outs({this.userId});

  Outs.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    return data;
  }
}
