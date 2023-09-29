import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';


class AddPostPage extends StatefulWidget {
  const AddPostPage({ Key? key }) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  
  bool showSpinner = false ;
  final postRef =FirebaseDatabase.instance.reference().child('Posts');
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  
  FirebaseAuth _auth = FirebaseAuth.instance;
 
  File? _image;
  final picker = ImagePicker();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  
  Future getImageGallery() async{
    final pickedFile =await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if(pickedFile!=null){
         _image =File(pickedFile.path);
      }
      else{
         print('No image selected.');
      }
    });
  }

  Future getCameraImage() async{
    final pickedFile =await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if(pickedFile!=null){
         _image =File(pickedFile.path);
      }
      else{
         print('No image selected.');
      }
    });
  }

  void dialog(context){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          content: Container(
            height: 120,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                     getCameraImage();
                     Navigator.pop(context);
                  },
                  child: ListTile(
                    leading: Icon(Icons.camera,size: 25,),
                    title: Text('Camera',
                    style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold, 
                    
    )),
                  ),
 ),
                InkWell(
                  onTap: (){
                      getImageGallery();
                      Navigator.pop(context);
                  },
                  child: ListTile(
                    leading: Icon(Icons.photo_library,size: 25,),
                    title: Text('Gallery',
                    style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold, 
                    
    )),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Upload Post',
            style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold, 
            color: Colors.white,
    ),),
            centerTitle: true,
    ),
    
        body:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: Column(
                   children: [
                     InkWell(
                       onTap: () {
                          dialog(context);
                       },
                       child: Center(
                        child: Container(
                         height: MediaQuery.of(context).size.height *.28,
                          width: MediaQuery.of(context).size.width *1,
                          child: _image!=null ? ClipRect(
                            child: Image.file(
                              _image!.absolute,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fill,
                             ),)
                             :Container(
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(10),),
                                width: 100,
                                height: 100,
                                child: Icon(
                                Icons.add_a_photo_rounded,
                                color: Colors.white,
                                size: 28,
                                ),
                          ),
                                     ),
                                   ),
                     ),
                SizedBox(height: 30,),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: titleController,
                        keyboardType: TextInputType.text,
                       decoration: InputDecoration(
                         labelText: 'Title',
                         hintText: 'Enter Post Title',
                         border: OutlineInputBorder(),
                         hintStyle: TextStyle(color:Color.fromARGB(249, 14, 14, 75), fontWeight: FontWeight.normal),
                         labelStyle: TextStyle(color: Color.fromARGB(249, 14, 14, 75), fontWeight: FontWeight.normal),
                       ),
                      ),
                      SizedBox(height: 30,),
    
      
    
                      TextFormField(
                        controller: descriptionController,
                        keyboardType: TextInputType.text,
                       decoration: InputDecoration(
                         labelText: 'Description',
                         hintText: 'Enter Post Description',
                         border: OutlineInputBorder(),
                         hintStyle: TextStyle(color:Color.fromARGB(249, 14, 14, 75), fontWeight: FontWeight.normal),
                         labelStyle: TextStyle(color: Color.fromARGB(249, 14, 14, 75), fontWeight: FontWeight.normal),
                       ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32,),
                ElevatedButton.icon(
                icon: Icon(Icons.upload_rounded),
                label: Text("  UPLOAD   ",
                style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold, 
                color: Colors.white,
    )),
    
                onPressed: ()async {
                  setState(() {
                    showSpinner = true;
                  });
                  
                  try{

                    int date = DateTime.now().microsecondsSinceEpoch;
                    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/blogapp$date');
                    UploadTask uploadTask = ref.putFile(_image!.absolute);
                    await Future.value(uploadTask);
                    var newUrl = await ref.getDownloadURL();

                    final User? user = _auth.currentUser;
                    postRef.child('Post List').child(date.toString()).set({

                      'pId':date.toString(),
                      'pImage':newUrl.toString(),
                      'pTime':date.toString(),
                      'pTitle':titleController.text.toString(),
                      'pDescription':descriptionController.text.toString(),
                      'uEmail':user!.email.toString(),
                      'uid':user.uid.toString(),
                    

                    }).then((value){
                       toastMessage('Post Published');
                       setState(() {
                       showSpinner = false;
                       });

                    }).onError((error, StackTrace){
                       toastMessage(error.toString());
                       setState(() {
                       showSpinner = false;
                       });
                    });

                  }catch(e){
                     setState(() {
                     showSpinner = false;
                  });

                     toastMessage(e.toString());
                   }
                  },
    
                     style: ElevatedButton.styleFrom(
                     primary: Colors.blueGrey,
                     onPrimary: Colors.white,
                  
    
                     shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(20.0),

                  ),
                 ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
 
  //
  void toastMessage(String message){
    Fluttertoast.showToast(
      msg: message.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16,
    );
  }
}

