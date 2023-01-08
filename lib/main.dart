import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Model/onlineTime.dart';
import 'package:flutter_application_1/Pages/HomePage.dart';
import 'package:flutter_application_1/Pages/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';

// import 'package:flutter_application_1/Pages/LoginPage.dart';
// import 'package:flutter_application_1/Pages/ChatPage.dart';
// import 'package:flutter_application_1/Pages/ProfilePage.dart';
// import 'package:flutter_application_1/Pages/UserPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor:
        Color.fromARGB(255, 255, 255, 255), // navigation bar color
    statusBarColor: Color.fromARGB(255, 255, 255, 255), // status bar color
  ));

  OnlineTime().setOnlineTime();

  return runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return MaterialApp(
      title: "IndNet",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.white,
        ),
      ),

      home: auth.currentUser != null ? HomePage() : LoginPage(),
      // routes: {
      //   "/home": (context) => HomePage(),
      //   '/chatpage': (context) => ChatPage(),
      //   '/userprofile': (context) => UserPage(),
      //   '/profile': (context) => MyProfilePage(),
      // },
    );
  }
}
