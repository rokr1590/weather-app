class UserModel {
  UserModel({
    required this.displayName,
    required this.email
  });

  late final String displayName;
  late final String email;

  UserModel.fromJson(Map<String,dynamic> json){
    displayName = json['displayName'];
    email = json['email'];
  }

  Map<String,dynamic> toJson() {
    final _data = <String,dynamic>{};
    _data['displayName'] = displayName;
    _data['email'] = email;
    return _data;
  }
}