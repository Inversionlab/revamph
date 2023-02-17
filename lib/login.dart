import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:revamph/register.dart';

class login extends StatefulWidget {

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final emailcontroller=TextEditingController();
  final passcontroller=TextEditingController();

  @override
  void dispose(){
    emailcontroller.dispose();
    passcontroller.dispose();
    super.dispose();
  }

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

                          Text('L O G  I N ',style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold
                          ),
                          ),
                          SizedBox(height: 50,),
                          buildEmail(),
                          SizedBox(height: 20,),
                          buildpass(),
                          SizedBox(height: 30,),
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


          )
      ),
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
            controller: emailcontroller,
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
            controller: passcontroller,
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
      onTap: signin,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("L O G  I N",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
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
                  Color(0xffecf1ed),
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
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>register()));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account?',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,

              ),
            ),
            TextSpan(
                text: ' REGISTER',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,

                )
            )
          ],
        ),
      ),

    );
  }
  Future signin() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passcontroller.text.trim());
    Phoenix.rebirth(context);
  }
}


