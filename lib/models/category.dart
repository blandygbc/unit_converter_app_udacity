import 'package:flutter/material.dart';
import 'package:unit_converter_app_udacity/models/unit.dart';

class Category {
  //final IconData categoryIcon;
  final String categoryIcon;
  final ColorSwatch categoryColor;
  final String categoryName;
  final List<Unit> unitList;

  Category({
    Key? key,
    required this.categoryIcon,
    required this.categoryColor,
    required this.categoryName,
    required this.unitList,
  });
}
