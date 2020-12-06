import '../classes/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthService {
  static AppUser authenticatedUser;
  FirebaseAuth _auth = FirebaseAuth.instance;

/*  Future<String> signupCustomer(String email, String password, String name,
      String surname, String phone) async {
    if (email.trim().isEmpty || !email.trim().contains("@")) {
      return "Please enter a valid email address";
    }
    if (password.trim().isEmpty || password.trim().length < 7) {
      return "Password must be at least 7 characters long";
    }
    if (name.trim().isEmpty || name.trim().length < 4) {
      return "Name must be at least 4 characters long";
    }
    if (surname.trim().isEmpty || surname.trim().length < 4) {
      return "Surname must be at least 4 characters long";
    }
    if (phone.trim().length != 10) {
      return "Phone must be 10 characters long";
    }
    try {
      print("girdiii");
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user.uid)
          .set(
        {
          "name": name.trim(),
          "surname": surname.trim(),
          "credit": 0,
          "role": 0,
        },
      );

      return null;
    } on PlatformException catch (err) {
      var message = "An error occured, please check your credentials!";

      if (err.message != null) {
        message = err.message;
      }
      throw message;
    } catch (err) {
      throw err.message;
    }
  }
*/
  Future<AppUser> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      var voter = await FirebaseFirestore.instance
          .collection("voters")
          .doc(userCredential.user.uid)
          .get();
      AppUser loggedUser = new AppUser(
        uid: userCredential.user.uid,
        email: userCredential.user.email,
        adress: voter.data()["adress"],
      
      );
        print(loggedUser.adress);
      authenticatedUser = loggedUser;
      return loggedUser;
    } on FirebaseAuthException catch (err) {
      var message = "An error occured, please check your credentials!";

      if (err.code != null) {
        message = err.code;
      }
      print("message");
      throw message;
    } catch (err) {
      throw err.code;
    }
  }
}