import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zest_betting_tips/allfreetips.dart';
import 'package:zest_betting_tips/allpremiumtips.dart';
import 'package:zest_betting_tips/free_tips.dart';
import 'package:lottie/lottie.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({super.key});

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => AllfreeTips());
                },
                child: Container(
                  height: screeHeight * 0.070,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Color(0xffEBF4FB),
                  ),
                  child: Center(
                      child: Text(
                    "Free Tips",
                    style: TextStyle(
                      fontSize: screenWidth * 0.030,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => AllPremiumTips());
                },
                child: Container(
                  height: screeHeight * 0.070,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Color(0xffEBF4FB),
                  ),
                  child: Center(
                    child: Text(
                      "Premium Tips",
                      style: TextStyle(
                        fontSize: screenWidth * 0.030,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              // Container(
              //   color: Colors.red,
              //   height: 100,
              //   width: 100,
              //   child: Lottie.asset('assets/vipone.json'),
              // ),
              SizedBox(
                height: 100,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: Colors.white,
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Center(
                    child: Text(
                      "Join Telegram",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.025,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
