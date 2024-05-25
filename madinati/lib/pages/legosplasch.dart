

import 'package:flutter/material.dart';
import 'package:madinati/pages/otpN.dart';
import 'package:madinati/pages/problmCat.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';

// ignore: camel_case_types
class legoS extends StatefulWidget {
  const legoS({super.key});

  @override
  
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
       await Future.delayed( const Duration(seconds: 8));
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
       await authProvider.checkSignIn();
      _navigateBasedOnAuthState(authProvider.isSignedIn);
    });
  }

  void _navigateBasedOnAuthState(bool isSignedIn) {
    if (isSignedIn) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => problmCat()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => otpN()),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/Lottie/myCity.json'),
      ),
      // backgroundColor: Colors.white,
    );
  }
}
