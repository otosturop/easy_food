class UserInfoModel {
  List<Data> data;

  UserInfoModel({this.data});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
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
  String userName;
  String userId;
  String email;
  String fullName;
  String profilePictureId;
  String authExternalId;
  String lkpAuthExternalSource;
  String lkpAuthExternalSourceQw;
  String phone;
  String photo;

  Data(
      {this.userName,
      this.userId,
      this.email,
      this.fullName,
      this.profilePictureId,
      this.authExternalId,
      this.lkpAuthExternalSource,
      this.lkpAuthExternalSourceQw,
      this.phone,
      this.photo});

  Data.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    userId = json['user_id'];
    email = json['email'];
    fullName = json['full_name'];
    profilePictureId = json['profile_picture_id'];
    authExternalId = json['auth_external_id'];
    lkpAuthExternalSource = json['lkp_auth_external_source'];
    lkpAuthExternalSourceQw = json['lkp_auth_external_source_qw_'];
    phone = json['phone'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['user_id'] = this.userId;
    data['email'] = this.email;
    data['full_name'] = this.fullName;
    data['profile_picture_id'] = this.profilePictureId;
    data['auth_external_id'] = this.authExternalId;
    data['lkp_auth_external_source'] = this.lkpAuthExternalSource;
    data['lkp_auth_external_source_qw_'] = this.lkpAuthExternalSourceQw;
    data['phone'] = this.phone;
    data['photo'] = this.photo;
    return data;
  }
}
