import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';    //Firebase Authentication Library
import 'package:flutter_application_1/screens/resuable_widgets/resuable_widget.dart';
import 'package:flutter_application_1/screens/home_screen.dart';




class ResetPasswordPage extends StatefulWidget {                  //ResetPassword Class is created.
  const ResetPasswordPage({ Key? key }) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  
  // Text Editing Controller FUNCTION //
  TextEditingController _emailTextController = TextEditingController();   //Email text editing controller function
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,     //AppBar Background Color is transparent.
        elevation: 0,
        title: const Text(
          "Forgot Password",             //The title is "Forgot Password".
          style: TextStyle(              //Title is designed.
          fontSize: 24, 
          fontWeight: FontWeight.bold,   
    ),
  ),
),


      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(                                    //Reset Password Page backgroundcolor
              colors: [ 
            Color(0xffbac9d7),
            Color(0xffa3b8ca),
            Color(0xff8ca6bd),                           
            Color(0xff7594af),
            Color(0xff5e83a2),
            Color(0xff477195),
            Color(0xff305f88),
            Color(0xff1a4e7b),
            Color(0xff17466e),
            Color(0xff143e62),
            Color(0xff123655),
            Color(0xff0f2e49),
            ],
            
              begin: Alignment.topCenter, 
              end: Alignment.bottomCenter,

 ),
 ),

          child: SingleChildScrollView(                          
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
             child: Column(
              children: <Widget>[

                const SizedBox(
                  height: 20,          //20 cm Sized box created.
                  ),

                  reusableTextField("Enter Email",     //"Enter Mail" Script
                  Icons.mail, false,                   //Mail Icon is created in Sizedbox.
                  _emailTextController),               //Email text editing controller function

                  const SizedBox(
                  height: 20,          //20 cm Sized box created.
                  ),

                   firebaseUIButton(context, "Reset Password", () {         
                   FirebaseAuth.instance.
                   sendPasswordResetEmail(email: _emailTextController.text)  
                   .then((value) => Navigator.of(context).pop());                  
              
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

