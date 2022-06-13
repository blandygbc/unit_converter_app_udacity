import 'package:flutter/material.dart';
import 'package:unit_converter_app_udacity/models/category.dart';

final _backgroundColor = Colors.green.shade100;

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

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
  Widget _buildCategoryWidgets(List<Widget> categories) {
    // if (portrait) {
    //   return ListView.builder(
    //     itemCount: _categories.length,
    //     itemBuilder: (BuildContext context, int index) => _categories[index],
    //   );
    // } else {
    //   return GridView.count(
    //     crossAxisCount: 2,
    //     childAspectRatio: 3.0,
    //     children: _categories,
    //   );
    // }
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) => categories[index],
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = <Category>[];

    for (var i = 0; i < _categoryNames.length; i++) {
      categories.add(Category(
        categoryName: _categoryNames[i],
        categoryColor: _baseColors[i],
        categoryIcon: Icons.cake,
      ));
    }

    final listView = Container(
      color: _backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: _buildCategoryWidgets(categories),
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
