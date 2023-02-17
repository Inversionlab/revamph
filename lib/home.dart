import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class home extends StatelessWidget {

  final user=FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network("https://assets10.lottiefiles.com/packages/lf20_pghdouhq.json"),
            Text("HEY THERE..",style: TextStyle(fontSize: 30),),
            Text(user.email!,style: TextStyle(fontSize: 30),),
            SizedBox(height: 20,),
            FloatingActionButton.extended(onPressed:(){
              FirebaseAuth.instance.signOut();
            }, label: Text("SIGN OUT"),icon:Icon(Icons.login),)
          ],
        ),
      ),
    );
  }
}
