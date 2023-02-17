import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_file/cross_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:revamph/login.dart';
class register extends StatefulWidget {

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  final emailreg=TextEditingController();
  final passreg=TextEditingController();
  final phonereg=TextEditingController();
  final namereg=TextEditingController();
  final clgnamereg=TextEditingController();
  bool _isalumini=false;
  bool _isstudent=false;
  String url='https://png.pngtree.com/png-vector/20190411/ourmid/pngtree-business-male-icon-vector-png-image_916468.jpg';
  String filename='';
  XFile? file;
  File? pickedimage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      body:Scaffold(
          body:AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
              child: Stack(
                children: <Widget>[
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color(0xff86CABC),
                            Color(0xff1D7851),

                          ],
                        )
                    ),
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 120,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text('R E G I S T E R  F O R M ',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold
                          ),
                          ),
                          SizedBox(height: 10,),
                          Center(
                            child: InkWell(
                              onTap: (){
                                showModalBottomSheet(context: context, builder:(context){
                                  return Container(

                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.topRight,
                                          colors: [
                                            Color(0xff04720e),
                                            Color(0xff1D7851),

                                          ],
                                        )
                                    ),
                                    height: 150,
                                    child:Center(
                                      child: Column(
                                        children: [
                                          SizedBox(height: 10,),
                                          Text("CHOOSE YOUR OPTION",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 30,color: Colors.white),),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                            IconButton(onPressed:() async{
                                              pick(ImageSource.camera);

                                            }, icon:Icon(Icons.camera,size: 60,color: Colors.white,)),
                                            SizedBox(
                                              width: 70,
                                            ),
                                            IconButton(onPressed:()=>  pick(ImageSource.gallery), icon:Icon(Icons.image,size: 60,color: Colors.white,)),
                                          ],),
                                          SizedBox(height: 20,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 40,
                                              ),
                                              Text("CAMERA",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              Text("GALLERY",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                                            ],),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                              },
                              child: Container(
                                height: 100,
                                width: 100,
                                child:pickedimage !=null ? Image.file(pickedimage!,fit: BoxFit.cover,) :Image.network(url,fit: BoxFit.cover,),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                ),
                              ),
                            )),
                          Text('UPLOAD YOUR IMAGE',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                          SizedBox(height: 20,),
                          builduser(),
                          SizedBox(height: 20,),
                          buildname(),
                          SizedBox(height: 20,),
                          buildEmail(),
                          SizedBox(height: 20,),
                          buildpass(),
                          SizedBox(height: 30,),
                          buildphone(),
                          SizedBox(height: 20,),
                          buildclgname(),
                          SizedBox(height: 20,),
                          buildpdf(),
                          SizedBox(height: 20,),
                          Visibility(
                            visible: _isstudent,
                              child: buildaddyear()),
                          SizedBox(height: 20,),
                          Visibility(
                            visible: _isalumini,
                              child: buildpassyear()),
                          SizedBox(height: 20,),
                          buildbtn(context),
                          SizedBox(height: 20,),
                          buildsignnbtn(context),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
  Widget buildname() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Name',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0,2),
                )

              ]
          ),
          height: 60,
          child: TextField(
            controller: namereg,
            keyboardType: TextInputType.name,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon:Icon(
                  CupertinoIcons.profile_circled,
                  color: Color(0xff1D7851),
                ),
                hintText: 'Name...',
                hintStyle: TextStyle(
                  color: Colors.black38,
                )
            ),
          ),
        )
      ],
    );
  }
  Widget builduser() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('User Type...',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0,2),
                ),
              ],
          ),
          height: 60,
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
                icon: const Icon(Icons.category,color: Color(0xff1D7851),),
    ),
            items: ['Student', 'Faculty', 'Alumini'].map((value) {
              // normal options

              if (value != 'Student') {
                return DropdownMenuItem<String>(
                  onTap: (){
                    setState(() {
                      if(_isstudent==true){
                        _isstudent=false;
                      }
                      _isalumini= true;
                    });

                  },
                  value: value,
                  child: new Text(value,
                      style: new TextStyle(color: Colors.black)),
                );
              }
              else if(value!='Faculty' ){
                return DropdownMenuItem<String>(
                  child: Text(value, style: TextStyle(color: Colors.black)),
                  onTap: (){
                    setState(() {
                      if(_isalumini==true){
                        _isalumini=false;
                      }
                      _isstudent =true;
                    });
                  },
                );
              }
              else{
                return DropdownMenuItem<String>(
                  child: Text(value, style: TextStyle(color: Colors.black)),
                  onTap: (){
                    setState(() {
                      if(_isalumini=true){
                        _isalumini=false;
                      }
                    });
                  },
                );

              }
            }).toList(), onChanged: (String? value) {

          },
          ),
        ),
      ],
    );
  }
  Widget buildclgname() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('College Name',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0,2),
                )

              ]
          ),
          height: 60,
          child: TextField(
            controller: clgnamereg,
            keyboardType: TextInputType.name,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon:Icon(
                  CupertinoIcons.building_2_fill,
                  color: Color(0xff1D7851),
                ),
                hintText: 'College Name...',
                hintStyle: TextStyle(
                  color: Colors.black38,
                )
            ),
          ),
        )
      ],
    );
  }
  Widget buildpdf() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () async{
            final item=await FilePicker.platform.pickFiles();
            if(item==null)return;
            print('Path: ${item.paths}');
            Fluttertoast.showToast(msg: "Uploaded Sucessfully..");
            
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xffb7e8bc),
                    Color(0xff2aa933),

                  ]
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0,2),
                  )

                ]
            ),
            height: 60,
            child: Text("UPLOAD YOUR RESUME",style: TextStyle(color: Colors.green[900],fontSize: 20,fontWeight: FontWeight.bold),),
          ),
        )
      ],
    );
  }
  Widget buildpassyear() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Passing Year',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0,2),
                )

              ]
          ),
          height: 60,
          child: TextField(
            controller: clgnamereg,
            keyboardType: TextInputType.name,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon:Icon(
                  CupertinoIcons.building_2_fill,
                  color: Color(0xff1D7851),
                ),
                hintText: 'Passing Year...',
                hintStyle: TextStyle(
                  color: Colors.black38,
                )
            ),
          ),
        )
      ],
    );
  }
  Widget buildaddyear() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Admission Year',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0,2),
                )

              ]
          ),
          height: 60,
          child: TextField(
            controller: clgnamereg,
            keyboardType: TextInputType.name,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon:Icon(
                  CupertinoIcons.building_2_fill,
                  color: Color(0xff1D7851),
                ),
                hintText: 'Admission Year...',
                hintStyle: TextStyle(
                  color: Colors.black38,
                )
            ),
          ),
        )
      ],
    );
  }
  Widget buildphone() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Phone Number',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0,2),
                )

              ]
          ),
          height: 60,
          child: TextField(
            controller: phonereg,
            keyboardType: TextInputType.phone,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon:Icon(
                  Icons.phone,
                  color: Color(0xff1D7851),
                ),
                hintText: 'Phone no...',
                hintStyle: TextStyle(
                  color: Colors.black38,
                )
            ),
          ),
        )
      ],
    );
  }
  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0,2),
                )

              ]
          ),
          height: 60,
          child: TextField(
            controller: emailreg,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon:Icon(
                  Icons.email,
                  color: Color(0xff1D7851),
                ),
                hintText: 'Email...',
                hintStyle: TextStyle(
                  color: Colors.black38,
                )
            ),
          ),
        )
      ],
    );
  }
  Widget buildpass() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Password',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0,2),
                )

              ]
          ),
          height: 60,
          child: TextField(
            controller: passreg,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon:Icon(
                  Icons.lock_person,
                  color: Color(0xff1D7851),
                ),
                hintText: 'Password...',
                hintStyle: TextStyle(
                  color: Colors.black38,
                )
            ),
          ),
        )
      ],
    );
  }
  buildbtn(BuildContext c){
    return InkWell(
      onTap:signin,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("R E G I S T E R",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
            Icon(CupertinoIcons.right_chevron,color: Colors.white,),
          ],
        ),
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xff4cef5a),
                  Color(0xff1b6221),
                ]
            )
        ),

        width: double.infinity,

      ),
    );
  }
  buildsignnbtn(BuildContext c){
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>login()));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Already have an Account?',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,

              ),
            ),
            TextSpan(
                text: ' LOG IN',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
            ),
          ],
        ),
      ),

    );
  }
  Future signin() async{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailreg.text.trim(),
        password: passreg.text.trim());

    Fluttertoast.showToast(msg: "Register Successfully");
    Phoenix.rebirth(context);

  }
  pick(ImageSource imgs) async{
    try{
      final pic=await ImagePicker().pickImage(source: imgs);
      if(pic==null) return;
      final tempimg=File(pic.path);
      setState(() {
        pickedimage=tempimg;
      });
    }catch(err){
      print(err);
    }
  }
}


