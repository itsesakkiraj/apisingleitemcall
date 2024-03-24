class DataModel {
  final int id;
  final String email;
  final String firstname;
  final String lastname;
  final String avatar;

  DataModel(
      {required this.id,
      required this.email,
      required this.firstname,
      required this.lastname,
      required this.avatar});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
        id: json['id'],
        email: json['email'],
        firstname: json['first_name'],
        lastname: json['last_name'],
        avatar: json['avatar']);
  }
}
