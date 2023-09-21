import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zest_betting_tips/free_tips.dart';

class AllfreeTips extends StatelessWidget {
  const AllfreeTips({super.key});

  @override
  Widget build(BuildContext context) {
    final screeHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xff004C3F),
      body: Container(
        height: screeHeight,
        width: screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(() => FreeTips(
                      tipsName: 'TodayTips',
                      appbarTitle: 'Today Tips',
                      dateName: 'TodayTipsDate',
                    ));
              },
              child: FreeButton(
                buttonName: 'today tips',
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => FreeTips(
                      tipsName: 'FiveplustTips',
                      appbarTitle: 'Daily 5+ ODDS',
                      dateName: 'FiveplusDate',
                    ));
              },
              child: FreeButton(
                buttonName: 'daily 5 + odds',
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => FreeTips(
                      tipsName: 'SureTips',
                      appbarTitle: 'Sure Tips',
                      dateName: 'SureTipsDate',
                    ));
              },
              child: FreeButton(
                buttonName: 'sure tips',
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => FreeTips(
                      tipsName: 'ComboTips',
                      appbarTitle: 'Combo Tips',
                      dateName: 'ComboTipsDate',
                    ));
              },
              child: FreeButton(
                buttonName: 'Combo tips',
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => FreeTips(
                      tipsName: 'BonusTips',
                      appbarTitle: 'Bonus Tips',
                      dateName: 'BonusTipsDate',
                    ));
              },
              child: FreeButton(
                buttonName: 'Bonus tips',
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class FreeButton extends StatelessWidget {
  String buttonName;
  FreeButton({super.key, required this.buttonName});

  @override
  Widget build(BuildContext context) {
    final screeHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        width: screenWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            buttonName.toUpperCase(),
            style: TextStyle(
              fontSize: screenWidth * 0.030,
              fontWeight: FontWeight.bold,
            ),
          ),
        )),
      ),
    );
  }
}
