import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/home_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final FirebaseAuth _auth=FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn=GoogleSignIn();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            User? user =await googleSignIn();
            if(user!=null){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const HomePage()));
            }else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sign In failed")));
            }
          },
          child: const Text("Sign in with google"),
        ),
      ),
    );
  }

  Future<User?> googleSignIn() async {
    try{
      GoogleSignInAccount? googleSignInAccount=await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication=await googleSignInAccount!.authentication;
      AuthCredential authCredential=GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      UserCredential userCredential=await _auth.signInWithCredential(authCredential);
      User? user=userCredential.user;
      return user;
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sign In failed ${e.toString()}")));
    }
    return null;
  }
}
