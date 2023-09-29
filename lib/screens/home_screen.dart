import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter_application_1/screens/addpost_screen.dart';
import 'package:flutter_application_1/screens/login_screen.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final dbRef=FirebaseDatabase.instance.reference().child('Posts');      
  FirebaseAuth auth=FirebaseAuth.instance;                              //firebase logout ile ilgili
  TextEditingController searchController = TextEditingController();
  String search = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading:false,
        title: Text('Bloggy Blog',
            style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold, 
            color: Colors.white,
    )),
        centerTitle: true,
        
        actions: [
          InkWell(
          onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddPostPage())); 

          },
          child: Icon(Icons.add_circle_rounded, size: 28,) //If you clicked it, you can go to add post page.
          ),

          SizedBox(width: 15),                                              

        InkWell(
          onTap: (){
            auth.signOut().then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context) => LogInPage())); 
            });   //
          

          },
          child: Icon(Icons.logout_outlined,size: 28,)),
          SizedBox(width: 15),
          
        ],

      ),
      
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:15, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

           TextFormField(
             controller: searchController,
             keyboardType: TextInputType.emailAddress,
             decoration: InputDecoration(
               hintText: 'Search with Blog Title',
               prefixIcon: Icon(Icons.search_rounded),
               border: OutlineInputBorder()

             ),
             onChanged: (String value){
               search = value;
             },
             
           ),

            Expanded(
              child: FirebaseAnimatedList(
                query:dbRef.child('Post List'),
                itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) { 

                  String tempTitle = snapshot.child('pTitle').value.toString();

                  if(searchController.text.isEmpty){
                   return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        decoration: BoxDecoration(
                          color:Colors.blueGrey,
                          borderRadius: BorderRadius.circular(10)

                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: FadeInImage.assetNetwork(
                                  fit: BoxFit.cover,
                                  

                                  placeholder: 'images/logo.png',
                                  image: snapshot.child('pImage').value.toString()),
                          ),

                          SizedBox(height: 15,),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal:10),
                            child: Text(snapshot.child('pTitle').value.toString(), 
                            style: TextStyle(
                              fontSize:15, fontWeight: FontWeight.bold, color: Colors.white),),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal:10),
                            child: Text(snapshot.child('pDescription').value.toString(), 
                            style: TextStyle(
                              fontSize:15, fontWeight: FontWeight.normal, color: Colors.white ),),
                                 
                                 
                          ),
                        ],
                      ),
                    ),
                  ); 
                  }
                  else if(tempTitle.toLowerCase().contains(searchController.toString())){
                    return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        decoration: BoxDecoration(
                          color:Colors.blueGrey,
                          borderRadius: BorderRadius.circular(10)

                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: FadeInImage.assetNetwork(
                                  fit: BoxFit.cover,
                                 
                                  placeholder: 'images/logo.png',
                                  image: snapshot.child('pImage').value.toString()),
                          ),

                          SizedBox(height: 15,),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal:10),
                            child: Text(snapshot.child('pTitle').value.toString(), 
                            style: TextStyle(
                              fontSize:15, fontWeight: FontWeight.bold, color: Colors.white),),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal:10),
                            child: Text(snapshot.child('pDescription').value.toString(), 
                            style: TextStyle(
                              fontSize:15, fontWeight: FontWeight.normal, color: Colors.white ),),
                                 
                                 
                          ),
                        ],
                      ),
                    ),
                  ); 
                  }
                  
                  else {
                    return Container();
                  }
                

                },
              ),
            )
          ],
        ),
      ),
    );
  }
}




