import 'package:day05/pages/auth/login_screen.dart';
import 'package:day05/pages/screen/app_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://mjgloqfgegynzxdludmo.supabase.co',
    anonKey: 'sb_publishable_cQPTpqim5ozr2FIeQWTg3w_6p6NdBU2',
    authOptions: const FlutterAuthClientOptions(
      autoRefreshToken: true,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthCheck(),
    );
  }
}

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  final supabase = Supabase.instance.client;

  // Initialize immediately
  late final Future<void> _sessionFuture = _restoreSession();
  Future<void> _restoreSession() async {
    try {
      final session = supabase.auth.currentSession;

      // Refresh existing session
      if (session != null) {
        await supabase.auth.refreshSession();
      }
    } catch (e) {
      debugPrint("Session restore error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _sessionFuture,
      builder: (context, snapshot) {
        // Loading screen
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Listen for auth state changes
        return StreamBuilder<AuthState>(
          stream: supabase.auth.onAuthStateChange,
          builder: (context, authSnapshot) {
            final session = supabase.auth.currentSession;

            // Logged in
            if (session != null) {
              return const AppMainScreen();
            }

            // Not logged in
            return const LoginScreen();
          },
        );
      },
    );
  }
}
