import 'package:flutter/material.dart';
import 'package:unit_converter_app_udacity/models/unit.dart';
import 'package:unit_converter_app_udacity/views/converter_screen.dart';

class Category extends StatelessWidget {
  static const _rowHeight = 100.0;
  static const _iconSize = 60.0;
  static const _categoryNameSize = 24.0;
  final _borderRadius = BorderRadius.circular(_rowHeight / 2);
  final categoryIcon;
  final categoryColor;
  // final inkHighlightColor;
  // final inkSplashColor;
  final String categoryName;
  final List<Unit> unitList;

  Category({
    Key? key,
    required this.categoryIcon,
    required this.categoryColor,
    // this.inkHighlightColor,
    // this.inkSplashColor,
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
              style: Theme.of(context).textTheme.headline5,
            ),
            centerTitle: true,
            backgroundColor: categoryColor,
          ),
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
    assert(debugCheckHasMaterial(context));
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        height: _rowHeight,
        child: InkWell(
          borderRadius: _borderRadius,
          highlightColor: categoryColor,
          splashColor: categoryColor,
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
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: _categoryNameSize,
                    fontWeight: FontWeight.w700,
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
