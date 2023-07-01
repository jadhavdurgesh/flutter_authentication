import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  // sign out user method 
  void signUserOut(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        actions: [
          IconButton(
            onPressed: signUserOut, 
            icon: const Icon(Icons.logout)
          )
        ]
      ),
      body: Center(
        child: Text('Logged In As : ${user.email!}'),
      ),
    );
  }
}
