class UpdateUserInfoModel {
  int formId;
  bool success;

  UpdateUserInfoModel({this.formId, this.success});

  UpdateUserInfoModel.fromJson(Map<String, dynamic> json) {
    formId = json['formId'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['formId'] = this.formId;
    data['success'] = this.success;
    return data;
  }
}
