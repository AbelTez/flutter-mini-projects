import 'package:day05/service/auth_service.dart';
import 'package:day05/widget/snack_bar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  AuthService authService = AuthService();

  void _logout(BuildContext context) async {
    try {
      await authService.logout(context);
      showSnackBar(context, "Sign out successful");
    } catch (e) {
      print("Error: $e");
      showSnackBar(context, "Failed to sign out");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => _logout(context),
          child: Icon(Icons.exit_to_app),
        ),
      ),
    );
  }
}
