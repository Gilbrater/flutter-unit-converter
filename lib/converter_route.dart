import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:custom_widget/unit.dart';

class ConverterRoute extends StatefulWidget {
  final List<Unit> units;
  final ColorSwatch color;
  final String name;

  const ConverterRoute({
    @required this.units,
    @required this.name,
    @required this.color,
  })  : assert(units != null),
        assert(name != null),
        assert(color != null);

  @override
  _ConverterRouteState createState() => _ConverterRouteState();
}

class _ConverterRouteState extends State<ConverterRoute> {
  Unit _fromValue;
  Unit _toValue;
  double _inputValue;
  String _convertedValue = '';
  List<DropdownMenuItem> _unitMenuItems;
  bool _showValidationError = false;

  @override
  void initState() {
    super.initState();
    _createDropdownMenuItems();
    _setDefaults();
  }

  void _createDropdownMenuItems() {
    var newItems = <DropdownMenuItem>[];
    for (var unit in widget.units) {
      newItems.add(DropdownMenuItem(
        value: unit.name,
        child: Container(
          child: Text(
            unit.name,
            softWrap: true,
          ),
        ),
      ));
    }
    setState(() {
      _unitMenuItems = newItems;
    });
  }

  void _setDefaults() {
    setState(() {
      _fromValue = widget.units[0];
      _toValue = widget.units[1];
    });
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

  void _updateConversion() {
    setState(() {
      _convertedValue= _format(_inputValue * (_toValue.conversion/ _fromValue.conversion));
    });
  }

  void _updateInputValue(String input) {
    setState(() {
      if (input == null || input.isEmpty){
        _convertedValue = '';
      }else{
        try{
          final inputDouble = double.parse(input);
          _showValidationError=false;
          _inputValue=inputDouble;
          _updateConversion();
        }on Exception catch(e){
          print('Error: $e');
          _showValidationError =true;
        }
      }
    });
  }

  Unit _getUnit(String unitName) {
    return widget.units.firstWhere(
      (Unit unit) {
        return unit.name == unitName;
      },
      orElse: null,
    );
  }

  void _updateFromCoversion(dynamic unitName) {
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  style: Theme.of(context).textTheme.display1,
                  keyboardType: TextInputType.number,
                  onChanged: _updateInputValue,
                  decoration: InputDecoration(
                    labelStyle: Theme.of(context).textTheme.display1,
                    labelText: 'Input',
                    errorText:
                        _showValidationError ? 'Invalid number entered' : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.0),
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      border: Border.all(
                        color: Colors.grey[600],
                        width: 1.0,
                      )),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                          canvasColor: Colors.grey[50],
                        ),
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                          value: _fromValue.name,
                          items: _unitMenuItems,
                          onChanged: _updateFromCoversion,
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          RotatedBox(
            quarterTurns: 1,
            child: Icon(
              Icons.compare_arrows,
              size: 40.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InputDecorator(
                  child: Text(
                    _convertedValue,
                    style: Theme.of(context).textTheme.display1,
                  ),
                  decoration: InputDecoration(
                    labelStyle: Theme.of(context).textTheme.display1,
                    labelText: 'Output',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.0),
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      border: Border.all(
                        color: Colors.grey[600],
                        width: 1.0,
                      )),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                          canvasColor: Colors.grey[50],
                        ),
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                          value: _toValue.name,
                          items: _unitMenuItems,
                          onChanged: _updateToConversion,
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*List<Container> unitWidgets = new List();
    units.forEach((unit) {
      unitWidgets.add(
        Container(
          color: color,
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                unit.name,
                style: Theme.of(context).textTheme.headline,
              ),
              Text(
                'Conversion: ${unit.conversion}',
                style: Theme.of(context).textTheme.subhead,
              ),
            ],
          ),
        ),
      );
    });

    return ListView(
      children: unitWidgets,
    );*/
