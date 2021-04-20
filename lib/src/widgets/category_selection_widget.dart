import 'package:app_finanzas_personales/src/utils/colors.dart' as utilscolor;
import 'package:flutter/material.dart';

class CategorySelectionWidget extends StatefulWidget {
  final Map<String, IconData> categories;
  final Function(String) onValueChanged;
  CategorySelectionWidget({Key key, this.categories, this.onValueChanged})
      : super(key: key);

  @override
  _CategorySelectionWidgetState createState() =>
      _CategorySelectionWidgetState();
}

class CategoryWidget extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool selected;

  const CategoryWidget({Key key, this.name, this.icon, this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(
                  color:
                      selected ? utilscolor.Colors.colorPrimary : Colors.grey,
                  width: selected ? 3.0 : 1.0,
                ),
              ),
              child: Icon(
                icon,
                color: selected ? utilscolor.Colors.colorPrimary : Colors.grey,
              ),
            ),
            Text(
              name,
              style: TextStyle(
                color: selected ? utilscolor.Colors.colorPrimary : Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CategorySelectionWidgetState extends State<CategorySelectionWidget> {
  String currentItem = "";
  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];
    widget.categories.forEach((name, icon) {
      widgets.add(
        GestureDetector(
          onTap: () {
            setState(() {
              currentItem = name;
              widget.onValueChanged(name);
            });
          },
          child: CategoryWidget(
            name: name,
            icon: icon,
            selected: name == currentItem,
          ),
        ),
      );
    });
    return ListView(
      scrollDirection: Axis.horizontal,
      children: widgets,
    );
  }
}
