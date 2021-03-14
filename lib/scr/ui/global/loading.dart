import 'package:flutter/material.dart';

Future<void> showLoading(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Container(
        height: 80.0,
        width: 80.0,
        alignment: Alignment.center,
        child: Container(
          height: 70.0,
          width: 70.0,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: const EdgeInsets.all(15.0),
            height: 50.0,
            width: 50.0,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    },
  );
}