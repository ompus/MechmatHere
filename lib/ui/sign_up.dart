import 'package:flutter/material.dart';
import 'package:mechmat_tut/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:mechmat_tut/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../user_image.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController interestsController = TextEditingController();
  TextEditingController vkController = TextEditingController();
  TextEditingController telegramController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String imageUrl = '';
  final _formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.amber,
        title: const Text(
          'Регистрация',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ),
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
                Padding(
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
                ),
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
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'Интересы (необязательно)'),
                            controller: interestsController),
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
                                hintText: 'ВКонтакте (необязательно)'),
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
                                hintText: 'Telegram (необязательно)'),
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
                                hintText: 'Телефон (необязательно)'),
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
                            .signUp(emailTextController.text.toLowerCase().trim(),
                          passwordTextController.text.trim(), usernameController.text.trim(),
                            vkController.text.trim(), telegramController.text.trim(), phoneController.text.trim()
                        );

                        showSnackbar(context, result!);

                        if (result == "Регистрация прошла успешно") {
                          context.read<AuthenticationService>().addUserToDB(
                              auth.currentUser!.uid, usernameController.text.trim(),
                              emailTextController.text.toLowerCase().trim(), interestsController.text.trim(),
                              vkController.text.trim(), telegramController.text.trim(), phoneController.text.trim(), imageUrl);
                          Navigator.pop(
                              context, ModalRoute.withName('/auth'));
                        }},
                      child: Text('Создать аккаунт'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Уже есть аккаунт? "),
                      Text(
                        'Войти',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
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


