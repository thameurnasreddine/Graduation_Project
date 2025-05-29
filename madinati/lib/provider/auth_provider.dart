
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:madinati/pages/otpnv.dart';
import 'package:madinati/pages/problmcat.dart';

import 'package:madinati/utils/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';


class AuthProvider extends ChangeNotifier{


  bool _isSignedIn=false;
 bool get isSignedIn => _isSignedIn;

 bool _isLoading= false ;
 bool get isLoading => _isLoading;
String? _uid;
String get uid => _uid!;
  final FirebaseAuth _firebaseAuth =FirebaseAuth.instance;
  final FirebaseFirestore  _firebaseFireStore =FirebaseFirestore.instance;

   AuthProvider(){
     checkSignIn();
   }
  
 Future <void> checkSignIn() async{
      final SharedPreferences s = await SharedPreferences.getInstance();
     _isSignedIn = s.getBool("is_signedin") ?? false;
    notifyListeners();
  }


           
void signInWithPhone( BuildContext context, String phoneNumber) async{
   _isLoading = true;
    notifyListeners();
    String fullPhoneNumber = "+213$phoneNumber";
  try {
await _firebaseAuth.verifyPhoneNumber(phoneNumber: phoneNumber
  ,verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {

await  _firebaseAuth.signInWithCredential(phoneAuthCredential);
          _uid = _firebaseAuth.currentUser?.uid;
          await _saveSignIn();
          // ignore: use_build_context_synchronously
          _navigateToHome(context);
}, 
verificationFailed: (error){

  throw  Exception(error.message);

},
 codeSent: (verificationId,forceResendingToken){
  _isLoading = false;
          notifyListeners();
Navigator.push(context, MaterialPageRoute(builder: (context)=>otpNv(verificationId: verificationId,phoneNumber: fullPhoneNumber,)));
 },
  
  codeAutoRetrievalTimeout: (verificationId){});

  } on FirebaseAuthException catch(e){
     _isLoading = false;
      notifyListeners();
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
// ignore: unnecessary_null_comparison
if (user != null){
  _uid=user.uid;
onSuccess();
await _saveSignIn();
        // ignore: use_build_context_synchronously
        _navigateToHome(context);
}
_isLoading=false;
notifyListeners();
} on FirebaseAuthException catch(e){
  // ignore: use_build_context_synchronously
  ShowSnackBar(context, e.message.toString());
  _isLoading=false;
notifyListeners();
}
}
 Future<void> _saveSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
  }

  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const problmCat()));
  }

// data base                 
Future <bool> checkExistingUser() async{
 DocumentSnapshot snapshot = await _firebaseFireStore.collection("users").doc(_uid).get();
 if (snapshot.exists) {
    // ignore: unused_local_variable
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return true;
  } else {
    return false;

  }




}







  Future<void> storeReportData({
    required String phoneNumber,
    required String probmTitle,
    required String problmid,
    required File? image,
    required String? location,
    required String details,
    required String? problemType,
  }) async {
    try {
      // Implement the logic to store data, for example, uploading the image, storing other data in the database, etc.
      // Here is a simplified example using Firebase Firestore:
      Map<String, dynamic> reportData = {
        'phoneNumber': phoneNumber,
        'probmTitle': probmTitle,
        'problmid': problmid,
        'location': location,
        'details': details,
        'problemType': problemType,
        'timestamp': FieldValue.serverTimestamp(),
      };

      if (image != null) {
        // Upload image to Firebase Storage and get the download URL
        String imagePath = 'reports/${problmid}_${DateTime.now().millisecondsSinceEpoch}.jpg';
        TaskSnapshot uploadTask = await FirebaseStorage.instance
            .ref()
            .child(imagePath)
            .putFile(image);

        String imageUrl = await uploadTask.ref.getDownloadURL();
        reportData['imageUrl'] = imageUrl;
      }

      // Store report data in Firestore
      await FirebaseFirestore.instance.collection('reports').add(reportData);
    } catch (e) {
      throw Exception('Failed to store report data: $e');
    }
  }



  }


