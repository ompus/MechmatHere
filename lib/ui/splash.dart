import 'dart:async';

import 'package:flutter/material.dart';

const String LoggedInKey = 'LoggedIn';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  Widget build(BuildContext context) {
    //final query = MediaQuery.of(context);
    //final size = query.size;
    //final itemWidth = size.width*0.4;
    //final itemHeight = itemWidth * (size.width / size.height);
    return Scaffold(
      body: SafeArea(
        child: Stack(
                  children:[ 
         //           Padding(
         //   padding: const EdgeInsets.only(top: 60),
         //   child: Align(
         //     alignment: Alignment.topCenter,
         //     child: Image.asset('',
         //         width: itemWidth,height: itemHeight,),
         //   ),
         // ),
                    Center(
            child: Text("Мехмат.Тут",style: TextStyle(color:Theme.of(context).primaryColor ,fontSize: 24,fontWeight: FontWeight.w700),)),
          ]
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Timer(const Duration(milliseconds: 1000), () {
      //TODO: Change to Auth
      Navigator.pushNamed(
        context,
        '/auth',
      );
    });
  }
}
