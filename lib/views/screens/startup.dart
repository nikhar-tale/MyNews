import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_news/services/firebase_service.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class StartUp extends StatelessWidget {
  StartUp({super.key});
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
        future: _firebaseService.getCurrentUser(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Scaffold(
                    body: Center(child: Text('Error: ${snapshot.error}')));
              } else if (snapshot.data == null) {
                return const LoginScreen();
              } else {
                return const HomeScreen();
              }
          }
        });
  }
}
