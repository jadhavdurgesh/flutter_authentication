import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication/services/auth_service.dart';
import 'package:velocity_x/velocity_x.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/sqaure_tile.dart';

class LoginPage extends StatefulWidget {
  
  final  Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // user sign in method
  void signUserIn() async {
    // show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    // try sign in method
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // pop the loading circle
      Navigator.pop(context);
      
    } on FirebaseAuthException catch (e) {

      // pop the loading circle
      Navigator.pop(context);

      // show error message
      showErrorMessage(e.code);
      
    }
  }

    // show error message 
    void showErrorMessage(String message) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(message),
            );
          });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                50.heightBox,
          
                // logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
          
                50.heightBox,
          
                Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
          
                25.heightBox,
          
                // email textfield
                MyTextfield(
                  controller: emailController,
                  hintText: 'Email',
                  obsecureText: false,
                ),
          
                10.heightBox,
          
                // password textfield
                MyTextfield(
                  controller: passwordController,
                  hintText: 'Password',
                  obsecureText: true,
                ),
          
                10.heightBox,
          
                // forget password
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Forget password?'),
                    ],
                  ),
                ),
          
                25.heightBox,
          
                // sign in button
                MyButton(
                  text: 'Sign In',
                  onTap: signUserIn,
                ),
          
                50.heightBox,
          
                // Or contiue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
          
                50.heightBox,
          
                // google + apple sign in button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google button
                    SqaureTile(
                      imagePath: 'lib/images/google.png', 
                      onTap: () { AuthService().signInWithGoogle(); },
                      ),
          
                    25.widthBox,
          
                    //apple button
                    SqaureTile(
                      onTap: (){},
                      imagePath: 'lib/images/apple.png'
                      )
                  ],
                ),
          
                50.heightBox,
          
                // not a member ? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    4.widthBox,
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
