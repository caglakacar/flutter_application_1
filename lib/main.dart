import "package:flutter/material.dart"; 

import 'package:firebase_auth/firebase_auth.dart';     //Firebase Authentication Library
import 'package:firebase_core/firebase_core.dart';     //Firebase Core Library

import 'package:flutter_application_1/screens/login_screen.dart';


final FirebaseAuth _auth=FirebaseAuth.instance;  

void main() async {
  WidgetsFlutterBinding.ensureInitialized();    
  await Firebase.initializeApp();              

 runApp( MyApp());    //My App is running from runApp Function.
                                            
}

class MyApp extends StatelessWidget {      //This widget is the root of my application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,     //Debug script destroyed. 
  
      theme: ThemeData(
     
      primarySwatch: Colors.blueGrey,       
      ),

             
      home: const LogInPage(),     //Home is defined LogIn Page now.

    );
  }
}


