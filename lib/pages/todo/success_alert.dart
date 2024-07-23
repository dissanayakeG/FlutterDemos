import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void showCustomAlert({
  required BuildContext context,
  required AlertType type,
  required String title,
  String? description,
  String buttonText = "Ok",
  required Widget Function(BuildContext) routeBuilder,
}) {
  Alert(
    context: context,
    type: type,
    title: title,
    desc: description,
    buttons: [
      DialogButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: routeBuilder,
            ),
          );
        },
        width: 120,
        child: Text(
          buttonText,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ],
  ).show();
}
