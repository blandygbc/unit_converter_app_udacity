import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:unit_converter_app_udacity/models/category.dart';
import 'package:unit_converter_app_udacity/models/unit.dart';
import 'package:unit_converter_app_udacity/views/backdrop.dart';
import 'package:unit_converter_app_udacity/views/unit_converter_screen.dart';
import 'package:unit_converter_app_udacity/widgets/category_tile.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Category? _defaultCategory;
  Category? _currentCategory;
  final _categories = <Category>[];

  // static const _categoryNames = <String>[
  //   'Length',
  //   'Area',
  //   'Volume',
  //   'Mass',
  //   'Time',
  //   'Digital Storage',
  //   'Energy',
  //   'Currency',
  // ];

  static const _baseColors = <ColorSwatch>[
    ColorSwatch(0xFF6AB7A8, {
      'highlight': Color(0xFF6AB7A8),
      'splash': Color(0xFF0ABC9B),
    }),
    ColorSwatch(0xFFFFD28E, {
      'highlight': Color(0xFFFFD28E),
      'splash': Color(0xFFFFA41C),
    }),
    ColorSwatch(0xFFFFB7DE, {
      'highlight': Color(0xFFFFB7DE),
      'splash': Color(0xFFF94CBF),
    }),
    ColorSwatch(0xFF8899A8, {
      'highlight': Color(0xFF8899A8),
      'splash': Color(0xFFA9CAE8),
    }),
    ColorSwatch(0xFFEAD37E, {
      'highlight': Color(0xFFEAD37E),
      'splash': Color(0xFFFFE070),
    }),
    ColorSwatch(0xFF81A56F, {
      'highlight': Color(0xFF81A56F),
      'splash': Color(0xFF7CC159),
    }),
    ColorSwatch(0xFFD7C0E2, {
      'highlight': Color(0xFFD7C0E2),
      'splash': Color(0xFFCA90E5),
    }),
    ColorSwatch(0xFFCE9A9A, {
      'highlight': Color(0xFFCE9A9A),
      'splash': Color(0xFFF94D56),
      'error': Color(0xFF912D2D),
    }),
  ];
  static const _googleIcons = <IconData>[
    Icons.straighten_outlined,
    Icons.settings_overscan_outlined,
    Icons.balance_outlined,
    Icons.scale,
    Icons.schedule,
    Icons.sd_card,
    Icons.electric_bolt,
  ];
  static const _icons = <String>[
    'assets/icons/length.png',
    'assets/icons/area.png',
    'assets/icons/volume.png',
    'assets/icons/mass.png',
    'assets/icons/time.png',
    'assets/icons/digital_storage.png',
    'assets/icons/power.png',
    'assets/icons/currency.png',
  ];

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (_categories.isEmpty) {
      await _retrieveLocalCategories();
    }
  }

  Future<void> _retrieveLocalCategories() async {
    final json = await DefaultAssetBundle.of(context)
        .loadString('assets/data/regular_units.json');

    final regularUnits = const JsonDecoder().convert(json);

    if (regularUnits is! Map) {
      throw ('Data retrieved from API is not a Map');
    }
    int categoryIndex = 0;
    for (String categoryName in regularUnits.keys) {
      final List<Unit> categoryUnits = regularUnits[categoryName]
          .map<Unit>((dynamic unit) => Unit.fromJson(unit))
          .toList();
      Category category = Category(
        categoryName: categoryName,
        unitList: categoryUnits,
        categoryColor: _baseColors[categoryIndex],
        categoryIcon: _icons[categoryIndex],
      );
      setState(() {
        if (categoryIndex == 0) {
          _defaultCategory = category;
        }
        _categories.add(category);
      });
      categoryIndex++;
    }
  }

  void _onCategoryTap(Category category) {
    setState(() {
      _currentCategory = category;
    });
  }

  Widget _buildCategoryWidgets(Orientation deviceOrientation) {
    if (deviceOrientation == Orientation.portrait) {
      return ListView.builder(
        itemCount: _categories.length,
        itemBuilder: (BuildContext context, int index) {
          return CategoryTile(
            category: _categories[index],
            onTap: _onCategoryTap,
          );
        },
      );
    } else {
      return GridView.count(
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        crossAxisCount: 2,
        childAspectRatio: 3,
        children: _categories.map((Category cat) {
          return CategoryTile(
            category: cat,
            onTap: _onCategoryTap,
          );
        }).toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_categories.isEmpty) {
      return const Center(
        child: SizedBox(
          height: 180.0,
          width: 180.0,
          child: CircularProgressIndicator(),
        ),
      );
    }
    final listView = Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: 48.0,
      ),
      child: _buildCategoryWidgets(MediaQuery.of(context).orientation),
    );

    return Backdrop(
      currentCategory: _currentCategory ?? _defaultCategory!,
      frontPanel: _currentCategory == null
          ? UnitConverterScreen(category: _defaultCategory!)
          : UnitConverterScreen(category: _currentCategory!),
      backPanel: listView,
      frontTitle: const Text('Unit Converter'),
      backTitle: const Text('Select a Category'),
    );
  }
}
