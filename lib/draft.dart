import 'package:flutter/material.dart';

class DraftPage extends StatelessWidget {
  const DraftPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screeHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text("Appbar"),
      ),
      body: Column(
        children: [
          Container(
            height: screeHeight * 0.30,
            width: screenWidth / 2,
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Text(
              "Mahmudul Hasan",
              style: TextStyle(
                fontSize: screenWidth * 0.035,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
