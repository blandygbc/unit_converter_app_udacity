import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:unit_converter_app_udacity/views/category_screen.dart';

void main() => runApp(const UnitConverterApp());

class UnitConverterApp extends StatelessWidget {
  const UnitConverterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unit Converter',
      theme: ThemeData(
        fontFamily: 'Raleway', //GoogleFonts.raleway().fontFamily,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.black,
              displayColor: Colors.grey[600],
            ),
        primaryColor: Colors.grey[500],
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: Colors.green[500],
        ),
      ),
      home: const CategoryScreen(),
    );
  }
}
