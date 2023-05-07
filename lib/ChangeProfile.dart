import 'package:flutter/material.dart';
import 'package:mechmat_tut/authentication_service.dart';
import 'package:mechmat_tut/user_model.dart';
import 'package:provider/provider.dart';
import 'package:mechmat_tut/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../user_image.dart';

class ChangeProfilePage extends StatefulWidget {
  @override
  _ChangeProfilePageState createState() => _ChangeProfilePageState();
}

class _ChangeProfilePageState extends State<ChangeProfilePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController interestsController = TextEditingController();
  TextEditingController vkController = TextEditingController();
  TextEditingController telegramController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String imageUrl = '';
  String ProfileImageUrl = '';
  User? user;
  late Future<UserModel> s;
  String un = "";
  String interests = "";
  String vk = "";
  String telegram = "";
  String phone = "";
  String photo = "";

  @override
  void initState() {
    setState(() {
      // 2
      user = context.read<AuthenticationService>().getUser();
      s = context.read<AuthenticationService>().getUserFromDB(user!.uid);
    });
    super.initState();
  }
  //FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    s.then((result){
        ProfileImageUrl = result.photo ?? "";
        usernameController.text = result.username ?? "";
        interestsController.text = result.interests ?? "";
        vkController.text = result.vk ?? "";
        telegramController.text = result.telegram ?? "";
        phoneController.text = result.phone ?? "";
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Редактировать профиль", style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),),),
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 16,
                ),
                UserImage(
                    onFileChanged: (imageUrl){
                      setState(() {
                        this.imageUrl = imageUrl;
                      });
                    }
                ),
                const SizedBox(
                  height: 16,
                ),
                /*Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'E-mail'),
                            controller: emailTextController),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                            enableSuggestions: false,
                            autocorrect: false,
                            obscureText: true,
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'Пароль'),
                            controller: passwordTextController),
                      ),
                    ],
                  ),
                ),*/
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'Псевдоним'),
                            controller: usernameController),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Интересы'),
                      style: TextStyle(), maxLines: 12, minLines: 5,
                      controller: interestsController),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'ВКонтакте'),
                            controller: vkController),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'Telegram'),
                            controller: telegramController),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'Телефон'),
                            controller: phoneController),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: Container(
                    height: 40,
                    width: 300,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 6.0,
                        primary: Colors.amber, // background
                        onPrimary: Colors.black, // foreground
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: const BorderSide(color: Colors.amber)),
                      ),
                      onPressed: () async {
                        final result = await context
                            .read<AuthenticationService>()
                            .ChangeProfile(user!.uid, usernameController.text.trim(), interestsController.text.trim(),
                            vkController.text.trim(), telegramController.text.trim(), phoneController.text.trim(),
                            imageUrl == "" ? ProfileImageUrl: imageUrl
                        );

                        showSnackbar(context, result!);

                        if (result == "Изменения сохранены") {
                          Navigator.pop(
                              context);
                        }},
                      child: Text('Сохранить изменения'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


