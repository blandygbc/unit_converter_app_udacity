import 'package:flutter/material.dart';
import 'package:unit_converter_app_udacity/models/unit.dart';
import 'package:unit_converter_app_udacity/views/converter_screen.dart';

class Category extends StatelessWidget {
  static const _rowHeight = 100.0;
  static const _iconSize = 60.0;
  final _borderRadius = BorderRadius.circular(_rowHeight / 2);
  final IconData categoryIcon;
  final ColorSwatch categoryColor;
  final String categoryName;
  final List<Unit> unitList;

  Category({
    Key? key,
    required this.categoryIcon,
    required this.categoryColor,
    required this.categoryName,
    required this.unitList,
  }) : super(key: key);

  /// Navigates to the [ConverterRoute].
  void _navigateToConverter(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              categoryName,
              style: Theme.of(context).textTheme.headline4,
            ),
            centerTitle: true,
            backgroundColor: categoryColor,
          ),
          resizeToAvoidBottomInset: false,
          body: ConverterScreen(
            color: categoryColor,
            units: unitList,
          ),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        height: _rowHeight,
        child: InkWell(
          borderRadius: _borderRadius,
          highlightColor: categoryColor['highlight'],
          splashColor: categoryColor['splashColor'],
          onTap: () => _navigateToConverter(context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    categoryIcon,
                    size: _iconSize,
                  ),
                ),
                Center(
                    child: Text(
                  categoryName,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
