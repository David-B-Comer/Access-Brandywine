class User {
  String id;
  String name;
  String phone;
  String email;
  String img;

  User({this.id, this.name, this.phone, this.email, this.img});

  User.fromMap(Map snapshot, String id)
      : name = '',
        phone = snapshot['phone'] ?? '',
        email = snapshot['email'] ?? '',
        img = snapshot['img'] ?? '';

  toJson() {
    return {
      "name": name,
      "phone": phone,
      "email": email,
      "img": img,
    };
  }
}
