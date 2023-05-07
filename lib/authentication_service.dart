import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mechmat_tut/user_model.dart';

class AuthenticationService {

  // 1
  final FirebaseAuth _firebaseAuth;
  UserModel userModel = UserModel();
  final userRef = FirebaseFirestore.instance.collection("users");

  AuthenticationService(this._firebaseAuth);

  // 2
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();


  // 3
  Future<String?> signIn(String email, String password) async {
    try {
      if (email == "") return "Поле электронной почты не может быть пустым"; else
      if (password == "") return "Поле с паролем не может быть пустым"; else
      if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9_]+@sfedu.ru")
          .hasMatch(email))
        return "Электронная почта не содержит домен @sfedu.ru или введена неверно";
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Вход выполнен";
    } on FirebaseAuthException catch(e) {
      return e.message;
    }
  }

  // 4
  Future<String?> signUp(String email, String password, String username, String vk,String telegram, String phone) async {
    try {
      if (email == "") return "Поле электронной почты не может быть пустым"; else
        if (password == "") return "Поле с паролем не может быть пустым"; else
        if (username == "") return "Поле с ником не может быть пустым"; else
        if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9_]+@sfedu.ru")
            .hasMatch(email))
          return "Электронная почта не содержит домен @sfedu.ru или введена неверно"; else
        if (vk != "" &&  !RegExp(r"vk.com/+[a-zA-Z0-9.a-zA-Z0-9_]")
            .hasMatch(vk)) return "Введите ссылку на профиль в ВК в формате vk.com/*"; else
        if (telegram != "" &&  !RegExp(r"t.me/+[a-zA-Z0-9a-zA-Z0-9_]")
            .hasMatch(telegram)) return "Введите ссылку на профиль в Telegram в формате t.me/*"; else
        if (phone != "" && !(RegExp(r"8+[0-9]{9}").hasMatch(phone)||
            RegExp(r"\+7+[0-9]{9}").hasMatch(phone))) return "Введите телефон в формате 8********** или +7**********";

      await _firebaseAuth.createUserWithEmailAndPassword
        (email: email, password: password);
      return "Регистрация прошла успешно";
    } on FirebaseAuthException catch(e) {
      return e.message;
    }
  }

  // 5
  Future<String?> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return "Выход с аккаунта...";
    } on FirebaseAuthException catch(e) {
      return e.message;
    }
  }

// 6
  Future<UserModel> getUserFromDB(String uid) async {
    final DocumentSnapshot doc = await userRef.doc(uid).get();

    return UserModel.fromMap(doc.data() as Map<String, dynamic>);
  }

  Future<void> addUserToDB(
      String? uid, String username, String email, String interests,
      String vk, String telegram, String phone, String photo) async {
    userModel = UserModel(
        uid: uid, username: username, email: email, interests: interests,
    vk: vk, telegram: telegram, phone: phone, photo: photo);

    await userRef.doc(uid).set(userModel.toMap(userModel));
  }

  Future<String?> ChangeProfile (String uid, String username,
      String interests, String vk, String telegram, String phone, String photo) async
  { // сделать обновление отдельных компонентов
    if (username == "") return "Поле с ником не может быть пустым"; else
    if (vk != "" &&  !RegExp(r"vk.com/+[a-zA-Z0-9.a-zA-Z0-9_]")
        .hasMatch(vk)) return "Введите ссылку на профиль в ВК в формате vk.com/*"; else
    if (telegram != "" &&  !RegExp(r"t.me/+[a-zA-Z0-9a-zA-Z0-9_]")
        .hasMatch(telegram)) return "Введите ссылку на профиль в Telegram в формате t.me/*"; else
    if (phone != "" && !(RegExp(r"8+[0-9]{9}").hasMatch(phone)||
        RegExp(r"\+7+[0-9]{9}").hasMatch(phone))) return "Введите телефон в формате 8********** или +7**********";

    FirebaseFirestore.instance.collection("users").doc(uid).update({"username": username});
    FirebaseFirestore.instance.collection("users").doc(uid).update({"interests": interests});
    FirebaseFirestore.instance.collection("users").doc(uid).update({"vk": vk});
    FirebaseFirestore.instance.collection("users").doc(uid).update({"telegram": telegram});
    FirebaseFirestore.instance.collection("users").doc(uid).update({"phone": phone});
    FirebaseFirestore.instance.collection("users").doc(uid).update({"photo": photo});
    return "Изменения сохранены";
  }

  User? getUser() {
    try {
      return _firebaseAuth.currentUser;
    } on FirebaseAuthException {
      return null;
    }
  }
}