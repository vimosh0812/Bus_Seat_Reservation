import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/screens/super_admin/admin_console.dart';
import 'package:project1/screens/admin/dashboard.dart';
import 'package:project1/screens/authentication/authenticate.dart';
import 'package:project1/screens/authentication/register.dart';
import 'package:project1/screens/authentication/signin.dart';
import 'package:project1/screens/users/user_main.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          if (snapshot.hasError) {
            return Scaffold(
                body: Center(child: Text('Error: ${snapshot.error}')));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return SignIn(
              toggleView: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Register(toggleView: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignIn(toggleView: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Register(toggleView: () {
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              SignIn(
                                                                  toggleView:
                                                                      () {})),
                                                    );
                                                  })),
                                        );
                                      })),
                            );
                          })),
                );
              },
            );
          }

          String role = snapshot.data!['user_role'];

          switch (role) {
            case 'super_admin':
              return AdminConsole();
            case 'admin':
              return AdminPage();
            case 'customer':
              return UserPage();
            default:
              return Scaffold(body: Center(child: Text('Unknown user role')));
          }
        },
      );
    }
  }
}
