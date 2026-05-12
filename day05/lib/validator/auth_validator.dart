import 'package:day05/widget/snack_bar.dart';
import 'package:flutter/material.dart';

bool validateAndSignup(BuildContext context, String email, String password) {
  if (email.isEmpty || password.isEmpty) {
    showSnackBar(context, "Please fill all fields");
    return false;
  }
  
  if (password.length < 4) {
    showSnackBar(context, "Password must be at least 4 characters long");
    return false;
  }

  return true;
}

bool validateAndSignin(BuildContext context, String email, String password) {
  if (email.isEmpty || password.isEmpty) {
    showSnackBar(context, "Please fill all fields");
    return false;
  }
  if (password.length < 4) {
    showSnackBar(context, "Password must be at least 4 characters long");
    return false;
  }

  return true;
}