
import 'package:flutter/material.dart';
import 'package:madinati/pages/otpN.dart';
import 'package:madinati/pages/otpNv.dart';
import 'package:madinati/pages/problmCat.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthProvider ap = Provider.of<AuthProvider>(context);

    return Scaffold(
      
          
            // Check the sign-in state after checkSignIn has completed
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  if (ap.isSignedIn) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => problmCat()),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => otpN()),
                    );
                  }
                },
                child: const Text('اضغط هنا'),
              ),
            )
          
        
      
    );
  }
}