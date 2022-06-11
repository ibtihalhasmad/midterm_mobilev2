class User {
  String? userEmail;
  String? userPassword;
  String? userName;
  String? userPhone;
  String? userHomeaddress;

  User(
      {this.userEmail,
      this.userPassword,
      this.userName,
      this.userPhone,
      this.userHomeaddress,});

 User.fromJson(Map<String, dynamic> json) {
    userEmail = json['user_email'];
    userPassword = json['user_password'];
    userName = json['user_name'];
    userPhone = json['user_phone'];
    userHomeaddress = json['user_homeaddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_email'] = userEmail;
    data['user_password'] = userPassword;
    data['user_name'] = userName;
    data['user_phone'] = userPhone;
    data['user_homeaddress'] = userHomeaddress;
    return data;
  }
}