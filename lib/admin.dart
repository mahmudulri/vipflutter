import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  var isLoading = false.obs;
  @override
  void initState() {
    fetchDate();

    super.initState();
  }

  var maintime;
  var currentDate;

  TextEditingController leguController = TextEditingController();
  TextEditingController teamController = TextEditingController();
  TextEditingController score_1Controller = TextEditingController();
  TextEditingController score_2Controller = TextEditingController();

  TextEditingController bigOneController = TextEditingController();
  TextEditingController bigTwoController = TextEditingController();
  TextEditingController bigThreeController = TextEditingController();

  DateTime now = DateTime.now();

  String finaData_1 = "";
  String finaData_2 = "";
  String finaData_3 = "";
  String finaData_4 = "";

  fetchDate() {
    isLoading(true);
    print(isLoading);

    FirebaseFirestore.instance
        .collection('FreetipsDate')
        .doc("currentDate")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          maintime = documentSnapshot.data();
          currentDate = maintime["date"];
          print(currentDate);
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
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0.0,
        title: Row(children: [
          Text("Today"),
          SizedBox(
            width: screenWidth * .050,
          ),
          Container(
              height: 60,
              width: 450,
              child: Row(
                children: [
                  Container(
                    color: Colors.cyan,
                    height: 60,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(currentDate.toString()),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Center(
                      child: currentDate.toString() !=
                              "${DateFormat.d().format(now)}-${DateFormat.MMMM().format(now)}-${DateFormat.y().format(now)}"
                          ? Text(
                              "Please update date",
                              style: TextStyle(color: Colors.red),
                            )
                          : Text("Date Updated"),
                    ),
                  ),
                ],
              )),
          Spacer(),
          InkWell(
            onTap: () {
              FirebaseFirestore.instance
                  .collection("FreetipsDate")
                  .doc("currentDate")
                  .set({
                "date":
                    "${DateFormat.d().format(now)}-${DateFormat.MMMM().format(now)}-${DateFormat.y().format(now)}",
              });
            },
            child: Container(
              height: 60,
              width: 200,
              color: Colors.blueGrey,
              child: Center(child: Text("Update Date")),
            ),
          ),
        ]),
      ),
      body: Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                color: Colors.green,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 120,
                      width: screenWidth * 0.60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: bigOneController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (bigOneController.text.isNotEmpty) {
                              List mylines = bigOneController.text.split("\n");

                              finaData_1 = mylines[0];
                              finaData_2 = mylines[1];
                              finaData_3 = mylines[2]
                                  .substring(0, mylines[2].indexOf("@") + 1);
                              finaData_4 = mylines[2].substring(
                                  mylines[2].indexOf("@") + 1,
                                  mylines[2].length);

                              Fluttertoast.showToast(
                                msg: "Data Setted",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.TOP_LEFT,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            } else {
                              Fluttertoast.showToast(
                                msg: "Input Data First",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.TOP_LEFT,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            }
                          },
                          child: Container(
                            height: 80,
                            width: 120,
                            decoration: BoxDecoration(color: Color(0xff34495e)),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Center(
                                child: Text(
                                  "Set Data",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.025,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (finaData_1 == "" &&
                                finaData_2 == "" &&
                                finaData_3 == "" &&
                                finaData_4 == "") {
                              // Fluttertoast.showToast(
                              //   msg: "No Data Setted",
                              //   toastLength: Toast.LENGTH_LONG,
                              //   gravity: ToastGravity.TOP_LEFT,
                              //   timeInSecForIosWeb: 1,
                              //   backgroundColor: Colors.red,
                              //   textColor: Colors.white,
                              //   fontSize: 16.0,
                              // );
                            } else {
                              FirebaseFirestore.instance
                                  .collection('FreeTips')
                                  .add({
                                "legue": finaData_1,
                                "team": finaData_2,
                                "score1": finaData_3,
                                "score2": finaData_4,
                              });

                              // mydata.child("1").set({
                              //   "legue": finaData_1,
                              //   "team": finaData_2,
                              //   "score1": finaData_3,
                              //   "score2": finaData_4,
                              // });

                              bigOneController.clear();
                              finaData_1 = "";
                              finaData_2 = "";
                              finaData_3 = "";
                              finaData_4 = "";
                            }
                          },
                          child: Container(
                            height: 80,
                            width: 120,
                            decoration: BoxDecoration(color: Color(0xff34495e)),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Center(
                                child: Text(
                                  "ADD DATA",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.025,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 1,
              child: Obx(
                () => isLoading.value == false
                    ? Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xff1F2F38),
                              Color(0xff1B262C),
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: screenWidth,
                                color: Color(0xff0F4C75).withOpacity(0.09),
                                child: Center(
                                  child: currentDate == null
                                      ? Text(
                                          "",
                                          style: GoogleFonts.lalezar(
                                            fontSize: screeHeight * 0.025,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      : Text(
                                          currentDate.toString(),
                                          style: GoogleFonts.lalezar(
                                            fontSize: screeHeight * 0.025,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 20,
                              child: Container(
                                color: Color(0xff0F4C75).withOpacity(0.09),
                                child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("FreeTips")
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasData) {
                                      return ListView.builder(
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, i) {
                                          var finalData =
                                              snapshot.data!.docs[i];
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: screeHeight * 0.018,
                                              horizontal: 20,
                                            ),
                                            child: SizedBox(
                                              height: screeHeight * 0.130,
                                              width: screenWidth,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xff1B262C),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  finalData[
                                                                      "legue"],
                                                                  style:
                                                                      GoogleFonts
                                                                          .lato(
                                                                    fontSize:
                                                                        screeHeight *
                                                                            0.020,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 30,
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            "FreeTips")
                                                                        .doc(finalData
                                                                            .id)
                                                                        .delete();
                                                                  },
                                                                  child: Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Divider(
                                                              color:
                                                                  Colors.white,
                                                              thickness: 1,
                                                              endIndent: 10,
                                                              indent: 10,
                                                            ),
                                                            Text(
                                                              finalData["team"],
                                                              style: GoogleFonts
                                                                  .lato(
                                                                fontSize:
                                                                    screeHeight *
                                                                        0.018,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 15,
                                                          ),
                                                          Expanded(
                                                            flex: 3,
                                                            child: Text(
                                                              finalData[
                                                                  "score1"],
                                                              style: GoogleFonts
                                                                  .lato(
                                                                fontSize:
                                                                    screeHeight *
                                                                        0.020,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              width: 200,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                ),
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  finalData[
                                                                      "score2"],
                                                                  style:
                                                                      GoogleFonts
                                                                          .lato(
                                                                    fontSize:
                                                                        screeHeight *
                                                                            0.020,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
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
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Updating Data"),
                            CircularProgressIndicator(),
                          ],
                        ),
                      ),
              )),
        ],
      ),
    );
  }
}
