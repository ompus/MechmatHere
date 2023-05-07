import 'package:flutter/material.dart';
import 'package:mechmat_tut/event_service.dart';
import 'package:mechmat_tut/pages/home_page.dart';
import 'package:mechmat_tut/user_model.dart';
import 'AddEvent.dart';
import 'authentication_service.dart';
import 'ui/home.dart';
import 'ui/sign_in.dart';
import 'ui/sign_up.dart';
import 'ui/splash.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

// 1
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // 2
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        // 3
        StreamProvider(
          create: (context) => context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        ),
        Provider<EventService>(
          create: (_) => EventService(FirebaseAuth.instance),
        ),
      ],
      child: MaterialApp(
        title: 'Мехмат.Тут',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        initialRoute: '/auth',
        routes: {
          //'/': (context) => Splash(),
          '/auth': (context) => AuthenticationWrapper(),
          '/signin': (context) => SignIn(),
          '/signup': (context) => SignUp(),
          '/home': (context) => Home(),
          '/addevent': (context) => AddEvent(),
        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseuser = context.watch<User?>();
    if (firebaseuser != null) {
      return HomePage();
    }
    return SignIn();
  }
}