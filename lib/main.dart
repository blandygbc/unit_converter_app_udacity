import 'package:flutter/material.dart';

import 'category.dart';

const _padding = EdgeInsets.all(16);

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text("Unit Converter"),
      ),
      body: Center(
        child: Category(
          categoryIcon: Icons.home,
          categoryName: "Home",
          categoryColor: Colors.black54,
          inkHighlightColor: Colors.blueAccent,
          inkSplashColor: Colors.blue,
        ),
      ),
    ),
  ));
}

class HelloRectangle extends StatelessWidget {
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: _padding,
        color: Colors.greenAccent,
        height: 400,
        width: 300,
        child: Center(
          child: Text(
            "Hello!",
            style: TextStyle(fontSize: 40),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
