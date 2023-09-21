import 'package:flutter/material.dart';

class AllPremiumTips extends StatelessWidget {
  const AllPremiumTips({super.key});

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
            Expanded(
              flex: 11,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FreeButton(
                      buttonName: 'today tips',
                    ),
                    FreeButton(
                      buttonName: 'daily 5 + odds',
                    ),
                    FreeButton(
                      buttonName: 'sure tips',
                    ),
                    FreeButton(
                      buttonName: 'combo tips',
                    ),
                    FreeButton(
                      buttonName: 'bonus tips',
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Buy All VIP For LifeTime @ 59.99 USD",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.020,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: BuyNow(
                  buttonName: 'Buy vip (59.99 USD)',
                ),
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
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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

class BuyNow extends StatelessWidget {
  String buttonName;
  BuyNow({super.key, required this.buttonName});

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
