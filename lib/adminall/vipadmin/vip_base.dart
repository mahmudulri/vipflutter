import 'package:flutter/material.dart';
import 'package:zest_betting_tips/adminall/freeadmin/bonus.dart';
import 'package:zest_betting_tips/adminall/freeadmin/combo.dart';
import 'package:zest_betting_tips/adminall/freeadmin/daily5plus.dart';
import 'package:zest_betting_tips/adminall/freeadmin/sure.dart';
import 'package:zest_betting_tips/adminall/freeadmin/today.dart';
import 'package:zest_betting_tips/adminall/vipadmin/elite_vip.dart';
import 'package:zest_betting_tips/adminall/vipadmin/fifty_admin.dart';
import 'package:zest_betting_tips/adminall/vipadmin/half_full_admin.dart';
import 'package:zest_betting_tips/adminall/vipadmin/singlevip_admin.dart';
import 'package:zest_betting_tips/adminall/vipadmin/special_admin.dart';

class PremimLanding extends StatefulWidget {
  const PremimLanding({super.key});

  @override
  State<PremimLanding> createState() => _PremimLandingState();
}

class _PremimLandingState extends State<PremimLanding> {
  var _currentIndex = 0;
  final pages = [
    EliteAdmin(),
    SpecialAdmin(),
    SingleAdmin(),
    HalfFullAdmin(),
    FIftyplusAdmin(),
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
            label: "ELITE VIP",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.sports_football,
            ),
            label: "SPECIAL VIP",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.sports_football,
            ),
            label: "SINGLE VIP",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.sports_football,
            ),
            label: "HT/FT VIP",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.sports_football,
            ),
            label: "FIFTY PLUS VIP",
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
