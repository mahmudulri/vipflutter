import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zest_betting_tips/admin.dart';
import 'package:zest_betting_tips/adminall/freeadmin/freebase.dart';
import 'package:zest_betting_tips/adminall/vipadmin/vip_base.dart';
import 'package:zest_betting_tips/free_tips.dart';
import 'package:zest_betting_tips/old_admin.dart';

import 'premiumadmin.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Get.to(() => FreeLanding());
              },
              child: Container(
                height: 60,
                width: 220,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "Free Tips",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Get.to(() => PremimLanding());
              },
              child: Container(
                height: 60,
                width: 220,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "Premium Tips",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                // Get.to(() => OldAdmin());
              },
              child: Container(
                height: 60,
                width: 220,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "Add Old Tips",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
