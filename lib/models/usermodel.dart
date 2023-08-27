class UserModel {
  String? id;
  String? email;
  String? name;
  String? phone;
  String? dateTime ;

  UserModel({
    this.email,
    this.phone,
    this.name,
    this.id,
    this.dateTime
  });

  UserModel.fromjson(Map<dynamic, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
    name = json['name'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> tomap() {
    return {
      "name": name,
      "id": id,
      "phone": phone,
      "email": email,
      "dateTime": dateTime,
    };
  }
}
