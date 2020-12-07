import 'package:flutter/material.dart';

class InputEdit extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String placeholder;
  final IconData icon;
  final TextInputType keyboardType;
  final int maxLength;
  final double padding;

  InputEdit({
    Key key,
    this.controller,
    this.label,
    this.placeholder,
    this.icon,
    this.keyboardType,
    this.maxLength,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding != null ? padding : 8.0),
      child: TextField(
        maxLength: maxLength,
        style: TextStyle(
          fontSize: 14.0,
        ),
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: label,
          filled: true,
          icon: icon != null ? Icon(icon) : null,
          hintText: placeholder,
        ),
        keyboardType:
            keyboardType != null ? keyboardType : TextInputType.number,
        controller: controller,
      ),
    );
  }
}
