import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:custom_widget/unit.dart';
import 'package:custom_widget/converter_route.dart';

final _rowHeight = 100.0;
final _borderRadius = BorderRadius.circular(_rowHeight / 4);

class Category extends StatelessWidget {
  final IconData iconLocation;
  final ColorSwatch color;
  final String name;
  final List<Unit> units;

  const Category({
    Key key,
    @required this.iconLocation,
    @required this.color,
    @required this.name,
    @required this.units,
  })  : assert(name != null),
        assert(color != null),
        assert(iconLocation != null),
        assert(units != null),
        super(key: key);

  void _navigateToConverter(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              elevation: 1.0,
              title: Text(
                name,
                style: Theme.of(context).textTheme.display1,
              ),
              centerTitle: true,
              backgroundColor: color,
            ),
            body: ConverterRoute(
              units: units,
              color: color,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.only(left: 8.0),
        height: _rowHeight,
        child: InkWell(
          borderRadius: _borderRadius,
          highlightColor: color,
          splashColor: color,
          onTap: () {
            print('Hey, I was tapped');
            _navigateToConverter(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 16.0, left: 20.0),
                child: Icon(
                  iconLocation,
                  size: 60.0,
                ),
              ),
              Center(
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
Widget height: 100.0
Icon size: 60.0
Icon-with-colored-background width: 70.0
Text size: 24.0

The icon, color, and text should be passed into the Category widget upon instantiation. They should be required.
Height of the Category widget is 100.0. Its padding is 8.0.
The widget's border radius is half of the Category height (in this case, 50.0). You can define both the height and the border radius as constants.
Icon size is 60.0. The padding around the icon is 16.0.
Text size is 24.0.
The InkWell will not animate if the onTap function is null. Use a print statement for now, as a placeholder. i.e. onTap: () { print('I was tapped!'); }.
The InkWell's splash and highlight colors should be the color we pass in.
 */
