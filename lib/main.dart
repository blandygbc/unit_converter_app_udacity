import 'package:flutter/material.dart';
// TODO: Import the CategoryRoute widget
import 'package:unit_converter_app_udacity/views/category_screen.dart';

const _padding = EdgeInsets.all(16);

void main() {
  runApp(const UnitConverterApp());
}

class UnitConverterApp extends StatelessWidget {
  const UnitConverterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unit Converter',
      // TODO: Instead of pointing to exactly 1 Category widget,
      // our home should now point to an instance of the CategoryRoute widget.
      home: CategoryScreen(),
    );
  }
}
