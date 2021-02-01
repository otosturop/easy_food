class AssignRoleModel {
  bool success;
  Outs outs;

  AssignRoleModel({this.success, this.outs});

  AssignRoleModel.fromJson(Map<String, dynamic> json) {
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
  int userRoleId;

  Outs({this.userRoleId});

  Outs.fromJson(Map<String, dynamic> json) {
    userRoleId = json['user_role_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_role_id'] = this.userRoleId;
    return data;
  }
}
