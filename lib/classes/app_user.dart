import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  String uid;
  String email;
  int adress;
 // int role;
//  double credit;

  AppUser({
    this.uid,
    this.email,
    this.adress,
//    this.role,
//   this.credit,
  });

  AppUser fromJson(Map<String, dynamic> json) {
    return AppUser(
      uid: json["id"] as String,
      email: json["email"] as String,
      adress: json["adress"] as int,
//      role: json["phone"] as int,
//      credit: json["credit"],
    );
  }

  Map<String, dynamic> toJson(AppUser appUser) => <String, dynamic>{
        "id": appUser.uid,
        "email": appUser.email,
        "adress": appUser.adress,
//        "credit": appUser.credit,
//        "role": appUser.role,
      };
}