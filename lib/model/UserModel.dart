class UserModel{

  String? name;
  String? email;
  String? password;
  String? gender;
  String? dob;
  String? accountCreated;
  String? image;

  UserModel({this.name,this.email,this.password,this.gender,this.dob,this
  .accountCreated,this.image});

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      gender: json['gender'],
      dob: json['dob'],
      accountCreated: json['accountCreated'],
      image: json['image'],
    );
  }

}