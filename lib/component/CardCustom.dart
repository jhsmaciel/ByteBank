import 'package:flutter/material.dart';

class CardCustom extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget route;
  final Function onClick;

  const CardCustom({
    Key key,
    @required this.icon,
    @required this.label,
    @required this.route,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () {
            if(onClick != null) {
              onClick();
            }
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => route,
            ));
          },
          child: Container(
            height: 100,
            width: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon, color: Colors.white),
                  Text(
                    label,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
