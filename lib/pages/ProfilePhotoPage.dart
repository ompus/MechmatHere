import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mechmat_tut/user_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../authentication_service.dart';
import 'package:provider/provider.dart';

import '../round_image.dart';

class ProfilePhotoPage extends StatefulWidget {
  const ProfilePhotoPage({Key? key}) : super(key: key);

  @override
  _ProfilePhotoPageState createState() => _ProfilePhotoPageState();
}
class _ProfilePhotoPageState extends State<ProfilePhotoPage>
{
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
  @override
  Widget build(BuildContext context) {
    s.then((result){
        setState(() {
        un = result.username ?? "";
        interests = result.interests ?? "";
        vk = result.vk ?? "";
        telegram = result.telegram ?? "";
        phone = result.phone ?? "";
        photo = result.photo ?? "";
      });
    });
    return Scaffold(
        appBar: AppBar(
            title: const Text("Профиль", style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),),),
        body: Padding(
          padding: EdgeInsets.all(0),
          child: ListView(
            children: [
              const SizedBox(
                height: 16,
              ),
              Container(
              child: photo != "" ? Container(
                  height: 200, width: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(photo),
                    ))) : Image.asset(
          "assets/images/face.png",  width: 200, height: 200),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                  ),
                  child: Text(
                    un,
                    style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.black),
                  )
              ),),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                      padding: EdgeInsets.all(0),
                      child: Text(
                          "Интересы: $interests",
                          style: TextStyle(fontSize: 17)
                      )
                  )
              ),
             Row(
                 children: [
                   Text(
                       "   Контакты: ",
                       style: TextStyle(fontSize: 17)
                   ),
                   Visibility(
                       child: SizedBox(width: 10)
                   ),
                   Visibility(
                     child: InkWell(
                       onTap: () => _launchURL("https://" + vk),
                       child: Column(
                         children: [
                           Image.asset("assets/icons/vk.png", width: 50,
                               height: 50),
                         ],
                       ),
                     ),
                     visible: vk == "" ? false: true,
                   ),
                   Visibility(
                       child: SizedBox(width: 15),
                       visible: telegram == "" ? false: true
                   ),
                   Visibility(
                     child: InkWell(
                       onTap: () => _launchURL("https://" + telegram),
                       child: Column(
                         children: [
                           Image.asset("assets/icons/telegram.png", width: 50,
                               height: 50),
                         ],
                       ),
                     ),
                     visible: telegram == "" ? false: true,
                   ),
                   Visibility(
                       child: SizedBox(width: 15),
                       visible: phone == "" ? false: true
                   ),
                   Visibility(
                     child: InkWell(
                       onTap: () => launch("tel:" + phone),
                       child: Column(
                         children: [
                           Image.asset("assets/icons/phone.png", width: 50,
                           height: 50),
                         ],
                       ),
                     ),
                     visible: phone == "" ? false: true,
                   ),
                 ]
             ),
            ],
          ),
        )
    );
  }
}

_launchURL(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launch(url, forceWebView: false,
      forceSafariVC: false,);
  } else {
    throw 'Could not launch $url';
  }
}