import 'package:flutter/material.dart';

///extension  class for snackbar
extension SnackBarExtension on BuildContext {
  ///method for showing  snackbar
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
              color: Color.fromARGB(255, 211, 18, 4), fontSize: 18),
        ),
        backgroundColor: Colors.grey[500],
      ),
    );
  }
}
