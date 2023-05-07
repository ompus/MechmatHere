import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mechmat_tut/user_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ChangeEvent.dart';
import 'authentication_service.dart';
import 'event_model.dart';
import 'event_service.dart';
import 'NotifEventsPage.dart';
import 'helper.dart';

class EventDetailPage extends StatefulWidget {
  final String name;
  final userRef = FirebaseFirestore.instance.collection("users");

  EventDetailPage(Key? key, this.name) : super(key: key);
  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  late Future<EventModel> event;
  String EventCreatorUid = "";
  String EventName = "";
  String EventDesc = "";
  String EventPhoto = "";
  String EventVK = "";
  String EventTelegram = "";
  String EventPhone = "";
  User? user;
  List<dynamic> ss = [];
  late Future<UserModel> s;
  String? uidCur = "";

  void initState() {
    setState(() {
      user = context.read<AuthenticationService>().getUser();
      s = context.read<AuthenticationService>().getUserFromDB(user!.uid);
      event = context.read<EventService>().getEventByName(widget.name);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isSyb;
    event.then((result) {
      setState(() {
        EventName = result.name ?? "";
        EventCreatorUid = result.creatoruid ?? "";
        EventDesc = result.desc ?? "";
        EventPhoto = result.photo ?? "";
        EventVK = result.vk ?? "";
        EventTelegram = result.telegram ?? "";
        EventPhone = result.phone ?? "";
        s.then((value) => ss = value.subs);
        s.then((value) => uidCur = value.uid);
      });
    });
    // перенести?
    (ss.where((elem) => elem == EventName).isNotEmpty)
        ? isSyb = true
        : isSyb = false;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(0),
          child: ListView(
            children: [
              Container(
                child: EventPhoto != ""
                    ? Image.network(
                        EventPhoto,
                        fit: BoxFit.cover,
                      )
                    : Image.asset("assets/images/face.png",
                        width: 200, height: 200),
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                    ),
                    child: Text(
                      EventName,
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(color: Colors.black),
                    )),
              ),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                      padding: EdgeInsets.all(0),
                      child: Text(EventDesc, style: TextStyle(fontSize: 17)))),
              Row(children: [
                Text("  Связаться: ", style: TextStyle(fontSize: 17)),
                Visibility(child: SizedBox(width: 10)),
                Visibility(
                  child: InkWell(
                    onTap: () => _launchURL("https://" + EventVK),
                    child: Column(
                      children: [
                        Image.asset("assets/icons/vk.png",
                            width: 50, height: 50),
                      ],
                    ),
                  ),
                  visible: EventVK == "" ? false : true,
                ),
                Visibility(
                    child: SizedBox(width: 15),
                    visible: EventVK == "" ? false : true),
                Visibility(
                  child: InkWell(
                    onTap: () => _launchURL("https://" + EventTelegram),
                    child: Column(
                      children: [
                        Image.asset("assets/icons/telegram.png",
                            width: 50, height: 50),
                      ],
                    ),
                  ),
                  visible: EventTelegram == "" ? false : true,
                ),
                Visibility(
                    child: SizedBox(width: 15),
                    visible: EventTelegram == "" ? false : true),
                Visibility(
                  child: InkWell(
                    onTap: () => launch("tel:" + EventPhone),
                    child: Column(
                      children: [
                        Image.asset("assets/icons/phone.png",
                            width: 50, height: 50),
                      ],
                    ),
                  ),
                  visible: EventPhone == "" ? false : true,
                ),
              ]),
              const SizedBox(
                height: 16,
              ),
              Visibility(
                child: Center(
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
                        //context.read<AuthenticationService>().getUserFromDB(context.read<AuthenticationService>().getUser()!.uid);
                        setState(() {
                          if (isSyb == false)
                            ss.add(EventName);
                           else
                            ss.remove(EventName);
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(uidCur)
                              .update({"subs": ss});
                          s.then((value) => ss = value.subs);
                        });
                      },
                      child: Text(isSyb == false
                          ? 'Добавить в подписки'
                          : 'Убрать из подписок'),
                    ),
                  ),
                ),
                visible: user!.uid != EventCreatorUid ? true : false,
              ),
              Visibility(
                child: Center(
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
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ChangeEvent(null, EventName)));
                        setState(() {
                          event = context
                              .read<EventService>()
                              .getEventByName(widget.name);
                        });
                      },
                      child: Text('Редактировать'),
                    ),
                  ),
                ),
                visible: user!.uid == EventCreatorUid ? true : false,
              ),
              Visibility(
                  child: SizedBox(height: 16),
                  visible: user!.uid == EventCreatorUid ? true : false),
              Visibility(
                child: Center(
                  child: Container(
                    height: 40,
                    width: 300,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 6.0,
                        primary: Colors.red, // background
                        onPrimary: Colors.white, // foreground
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: const BorderSide(color: Colors.red)),
                      ),
                      onPressed: () async{
                        final result = await
                            context.read<EventService>().deleteEvent(EventName);

                        showSnackbar(context, result!);

                        if (result == "Мероприятие удалено") {
                          //FirebaseFirestore.instance.collection("users").get()
                          Navigator.pop(context);
                        }
                      },
                      child: Text('Удалить'),
                    ),
                  ),
                ),
                visible: user!.uid == EventCreatorUid ? true : false,
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ));
  }
}

_launchURL(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launch(
      url,
      forceWebView: false,
      forceSafariVC: false,
    );
  } else {
    throw 'Could not launch $url';
  }
}
