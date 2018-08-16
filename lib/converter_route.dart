import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:custom_widget/unit.dart';

class ConverterRoute extends StatefulWidget {
  final List<Unit> units;
  final ColorSwatch color;

  const ConverterRoute({
    @required this.units,
    @required this.color,
  })  : assert(units != null),
        assert(color != null);

  @override
  _ConverterRouteState createState() => _ConverterRouteState();
}

class _ConverterRouteState extends State<ConverterRoute> {
  List<Unit> units;
  ColorSwatch color;

  @override
  Widget build(BuildContext context) {
    setState(() {
      units=widget.units;
      color=widget.color;
    });

    List<Container> unitWidgets = new List();
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
    );
  }
}
