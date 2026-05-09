import 'package:day05/pages/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://mjgloqfgegynzxdludmo.supabase.co',
    anonKey: 'sb_publishable_cQPTpqim5ozr2FIeQWTg3w_6p6NdBU2',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SignupScreen(),
    );
  }
}
