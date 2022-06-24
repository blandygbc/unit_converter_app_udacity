import 'package:flutter/material.dart';
import 'package:unit_converter_app_udacity/constants/api_constants.dart';
import 'package:unit_converter_app_udacity/models/category.dart';
import 'package:unit_converter_app_udacity/models/unit.dart';
import 'package:unit_converter_app_udacity/utils/services/rest_api.dart';

class UnitConverterScreen extends StatefulWidget {
  final Category category;

  const UnitConverterScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<UnitConverterScreen> createState() => _UnitConverterScreenState();
}

class _UnitConverterScreenState extends State<UnitConverterScreen> {
  Unit? _fromValue;
  Unit? _toValue;
  double? _inputValue;
  String _convertedValue = '';
  List<DropdownMenuItem>? _unitMenuItems;
  bool _showValidationError = false;
  final _inputKey = GlobalKey(debugLabel: 'inputText');
  bool _showErrorUI = false;

  static const _padding = EdgeInsets.all(16.0);

  @override
  void initState() {
    super.initState();
    _createDropdownMenuItems();
    _setDefaults();
  }

  @override
  void didUpdateWidget(UnitConverterScreen old) {
    super.didUpdateWidget(old);
    if (old.category != widget.category) {
      _createDropdownMenuItems();
      _setDefaults();
    }
  }

  void _createDropdownMenuItems() {
    List<DropdownMenuItem> newItems = <DropdownMenuItem>[];
    for (Unit unit in widget.category.unitList) {
      newItems.add(DropdownMenuItem(
        value: unit.name,
        child: Text(
          unit.name!,
          softWrap: true,
        ),
      ));
    }
    setState(() {
      _unitMenuItems = newItems;
    });
  }

  void _setDefaults() {
    setState(() {
      _fromValue = widget.category.unitList[0];
      _toValue = widget.category.unitList[1];
    });
    if (_inputValue != null) {
      _updateConversion();
    }
  }

  String _format(double conversion) {
    var outputNum = conversion.toStringAsPrecision(7);
    if (outputNum.contains('.') && outputNum.endsWith('0')) {
      var i = outputNum.length - 1;
      while (outputNum[i] == '0') {
        i -= 1;
      }
      outputNum = outputNum.substring(0, i + 1);
    }
    if (outputNum.endsWith('.')) {
      return outputNum.substring(0, outputNum.length - 1);
    }
    return outputNum;
  }

  Future<void> _updateConversion() async {
    if (widget.category.categoryName == ApiConstants.apiCategory['name']) {
      final api = RestApi();
      final conversion = await api.convert(ApiConstants.apiCategory['route'],
          _inputValue.toString(), _fromValue!.name, _toValue!.name);
      if (conversion == null) {
        setState(() {
          _showErrorUI = true;
        });
      } else {
        setState(() {
          _showErrorUI = false;
          _convertedValue = _format(conversion);
        });
      }
    } else {
      setState(() {
        _convertedValue = _format(
            _inputValue! * (_toValue!.conversion! / _fromValue!.conversion!));
      });
    }
  }

  void _updateInputValue(String input) {
    setState(() {
      if (input.isEmpty) {
        _convertedValue = '';
      } else {
        try {
          final inputDouble = double.parse(input);
          _showValidationError = false;
          _inputValue = inputDouble;
          _updateConversion();
        } on Exception catch (e) {
          debugPrint('Error: $e');
          _showValidationError = true;
        }
      }
    });
  }

  Unit? _getUnit(String? unitName) {
    return widget.category.unitList.firstWhere(
      (Unit unit) => unit.name == unitName,
    );
  }

  void _updateFromConversion(dynamic unitName) {
    setState(() {
      _fromValue = _getUnit(unitName);
    });
    if (_inputValue != null) {
      _updateConversion();
    }
  }

  void _updateToConversion(dynamic unitName) {
    setState(() {
      _toValue = _getUnit(unitName);
    });
    if (_inputValue != null) {
      _updateConversion();
    }
  }

  Widget _createDropdown(
      String? currentValue, ValueChanged<dynamic> onChanged) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(
          color: Colors.grey[400]!,
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.grey[50],
        ),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
              value: currentValue,
              items: _unitMenuItems,
              onChanged: onChanged,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if ((widget.category.categoryName == ApiConstants.apiCategory['name'] &&
        _showErrorUI)) {
      return SingleChildScrollView(
        child: Container(
          margin: _padding,
          padding: _padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: widget.category.categoryColor['error'],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 180.0,
                color: Colors.white,
              ),
              Text(
                "Houston, we have a problem!\nWe can't connect right now!",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
        ),
      );
    }
    final input = Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            style: Theme.of(context).textTheme.headline4,
            decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.headline4,
              errorText: _showValidationError ? 'Invalid number entered' : null,
              labelText: 'Add your value here',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
            keyboardType: TextInputType.number,
            onChanged: _updateInputValue,
          ),
          _createDropdown(_fromValue!.name, _updateFromConversion),
        ],
      ),
    );

    const arrows = RotatedBox(
      quarterTurns: 1,
      child: Icon(
        Icons.compare_arrows,
        size: 40.0,
      ),
    );

    final output = Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InputDecorator(
            decoration: InputDecoration(
              labelText: 'Result',
              labelStyle: Theme.of(context).textTheme.headline4,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
            child: Text(
              _convertedValue,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          _createDropdown(_toValue!.name, _updateToConversion),
        ],
      ),
    );

    final converter = ListView(
      children: [
        input,
        arrows,
        output,
      ],
    );

    return Padding(
        padding: _padding,
        child: OrientationBuilder(
            builder: (BuildContext contex, Orientation orientation) {
          if (orientation == Orientation.portrait) {
            return converter;
          } else {
            return Center(
              child: SizedBox(
                width: 450.0,
                child: converter,
              ),
            );
          }
        }));
  }
}
