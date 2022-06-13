import 'package:flutter/material.dart';
import 'package:unit_converter_app_udacity/views/category_screen.dart';

void main() => runApp(const UnitConverterApp());

class UnitConverterApp extends StatelessWidget {
  const UnitConverterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unit Converter',
      home: CategoryScreen(),
    );
  }
}
