import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  static const _rowHeight = 100.0;
  static const _borderRadius = 50.0;
  final categoryIcon;
  final categoryColor;
  final inkHighlightColor;
  final inkSplashColor;
  final String categoryName;

  const Category({
    Key? key,
    required this.categoryIcon,
    required this.categoryColor,
    this.inkHighlightColor,
    this.inkSplashColor,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    return Material(
      color: Colors.transparent,
      child: Container(
        height: _rowHeight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(_borderRadius),
            highlightColor: inkHighlightColor,
            splashColor: inkSplashColor,
            onTap: () {
              print("I was tapped!");
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    categoryIcon,
                    size: 60.0,
                  ),
                ),
                Center(
                    child: Text(
                  categoryName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 24,
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
