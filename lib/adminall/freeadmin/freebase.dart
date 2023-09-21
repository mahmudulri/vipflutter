import 'package:flutter/material.dart';
import 'package:zest_betting_tips/adminall/freeadmin/bonus.dart';
import 'package:zest_betting_tips/adminall/freeadmin/combo.dart';
import 'package:zest_betting_tips/adminall/freeadmin/daily5plus.dart';
import 'package:zest_betting_tips/adminall/freeadmin/sure.dart';
import 'package:zest_betting_tips/adminall/freeadmin/today.dart';

class FreeLanding extends StatefulWidget {
  const FreeLanding({super.key});

  @override
  State<FreeLanding> createState() => _FreeLandingState();
}

class _FreeLandingState extends State<FreeLanding> {
  var _currentIndex = 0;
  final pages = [
    TodayAdmin(),
    Daily5Plus(),
    SureAdmin(),
    ComboAdmin(),
    BonusAdmn(),
  ];
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        selectedFontSize: screenWidth * 0.010,
        elevation: 0.0,
        // backgroundColor: Color(0xff2c3e50),
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.sports_football,
            ),
            label: "TODAY TIPS",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.sports_football,
            ),
            label: "DAILY 5 +",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.sports_football,
            ),
            label: "SURE TIPS",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.sports_football,
            ),
            label: "COMBO TIPS",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.sports_football,
            ),
            label: "BONUS TIPS",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.sports_football,
          //   ),
          //   label: "DEMO OLD",
          // ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: pages[_currentIndex],
    );
  }
}
