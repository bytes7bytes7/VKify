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
        child: SizedBox(
          height: 60.0,
          width: 60.0,
          child: CircularProgressIndicator(
            strokeWidth: 3.0,
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).focusColor,
            ),
          ),
        ),
      );
    },
  );
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 80.0,
        width: 80.0,
        alignment: Alignment.center,
        child: SizedBox(
          height: 60.0,
          width: 60.0,
          child: CircularProgressIndicator(
            strokeWidth: 3.0,
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).focusColor,
            ),
          ),
        ),
      ),
    );
  }
}
