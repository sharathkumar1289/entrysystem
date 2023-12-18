import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
// Google Sign In
 Future<int> signInWithGoogle() async {
// begin interactive sign in process
  final GoogleSignInAccount? gUser = await GoogleSignIn(clientId: "460371142049-u85k88kmf0v2me3gfm27bqq3bteikm5o.apps.googleusercontent.com").signIn();
// obtaiin auth details from request
  final GoogleSignInAuthentication gAuth = await gUser!.authentication;
// create a new credential for user
  final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken, idToken: gAuth. idToken,);

  UserCredential user =   await FirebaseAuth.instance.signInWithCredential(credential);

    if(!user.user!.email.toString().contains("@vnrvjiet.in")){
      // print("Logged Out");
      // FirebaseAuth.instance.signOut();
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setInt('lType', 3);
      await prefs.setString('rollNumber',FirebaseAuth.instance.currentUser!.email.toString().replaceAll("@vnrvjiet.in", "").toLowerCase());
      await prefs.setString('mailId', FirebaseAuth.instance.currentUser!.email.toString());

      return 2;
    }
   final SharedPreferences prefs = await SharedPreferences.getInstance();

// Save an integer value to 'counter' key.
   await prefs.setInt('lType', 1);
   await prefs.setString('rollNumber',FirebaseAuth.instance.currentUser!.email.toString().replaceAll("@vnrvjiet.in", "").toLowerCase());

   await prefs.setString('mailId', FirebaseAuth.instance.currentUser!.email.toString());
   await prefs.setString('clgName', "VNR VJIET");
    return 1;
}

}