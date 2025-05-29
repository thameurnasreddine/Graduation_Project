// ignore_for_file: camel_case_types

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:madinati/pages/problmCat.dart';
import 'package:madinati/utils/util.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:madinati/provider/auth_provider.dart' as custom_auth;



// import 'package:locale_emoji_flutter/locale_emoji_flutter.dart';

class otpNv extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const otpNv({super.key, required this.verificationId, required this.phoneNumber});

  @override
  State<otpNv> createState() => _otpNvState();
}

class _otpNvState extends State<otpNv> {

   String? otpcode;
  late TextEditingController pinController;
  Timer? _resendTimer;
  bool _isResendEnabled = false; 

  @override
  void initState() {
    super.initState();
    pinController = TextEditingController();
    startResendTimer();
  }

  @override
  void dispose() {
    pinController.dispose();
    _resendTimer?.cancel();
    super.dispose();
  }

  void startResendTimer() {
    setState(() {
      _isResendEnabled = false;
    });
    _resendTimer = Timer(const Duration(seconds: 60), () {
      setState(() {
        _isResendEnabled = true;
      });
    });
  }

  void resendCode() {
    final ap = Provider.of<custom_auth.AuthProvider>(context, listen: false);
    ap.signInWithPhone(context, widget.phoneNumber); // Resend the code with the phone number
    startResendTimer();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<custom_auth.AuthProvider>(context, listen: true).isLoading;


    // final pinController = TextEditingController();
    const focusedBorderColor = Colors.black87;
    const borderColor = Colors.black;

    final defaultPintheme = PinTheme(
      height: 40,
      width: 40,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(3),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
    );
    


    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? const Center(child: CircularProgressIndicator(color: Colors.black,))
            : Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 35),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      const Text('التحقق',
                          style: TextStyle(
                            fontSize: 34,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          )),
                      const SizedBox(
                        height: 35,
                      ),
                      const Text(
                       'أدخل كود التحقق لتسجيل الدخول',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Cairo',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          
                            child: Pinput(
                              androidSmsAutofillMethod:
                                  AndroidSmsAutofillMethod.none,
                              controller: pinController,
                              length: 6,
                              defaultPinTheme: defaultPintheme.copyWith(
                                decoration:
                                    defaultPintheme.decoration!.copyWith(
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(
                                      color: focusedBorderColor, width: 1.9),
                                ),
                              ),
                              focusedPinTheme: defaultPintheme.copyWith(
                                decoration:
                                    defaultPintheme.decoration!.copyWith(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: focusedBorderColor, width: 2.6),
                                ),
                              ),
                               onChanged: (pin) => debugPrint(pin),
                              onCompleted: (value) {
                                setState(() {
                                  otpcode = value;
                                  
                                });
                              },
                            ),
                          
                        ),
                      ),
                   
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (otpcode != null) {
                                verifyOtp(context, otpcode!);
                              } else {
                                ShowSnackBar(context, "Enter 6-Digit code");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black),
                            child: const Text(
                              'تأكيد',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ),
                        ),
                      ),

                      Container(
                              margin: const EdgeInsets.only(right: 40),
                              child: Center(
                                child: TextButton(
                                   onPressed: _isResendEnabled
                                ? () {
                                    resendCode(); // Trigger the resend function
                                  }
                                : null,
                            // child: Text(
                            //   _isResendEnabled ? 'resend new code' : 'wait for 60 seconds',
                              
                            // ),
                                  
                                
                                  
                                  child: const  Text(
                                    'إرسال الرمز مجددا       ',
                                    style: TextStyle(
                                fontSize: 11,
                                color:  Colors.black,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Cairo',
                              ),
                                  ),
                                ),
                              )),

                              Container(
                              margin: const EdgeInsets.only(right: 40),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                            'تغير رقم الهاتف         '  ,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              )),
                    ],
                  ),
                ),
              ),
      ),

      
    );
  }

  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<custom_auth.AuthProvider>(context, listen: false);

   
    ap.verifyOtp(
      context,
     widget.verificationId,
       userOtp,
       
       () {
        ap.checkExistingUser().then((value) async {
         if(value == true){
           
         }
         else {
         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const problmCat()), (route) => false);
         }
        });

      },
    );
  }
}




