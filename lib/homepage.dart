import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:onepref/onepref.dart';
import 'package:zest_betting_tips/free_tips.dart';
import 'package:zest_betting_tips/premium_tips.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:get_storage/get_storage.dart';

class Homepage extends StatefulWidget {
  Homepage({
    super.key,
  });

  // String latestversion;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String myversion = "100";

  //List products
  late final List<ProductDetails> _products = <ProductDetails>[];

//List of ProductsIds
  // ignore: prefer_final_fields
  List<ProductId> _productIds = <ProductId>[
    ProductId(id: "productvip", isConsumable: false),
    ProductId(id: "Error", isConsumable: false)
  ];

//IApEngine
  IApEngine iApEngine = IApEngine();

//bool
  bool isSubscribed = false;
  String myappUrl =
      "https://play.google.com/store/apps/details?id=com.suretips.bettingtipsnewteam";

  late Timer _timer;

  @override
  void initState() {
    // fetchNotice();
    // _navigateToNextScreen();
    super.initState();

    // _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    //   print("object");
    //   iApEngine.inAppPurchase.restorePurchases();
    // });

    iApEngine.inAppPurchase.purchaseStream.listen((listOfPurchaseDetails) {
      listenPurchases(listOfPurchaseDetails);
    });
    getProducts();

    isSubscribed = OnePref.getPremium() ?? false;
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed to avoid memory leaks.
    _timer.cancel();
    super.dispose();
  }

  // get Notice.........
  var getnotice;
  var updtenotice;
  var isLoading = false.obs;
  var finalResult;

  final box = GetStorage();

  // fetchNotice() async {
  //   isLoading(true);
  //   print(isLoading);

  //   await FirebaseFirestore.instance
  //       .collection('noticeboard')
  //       .doc("updatenotice")
  //       .get()
  //       .then((DocumentSnapshot documentSnapshot) {
  //     if (documentSnapshot.exists) {
  //       setState(() {
  //         getnotice = documentSnapshot.data();
  //         updtenotice = getnotice["news"];
  //       });
  //     } else {
  //       print('Document does not exist on the database');
  //     }
  //   });
  //   isLoading(false);
  //   print(isLoading);
  // }

  // Listen to our purchases events / re store

  void getProducts() async {
    await iApEngine.getIsAvailable().then((value) async {
      if (value) {
        await iApEngine.queryProducts(_productIds).then((res) {
          print(res.notFoundIDs);
          _products.clear();
          setState(() {
            _products.addAll(res.productDetails);
          });
        });
      }
    });
  }

  Future<void> listenPurchases(List<PurchaseDetails> list) async {
    if (list.isNotEmpty) {
      for (PurchaseDetails purchaseDetails in list) {
        if (purchaseDetails.status == PurchaseStatus.restored ||
            purchaseDetails.status == PurchaseStatus.purchased) {
          // acknowledge

          print(purchaseDetails.verificationData.localVerificationData);

          Map purchaseData = json
              .decode(purchaseDetails.verificationData.localVerificationData);
          finalResult = purchaseData;

          if (purchaseData["acknowledged"]) {
            print("restore purchase");
            setState(() {
              isSubscribed = true;
              OnePref.setPremium(isSubscribed);
            });
          } else {
            print("first time purchase");

            if (Platform.isAndroid) {
              final InAppPurchaseAndroidPlatformAddition
                  androidPlatformAddition = iApEngine.inAppPurchase
                      .getPlatformAddition<
                          InAppPurchaseAndroidPlatformAddition>();

              await androidPlatformAddition
                  .consumePurchase(purchaseDetails)
                  .then((value) {
                updateIsSub(true);
              });
            }

            // complete
            if (purchaseDetails.pendingCompletePurchase) {
              print(
                  "pending complete purchase : ${purchaseDetails.pendingCompletePurchase}");
              await iApEngine.inAppPurchase
                  .completePurchase(purchaseDetails)
                  .then((value) {
                updateIsSub(true);
              });
            }
          }
        }
      }
    } else {
      updateIsSub(false);
    }
  }

  void updateIsSub(bool value) {
    setState(() {
      isSubscribed = value;
      OnePref.setPremium(isSubscribed);
    });
  }

  // void _navigateToNextScreen() async {
  //   if (myversion != widget.latestversion) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         final screeHeight = MediaQuery.of(context).size.height;
  //         final screenWidth = MediaQuery.of(context).size.height;
  //         return Dialog(
  //           insetPadding: EdgeInsets.all(20),
  //           child: Container(
  //             height: 250,
  //             width: screenWidth,
  //             decoration: BoxDecoration(
  //               color: Colors.grey,
  //             ),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Text(
  //                       "New Version is available in Play Store , Please Update Now"),
  //                 ),
  //                 GestureDetector(
  //                   onTap: () async {
  //                     if (await canLaunchUrl(Uri.parse(myappUrl))) {
  //                       // ignore: deprecated_member_use
  //                       await launch(myappUrl);
  //                     } else {
  //                       throw 'Could not launch ${myappUrl}';
  //                     }
  //                   },
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Container(
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(10),
  //                         color: Colors.black,
  //                       ),
  //                       child: Center(
  //                           child: Padding(
  //                         padding: const EdgeInsets.symmetric(vertical: 10),
  //                         child: Text(
  //                           "Update Now",
  //                           style: TextStyle(
  //                             color: Colors.white,
  //                             fontSize: screenWidth * 0.035,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                       )),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   } else {
  //     print("ok");
  //   }
  // }

  // checkversion() {
  //   if (myversion == widget.latestversion) {
  //     print("Updated");
  //   } else {
  //     print("Not update");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final screeHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff004C3F),
        // floatingActionButton: FloatingActionButton(onPressed: () {
        //   print(box.read("checker"));
        // }),
        key: scaffoldKey,
        // drawer: Drawer(),
        appBar: AppBar(
          backgroundColor: Color(0xff004C3F),
          elevation: 0.0,
          centerTitle: true,

          // leading: IconButton(
          //   icon: Icon(
          //     Icons.sort,
          //     size: screeHeight * 0.040,
          //     color: Colors.white,
          //   ),
          //   onPressed: () {
          //     if (scaffoldKey.currentState!.isDrawerOpen) {
          //       scaffoldKey.currentState!.closeDrawer();
          //       //close drawer, if drawer is open
          //     } else {
          //       scaffoldKey.currentState!.openDrawer();
          //       //open drawer, if drawer is closed
          //     }
          //   },
          // ),

          title: Text(
            "VIP BETTING TIPS",
            style: GoogleFonts.alatsi(
              color: Colors.white,
              fontSize: screeHeight * 0.030,
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(),
          child: SizedBox(
            height: screeHeight,
            width: screeHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Padding(
                //     padding: const EdgeInsets.symmetric(
                //         vertical: 20, horizontal: 10),
                //     child: Obx(
                //       () => isLoading.value == false
                //           ? Text(
                //               updtenotice == null ? "" : updtenotice.toString(),
                //               style: TextStyle(
                //                 fontSize: 18,
                //                 color: Colors.white,
                //               ),
                //               textAlign: TextAlign.center,
                //             )
                //           : Text(""),
                //     )),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(context,
                //         MaterialPageRoute(builder: (context) => FreeTips()));
                //   },
                //   child: DailyButton(),
                // ),

                SizedBox(
                  height: 20,
                ),

                // GestureDetector(
                //   onTap: () {
                //     iApEngine.inAppPurchase.restorePurchases();
                //     if (finalResult != null) {
                //       print("token " + finalResult["purchaseToken"].toString());
                //       Get.to(() => PremiumTips());
                //     } else {
                //       print("Not bought");
                //       showDialog(
                //         context: context,
                //         builder: (BuildContext context) {
                //           return Dialog(
                //               shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(20.0),
                //               ),
                //               backgroundColor: Colors.transparent,
                //               child: Container(
                //                 width: screenWidth,
                //                 decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.circular(10),
                //                   color: Colors.white38,
                //                 ),
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(5.0),
                //                   child: ListView.separated(
                //                     separatorBuilder: (context, index) {
                //                       return SizedBox(
                //                         height: 5,
                //                       );
                //                     },
                //                     shrinkWrap: true,
                //                     itemCount: _products.length,
                //                     itemBuilder: (context, index) {
                //                       return Padding(
                //                         padding: const EdgeInsets.symmetric(
                //                           horizontal: 5,
                //                         ),
                //                         child: GestureDetector(
                //                           onTap: () {
                //                             iApEngine.handlePurchase(
                //                                 _products[index], _productIds);

                //                             Navigator.pop(context);
                //                           },
                //                           child: Container(
                //                             height: 60,
                //                             decoration: BoxDecoration(
                //                               borderRadius:
                //                                   BorderRadius.circular(5),
                //                               color: Colors.black,
                //                             ),
                //                             child: Padding(
                //                               padding:
                //                                   const EdgeInsets.symmetric(
                //                                 vertical: 5,
                //                                 horizontal: 5,
                //                               ),
                //                               child: Row(
                //                                 mainAxisAlignment:
                //                                     MainAxisAlignment.center,
                //                                 children: [
                //                                   SizedBox(
                //                                     width: 10,
                //                                   ),
                //                                   Text(
                //                                     _products[index]
                //                                         .description,
                //                                     style: TextStyle(
                //                                       color: Colors.white,
                //                                       fontSize: 18,
                //                                       fontWeight:
                //                                           FontWeight.bold,
                //                                     ),
                //                                   ),
                //                                 ],
                //                               ),
                //                             ),
                //                           ),
                //                         ),
                //                       );
                //                     },
                //                   ),
                //                 ),
                //               ));
                //         },
                //       );
                //     }
                //   },
                //   child: ComboButton(),
                // ),

                // GestureDetector(
                //   onTap: () {
                //     showDialog(
                //       context: context,
                //       builder: (BuildContext context) {
                //         return Dialog(
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(20.0),
                //             ),
                //             backgroundColor: Colors.transparent,
                //             child: Container(
                //               width: screenWidth,
                //               decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(10),
                //                 color: Colors.white38,
                //               ),
                //               child: Padding(
                //                 padding: const EdgeInsets.all(5.0),
                //                 child: ListView.separated(
                //                   separatorBuilder: (context, index) {
                //                     return SizedBox(
                //                       height: 5,
                //                     );
                //                   },
                //                   shrinkWrap: true,
                //                   itemCount: _products.length,
                //                   itemBuilder: (context, index) {
                //                     return Padding(
                //                       padding: const EdgeInsets.symmetric(
                //                         horizontal: 5,
                //                       ),
                //                       child: GestureDetector(
                //                         onTap: () {
                //                           iApEngine.handlePurchase(
                //                               _products[index], _productIds);
                //                         },
                //                         child: Container(
                //                           height: 60,
                //                           decoration: BoxDecoration(
                //                             borderRadius:
                //                                 BorderRadius.circular(5),
                //                             color: Colors.black,
                //                           ),
                //                           child: Padding(
                //                             padding: const EdgeInsets.symmetric(
                //                               vertical: 5,
                //                               horizontal: 5,
                //                             ),
                //                             child: Row(
                //                               mainAxisAlignment:
                //                                   MainAxisAlignment.center,
                //                               children: [
                //                                 SizedBox(
                //                                   width: 10,
                //                                 ),
                //                                 Text(
                //                                   _products[index].description,
                //                                   style: TextStyle(
                //                                     color: Colors.white,
                //                                     fontSize: 18,
                //                                     fontWeight: FontWeight.bold,
                //                                   ),
                //                                 ),
                //                               ],
                //                             ),
                //                           ),
                //                         ),
                //                       ),
                //                     );
                //                   },
                //                 ),
                //               ),
                //             ));
                //       },
                //     );
                //   },
                //   child: ComboButton(),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DailyButton extends StatelessWidget {
  const DailyButton({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        height: screenHeight * 0.09,
        margin: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          border: Border.all(
            width: 3,
            color: Color(0xffBBE1FA),
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          gradient: LinearGradient(
            colors: [
              Color(0xff0F4C75),
              Color(0xff0F4C75).withOpacity(0.09),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'FREE TIPS',
                style: GoogleFonts.poppins(
                  fontSize: screenHeight * 0.030,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ComboButton extends StatelessWidget {
  const ComboButton({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        height: screenHeight * 0.09,
        margin: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          border: Border.all(
            width: 3,
            color: Color(0xffBBE1FA),
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          gradient: LinearGradient(
            colors: [
              Color(0xff750F0F),
              Color(0xff0F4C75).withOpacity(0.09),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'PREMIUM TIPS',
              style: GoogleFonts.poppins(
                fontSize: screenHeight * 0.030,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BonusButton extends StatelessWidget {
  const BonusButton({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        height: screenHeight * 0.110,
        margin: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          border: Border.all(
            width: 3,
            color: Color(0xffBBE1FA),
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          gradient: LinearGradient(
            colors: [
              Color(0xffA27B5C),
              Color(0xff0F4C75).withOpacity(0.09),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'BONUS TIPS',
              style: GoogleFonts.lalezar(
                fontSize: screenHeight * 0.038,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
