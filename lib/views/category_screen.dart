import 'package:flutter/material.dart';
import 'package:unit_converter_app_udacity/models/category.dart';
import 'package:unit_converter_app_udacity/models/unit.dart';

final _backgroundColor = Colors.green.shade100;

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final _categories = <Category>[];

  static const _categoryNames = <String>[
    'Length',
    'Area',
    'Volume',
    'Mass',
    'Time',
    'Digital Storage',
    'Energy',
    'Currency',
  ];

  static const _baseColors = <Color>[
    Colors.teal,
    Colors.orange,
    Colors.pinkAccent,
    Colors.blueAccent,
    Colors.yellow,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.red,
  ];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < _categoryNames.length; i++) {
      _categories.add(Category(
        categoryName: _categoryNames[i],
        categoryColor: _baseColors[i],
        categoryIcon: Icons.cake,
        unitList: _retrieveUnitList(_categoryNames[i]),
      ));
    }
  }

  Widget _buildCategoryWidgets(bool portrait) {
    if (portrait) {
      return ListView.builder(
        itemCount: _categories.length,
        itemBuilder: (BuildContext context, int index) => _categories[index],
      );
    } else {
      return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 3.0,
        children: _categories,
      );
    }
  }

  /// Returns a list of mock [Unit]s.
  List<Unit> _retrieveUnitList(String categoryName) {
    return List.generate(10, (int i) {
      i += 1;
      return Unit(
        name: '$categoryName Unit $i',
        conversion: i.toDouble(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final listView = Container(
      color: _backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: _buildCategoryWidgets(true),
    );

    final appBar = AppBar(
      elevation: 0,
      title: const Text(
        "Unit Converter",
        style: TextStyle(
          color: Colors.black,
          fontSize: 30,
        ),
      ),
      centerTitle: true,
      backgroundColor: _backgroundColor,
    );

    return Scaffold(
      appBar: appBar,
      body: listView,
    );
  }
}
