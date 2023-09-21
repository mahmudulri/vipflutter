import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class FreeTips extends StatefulWidget {
  String appbarTitle;
  String dateName;
  String tipsName;
  FreeTips(
      {super.key,
      required this.tipsName,
      required this.appbarTitle,
      required this.dateName});

  @override
  State<FreeTips> createState() => _FreeTipsState();
}

class _FreeTipsState extends State<FreeTips> {
  var isLoading = false.obs;
  @override
  void initState() {
    fetchDate();

    super.initState();
  }

  // for old

  var oldmaintime;
  var oldcurrentDate;

  fetcholdDate() {
    isLoading(true);
    print(isLoading);

    FirebaseFirestore.instance
        .collection('PremiumTipsDate')
        .doc("currentDate")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          oldmaintime = documentSnapshot.data();
          oldcurrentDate = maintime["date"];
        });
      } else {
        print('Document does not exist on the database');
      }
    });
    isLoading(false);
    print(isLoading);
  }

  // for old

  var maintime;
  var currentDate;

  fetchDate() {
    isLoading(true);
    print(isLoading);

    FirebaseFirestore.instance
        .collection(widget.dateName)
        .doc("currentDate")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          maintime = documentSnapshot.data();
          currentDate = maintime["date"];
        });
      } else {
        print('Document does not exist on the database');
      }
    });
    isLoading(false);
    print(isLoading);
  }

  @override
  Widget build(BuildContext context) {
    final screeHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          elevation: 0.0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xff1F2F38),
          title: Text(
            widget.appbarTitle,
            style: TextStyle(
              fontSize: screeHeight * 0.030,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                color: Colors.black,
                width: screenWidth,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(
                    child: currentDate == null
                        ? Text(
                            "",
                            style: TextStyle(
                              fontSize: screeHeight * 0.025,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        : Text(
                            currentDate.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.025,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ),
              ),

              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(widget.tipsName)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 5,
                        );
                      },
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, i) {
                        var finalData = snapshot.data!.docs[i];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 0,
                          ),
                          child: Container(
                            width: screenWidth,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.90),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Text(
                                          finalData["legue"],
                                          style: TextStyle(
                                            fontSize: screeHeight * 0.020,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 1,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          finalData["team"],
                                          style: TextStyle(
                                            fontSize: screeHeight * 0.018,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 1,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              finalData["score1"],
                                              style: TextStyle(
                                                fontSize: screeHeight * 0.018,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              finalData["score2"],
                                              style: TextStyle(
                                                fontSize: screeHeight * 0.018,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),

              SizedBox(
                height: 5,
              ),
              Container(
                height: 40,
                width: screenWidth,
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Center(
                  child: Text(
                    "Elite Vip Success Tips",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.025,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(widget.tipsName)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 5,
                        );
                      },
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, i) {
                        var finalData = snapshot.data!.docs[i];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 0,
                          ),
                          child: Container(
                            width: screenWidth,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.90),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Text(
                                          finalData["legue"],
                                          style: TextStyle(
                                            fontSize: screeHeight * 0.020,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 1,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          finalData["team"],
                                          style: TextStyle(
                                            fontSize: screeHeight * 0.018,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 1,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              finalData["score1"],
                                              style: TextStyle(
                                                fontSize: screeHeight * 0.018,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              finalData["score2"],
                                              style: TextStyle(
                                                fontSize: screeHeight * 0.018,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),

              // Expanded(
              //   flex: 1,
              //   child: Container(
              //     child: Expanded(
              //       flex: 1,
              //       child: Container(
              //         width: screenWidth,
              //         child: Center(
              //           child: currentDate == null
              //               ? Text(
              //                   "",
              //                   style: GoogleFonts.lalezar(
              //                     fontSize: screeHeight * 0.025,
              //                     color: Colors.white,
              //                     fontWeight: FontWeight.w400,
              //                   ),
              //                 )
              //               : Text(
              //                   currentDate.toString(),
              //                   style: GoogleFonts.lalezar(
              //                     fontSize: screeHeight * 0.025,
              //                     color: Colors.black,
              //                     fontWeight: FontWeight.w400,
              //                   ),
              //                 ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              // Expanded(
              //   flex: 1,
              //   child: Container(
              //     width: screenWidth,
              //     child: Center(
              //       child: currentDate == null
              //           ? Text(
              //               "",
              //               style: GoogleFonts.lalezar(
              //                 fontSize: screeHeight * 0.025,
              //                 color: Colors.white,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //             )
              //           : Text(
              //               currentDate.toString(),
              //               style: GoogleFonts.lalezar(
              //                 fontSize: screeHeight * 0.025,
              //                 color: Colors.black,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //             ),
              //     ),
              //   ),
              // ),
              // Container(
              //   child: StreamBuilder(
              //     stream: FirebaseFirestore.instance
              //         .collection("FreeTips")
              //         .snapshots(),
              //     builder: (context,
              //         AsyncSnapshot<QuerySnapshot> snapshot) {
              //       if (snapshot.hasData) {
              //         return ListView.separated(
              //           separatorBuilder: (context, index) {
              //             return SizedBox(
              //               height: 5,
              //             );
              //           },
              //           physics: BouncingScrollPhysics(),
              //           itemCount: snapshot.data!.docs.length,
              //           itemBuilder: (context, i) {
              //             var finalData = snapshot.data!.docs[i];
              //             return Padding(
              //               padding: const EdgeInsets.symmetric(
              //                 horizontal: 0,
              //               ),
              //               child: Container(
              //                 width: screenWidth,
              //                 decoration: BoxDecoration(
              //                   color: Colors.white,
              //                 ),
              //                 child: Padding(
              //                   padding: const EdgeInsets.all(10.0),
              //                   child: Column(
              //                     children: [
              //                       Container(
              //                         child: Column(
              //                           children: [
              //                             Text(
              //                               finalData["legue"],
              //                               style: TextStyle(
              //                                 fontSize:
              //                                     screeHeight * 0.020,
              //                                 color: Colors.green,
              //                                 fontWeight:
              //                                     FontWeight.bold,
              //                               ),
              //                             ),
              //                             SizedBox(
              //                               height: 5,
              //                             ),
              //                             Container(
              //                               height: 1,
              //                               color: Colors.black,
              //                             ),
              //                             SizedBox(
              //                               height: 5,
              //                             ),
              //                             Text(
              //                               finalData["team"],
              //                               style: TextStyle(
              //                                 fontSize:
              //                                     screeHeight * 0.018,
              //                                 color: Colors.black,
              //                                 fontWeight:
              //                                     FontWeight.w600,
              //                               ),
              //                             ),
              //                             SizedBox(
              //                               height: 5,
              //                             ),
              //                             Container(
              //                               height: 1,
              //                               color: Colors.black,
              //                             ),
              //                             SizedBox(
              //                               height: 5,
              //                             ),
              //                             Row(
              //                               mainAxisAlignment:
              //                                   MainAxisAlignment
              //                                       .center,
              //                               children: [
              //                                 Text(
              //                                   finalData["score1"],
              //                                   style: TextStyle(
              //                                     fontSize:
              //                                         screeHeight *
              //                                             0.018,
              //                                     color: Colors.black,
              //                                     fontWeight:
              //                                         FontWeight.w600,
              //                                   ),
              //                                 ),
              //                                 SizedBox(
              //                                   width: 10,
              //                                 ),
              //                                 Text(
              //                                   finalData["score2"],
              //                                   style: TextStyle(
              //                                     fontSize:
              //                                         screeHeight *
              //                                             0.018,
              //                                     color: Colors.black,
              //                                     fontWeight:
              //                                         FontWeight.w600,
              //                                   ),
              //                                 ),
              //                               ],
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             );
              //           },
              //         );
              //       } else {
              //         return Center(
              //             child: CircularProgressIndicator());
              //       }
              //     },
              //   ),
              // ),
            ],
          ),
        ));
  }
}
