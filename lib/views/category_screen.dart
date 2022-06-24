import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:unit_converter_app_udacity/constants/api_constants.dart';
import 'package:unit_converter_app_udacity/constants/app_constants.dart';
import 'package:unit_converter_app_udacity/constants/assets_constants.dart';
import 'package:unit_converter_app_udacity/models/category.dart';
import 'package:unit_converter_app_udacity/models/unit.dart';
import 'package:unit_converter_app_udacity/utils/services/rest_api.dart';
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

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (_categories.isEmpty) {
      await _retrieveLocalCategories();
      await _retrieveApiCategory();
    }
  }

  Future<void> _retrieveLocalCategories() async {
    final json = await DefaultAssetBundle.of(context)
        .loadString(AssetsConstants.localSorageDataLocation);

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
        categoryColor: AppConstants.baseColors[categoryIndex],
        categoryIcon: AssetsConstants.icons[categoryIndex],
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

  Future<void> _retrieveApiCategory() async {
    setState(() {
      _categories.add(Category(
        categoryName: ApiConstants.apiCategory['name']!,
        unitList: [],
        categoryColor: AppConstants.baseColors.last,
        categoryIcon: AssetsConstants.icons.last,
      ));
    });
    final api = RestApi();
    final jsonUnits = await api.getUnits(ApiConstants.apiCategory['route']);
    if (jsonUnits != null) {
      final units = <Unit>[];
      for (var unit in jsonUnits) {
        units.add(Unit.fromJson(unit));
      }
      setState(() {
        _categories.removeLast();
        _categories.add(Category(
          categoryName: ApiConstants.apiCategory['name']!,
          unitList: units,
          categoryColor: AppConstants.baseColors.last,
          categoryIcon: AssetsConstants.icons.last,
        ));
      });
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
          var category = _categories[index];
          return CategoryTile(
            category: category,
            onTap: category.categoryName == ApiConstants.apiCategory['name'] &&
                    category.unitList.isEmpty
                ? null
                : _onCategoryTap,
          );
        },
      );
    } else {
      return GridView.count(
        // crossAxisSpacing: 2,
        // mainAxisSpacing: 2,
        crossAxisCount: 2,
        childAspectRatio: 3,
        children: _categories.map((Category cat) {
          return CategoryTile(
            category: cat,
            onTap: cat.categoryName == ApiConstants.apiCategory['name'] &&
                    cat.unitList.isEmpty
                ? null
                : _onCategoryTap,
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
