import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showError(BuildContext context, String message){
  Flushbar(
    message: message,
    duration: Duration(seconds: 2),
    flushbarPosition: FlushbarPosition.BOTTOM,
    backgroundColor: Colors.redAccent,
  ).show(context);
}

void showSuccess(BuildContext context, String message){
  Flushbar(
    message: message,
    duration: Duration(seconds: 2),
    flushbarPosition: FlushbarPosition.BOTTOM,
    backgroundColor: Colors.greenAccent,
  ).show(context);
}