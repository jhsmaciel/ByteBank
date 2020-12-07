import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String textLoading;

  const Loading({Key key, this.textLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              textLoading,
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
