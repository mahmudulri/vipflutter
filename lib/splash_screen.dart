import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zest_betting_tips/homepage.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var currentVersion;
  var maintime;
  var isLoading = false.obs;
  String appversionbd = "10";

  String myappUrl =
      "https://play.google.com/store/apps/details?id=com.suretips.bettingtipsnewteam";

  @override
  void initState() {
    fetchVersion();
    _navigateToNextScreen();
    super.initState();
  }

  fetchVersion() {
    isLoading(true);
    print(isLoading);

    FirebaseFirestore.instance
        .collection('appversion')
        .doc("version_number")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          maintime = documentSnapshot.data();
          currentVersion = maintime["version"];
        });
      } else {
        print('Document does not exist on the database');
      }
    });
    isLoading(false);
    print(isLoading);
  }

  void _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));

    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => Homepage(
    //       latestversion: currentVersion,
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              // showDialog(
              //   context: context,
              //   builder: (BuildContext context) {
              //     final screeHeight = MediaQuery.of(context).size.height;
              //     final screenWidth = MediaQuery.of(context).size.height;
              //     return Dialog(
              //       insetPadding: EdgeInsets.all(20),
              //       child: Container(
              //         height: 250,
              //         width: screenWidth,
              //         decoration: BoxDecoration(
              //           color: Colors.grey,
              //         ),
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Text(
              //                 "New Version is available in Play Store , Please Update Now",
              //                 style: TextStyle(
              //                   fontSize: 18,
              //                 ),
              //               ),
              //             ),
              //             GestureDetector(
              //               onTap: () async {
              //                 if (await canLaunchUrl(Uri.parse(myappUrl))) {
              //                   // ignore: deprecated_member_use
              //                   await launch(myappUrl);
              //                 } else {
              //                   throw 'Could not launch ${myappUrl}';
              //                 }

              //                 Navigator.pushReplacement(
              //                   context,
              //                   MaterialPageRoute(
              //                       builder: (context) => Homepage(
              //                             latestversion: currentVersion,
              //                           )),
              //                 );
              //               },
              //               child: Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: Container(
              //                   decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(10),
              //                     color: Colors.black,
              //                   ),
              //                   child: Center(
              //                       child: Padding(
              //                     padding:
              //                         const EdgeInsets.symmetric(vertical: 10),
              //                     child: Text(
              //                       "Update Now",
              //                       style: TextStyle(
              //                         color: Colors.white,
              //                         fontSize: screenWidth * 0.030,
              //                         fontWeight: FontWeight.w600,
              //                       ),
              //                     ),
              //                   )),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     );
              //   },
              // );
            },
            child: Text("data")),
      ),
    );
  }
}
