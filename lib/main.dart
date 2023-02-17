import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:revamph/home.dart';
import 'package:revamph/login.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Phoenix(child:MyApp() ));
}


class MyApp extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          else if(snapshot.hasError){
            return Center(child: Text('Something Went Wrong...'),);
          }
          else if(snapshot.hasData){
            return home();
          }
          else{
            return login();
          }
        },
      ),
    );
  }

}
