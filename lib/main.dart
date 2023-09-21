import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_checker/store_checker.dart';
import 'package:zest_betting_tips/admin.dart';
import 'package:zest_betting_tips/adminall/freeadmin/freebase.dart';
import 'package:zest_betting_tips/frontpage.dart';
import 'package:zest_betting_tips/homepage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zest_betting_tips/welcome.dart';

const apiKey = "AIzaSyDUSKkYk9MidkYFlbsQuNyhsAQtq_544Lo";
const projectID = "vip-betting-tips-27b28";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDUSKkYk9MidkYFlbsQuNyhsAQtq_544Lo",
      authDomain: "vip-betting-tips-27b28.firebaseapp.com",
      projectId: "vip-betting-tips-27b28",
      storageBucket: "vip-betting-tips-27b28.appspot.com",
      messagingSenderId: "74132673789",
      appId: "1:74132673789:web:f604cf2c5e5d8b2a98da94",
      measurementId: "G-ZMJ0LS6ZDD",
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String source = "";

  final box = GetStorage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vip Tips',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Welcome(),
    );
  }
}
