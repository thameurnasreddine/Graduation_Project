

// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:madinati/pages/otpn.dart';
import 'package:madinati/pages/problmCat.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';

class legoS extends StatefulWidget {
  const legoS({super.key});

  @override
  
  // ignore: library_private_types_in_public_api
  _legoSState createState() => _legoSState();
}


class _legoSState extends State<legoS> {
  @override
   void initState() {
    super.initState();
   _checkSignInAndNavigate();
  }

  void _checkSignInAndNavigate() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
       await Future.delayed( const Duration(seconds: 9));
      // ignore: use_build_context_synchronously
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
       await authProvider.checkSignIn();
      _navigateBasedOnAuthState(authProvider.isSignedIn);
    });
  }

  // void _navigateBasedOnAuthState(bool isSignedIn) {
  //   if (isSignedIn == true) {
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (context) => const problmCat()),
  //          (route) => false,
  //     );
  //   } else {
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (context) => const otpN()),
  //          (route) => false,
  //     );
  //   }
  // }

  void _navigateBasedOnAuthState(bool isSignedIn) {
  if (isSignedIn) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const problmCat()),
      (route) => false,
    );
  } else {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const otpN()),
      (route) => false,
    );
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/Lottie/myCity.json'),
      ),
      backgroundColor: Colors.white,
    );
  }
}
