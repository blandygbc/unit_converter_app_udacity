import 'package:flutter/material.dart';
// TODO: Check if we need to import anything

// TODO: Define any constants
final _categories = <Widget>[
  ListTile(
    leading: const Icon(Icons.cake),
    title: Text(CategoryScreen._categoryNames[0]),
  ),
  ListTile(
    leading: const Icon(Icons.cake),
    title: Text(CategoryScreen._categoryNames[1]),
  ),
  ListTile(
    leading: const Icon(Icons.cake),
    title: Text(CategoryScreen._categoryNames[2]),
  ),
  ListTile(
    leading: const Icon(Icons.cake),
    title: Text(CategoryScreen._categoryNames[3]),
  ),
  ListTile(
    leading: const Icon(Icons.cake),
    title: Text(CategoryScreen._categoryNames[4]),
  ),
  ListTile(
    leading: const Icon(Icons.cake),
    title: Text(CategoryScreen._categoryNames[5]),
  ),
  ListTile(
    leading: const Icon(Icons.cake),
    title: Text(CategoryScreen._categoryNames[6]),
  ),
  ListTile(
    leading: const Icon(Icons.cake),
    title: Text(CategoryScreen._categoryNames[7]),
  ),
];

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

  @override
  Widget build(BuildContext context) {
    // TODO: Create a list of the eight Categories, using the names and colors
    // from above. Use a placeholder icon, such as `Icons.cake` for each
    // Category. We'll add custom icons later.

    // TODO: Create a list view of the Categories
    final listView = _buildCategoryWidgets(false);

    // TODO: Create an App Bar
    final appBar = AppBar(
      title: const Text("Unit Converter"),
    );

    return Scaffold(
      appBar: appBar,
      body: listView,
    );
  }
}
