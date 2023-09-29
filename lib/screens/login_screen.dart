import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';                       //Firebase  Library
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/signup_screen.dart';
import 'package:flutter_application_1/screens/resetpassword_screen.dart';
import 'package:flutter_application_1/screens/resuable_widgets/resuable_widget.dart';


class LogInPage extends StatefulWidget {                        //LogIn Class is created.
  const LogInPage({ Key? key }) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {

  // Text Editing Controller FUNCTIONS //
  TextEditingController _passwordTextController = TextEditingController();      //Password  text editing controller function
  TextEditingController _emailTextController = TextEditingController();         //Email text editing controller function

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
           height: MediaQuery.of(context).size.height ,
            decoration: BoxDecoration(
             gradient: LinearGradient(                           //Login Page backgroundcolor
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
            
            begin: Alignment.topCenter,          //
            end: Alignment.bottomCenter,         //
), ),

        child: SingleChildScrollView(
          child: Padding(
            padding:EdgeInsets.fromLTRB(
              18, MediaQuery.of(context).size.height * 0.13, 18, 0),      //Logo is designed.

              child: Column(
                children: <Widget> [
                  logoWidget("images/logo.png"),            //My logo defined from application.

                  const SizedBox(             //30 cm Sized box created.
                    height: 30,
                  ),

                  reusableTextField("Enter User Name or Email",    //"Enter User Name" Script
                  Icons.person, false,                            //Person Icon is created in Sizedbox.
                  _emailTextController),                         //Email text controller function

                  const SizedBox(
                    height: 20,                //20 cm Sized box created.
                  ),
                  
                  reusableTextField("Enter Password",         //"Enter Password" Script 
                  Icons.lock, true,                          //Lock Icon is created in Sizedbox.
                  _passwordTextController),                 //Password text controller function

                  const SizedBox(
                    height: 5,                 //5 cm Sized box created.
                  ),

                forgetPassword(context),
                firebaseUIButton(context, "LOGIN", () {               //LOGIN button is created.
                      FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                        email: _emailTextController.text,                      
                        password: _passwordTextController.text)
                        .then((value) {
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));    //If you clik it you can go to the Home Page.
                        }).onError((error, stackTrace) {
                        print("Error ${error.toString()}");

                        }
                      );
                    }
                  ),
                signUpOption()    
              ],
            ),
          ),
        ),
      ),
    );
  }



  // FORGET PASSWORD OPTION in Login Page //

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,

        // PART 1 //
        child: TextButton(
        child: const Text(
          "Forgot Password?",               //"Forgot Password?" Script is created.
          style: TextStyle(                //"Forgot Password?" Script is designed.
          fontSize: 15,                            
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.right,      
          ),
        
        // PART 2 //
            onPressed: () => Navigator.push(
            context, MaterialPageRoute(
            builder: (context) => ResetPasswordPage(),     //If you click Reset Password script, you can go to Reset Password Page.


          ),
        ),   
      ),
    );
  }



  // SIGN UP OPTION in Login Page  //

   Row signUpOption(){
    return Row(
      mainAxisAlignment:MainAxisAlignment.center,  

      // PART 1 //          
        children: [
         const Text("Don't have account?",                        
         style: TextStyle(                              //"Dont't have account?" Script is designed.     
         fontSize: 18,
         color:Colors.white70)),


      // PART 3 //
        GestureDetector(
          onTap: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => SignUpPage()));      //If you click Sign Up script, you can go to Sign Up Page.
          },
        

      // PART 2 //
        child: const Text(
          " Sign Up",                          //"Sign Up" Script is created.
              style: TextStyle(               //"Sign Up" Script is designed.
              fontSize: 18,                       
              color: Colors.white,
              fontWeight: FontWeight.bold,

            ),
          ),  
        ),
      ],
    );
  }
}

