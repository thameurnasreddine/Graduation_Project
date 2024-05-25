
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:madinati/pages/otpNv.dart';
import 'package:madinati/utils/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier{


  bool _isSignedIn=false;
 bool get isSignedIn => _isSignedIn;

 bool _isLoading=true;
 bool get isLoading => _isLoading;
String? _uid;
String get uid => _uid!;
  final FirebaseAuth _firebaseAuth =FirebaseAuth.instance;
   AuthProvider(){
     checkSignIn();
   }
  
 Future <void> checkSignIn() async{
      final SharedPreferences s = await SharedPreferences.getInstance();
     _isSignedIn = s.getBool("is_signedin") ?? false;
    notifyListeners();
  }


           
void signInWithPhone( BuildContext context, String phoneNumber) async{
  try {
await _firebaseAuth.verifyPhoneNumber(phoneNumber: phoneNumber
  ,verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {

await  _firebaseAuth.signInWithCredential(phoneAuthCredential);

}, 
verificationFailed: (error){

  throw  Exception(error.message);

},
 codeSent: (verificationId,forceResendingToken){
Navigator.push(context, MaterialPageRoute(builder: (context)=>otpNv(verificationId: verificationId)));
 },
  
  codeAutoRetrievalTimeout: (verificationId){});

  } on FirebaseAuthException catch(e){
     // ignore: use_build_context_synchronously
     ShowSnackBar(context,e.message.toString());
  }



}


void verifyOtp(
  
 BuildContext context,
 String verificationId,
 String userOtp,
 Function onSuccess,
  
) async{
_isLoading = true;
notifyListeners();
try {
PhoneAuthCredential creds =  PhoneAuthProvider.credential(verificationId:verificationId,smsCode :userOtp);
 User? user =( await _firebaseAuth.signInWithCredential(creds)).user!;
if (user != null){
  _uid=user.uid;
onSuccess();

}
_isLoading=false;
notifyListeners();
} on FirebaseAuthException catch(e){
  ShowSnackBar(context, e.message.toString());
  _isLoading=false;
notifyListeners();
}
}

  }
