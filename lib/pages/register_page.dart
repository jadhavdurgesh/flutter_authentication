import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication/services/auth_service.dart';
import 'package:velocity_x/velocity_x.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/sqaure_tile.dart';

class RegisterPage extends StatefulWidget {
  
  final  Function()? onTap;
  
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // user sign up method
  void signUserUp() async {
    // show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    // try creating user 
    try {
      //check if user is confirmed 
      if(passwordController.text == confirmPasswordController.text){
         await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      }
      else{
        // show error message , password are not matching
        Navigator.pop(context);
        showErrorMessage("Password don't match!");
      }

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
                  'Let\'s create an account for you',
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
          
                // confirm password textfield
                MyTextfield(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obsecureText: true,
                ),
          
                25.heightBox,
          
                // sign in button
                MyButton(
                  text: "Sign Up",
                  onTap: signUserUp,
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
                      onTap: () => AuthService().signInWithGoogle(),
                      imagePath: 'lib/images/google.png',
                      ),
          
                    25.widthBox,
          
                    //apple button
                    SqaureTile(
                      onTap: (){},
                      imagePath: 'lib/images/apple.png',
                      )
                  ],
                ),
          
                50.heightBox,
          
                // not a member ? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    4.widthBox,
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
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
