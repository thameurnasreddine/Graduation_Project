import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:madinati/utils/util.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:madinati/provider/auth_provider.dart';

import 'package:firebase_auth_platform_interface/src/auth_provider.dart' as firebase_auth;
import 'package:madinati/provider/auth_provider.dart' as custom_auth;



// import 'package:locale_emoji_flutter/locale_emoji_flutter.dart';

class otpNv extends StatefulWidget {
  final String verificationId;
  const otpNv({super.key, required this.verificationId});

  @override
  State<otpNv> createState() => _otpNvState();
}

class _otpNvState extends State<otpNv> {
  String? otpcode;
  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<custom_auth.AuthProvider>(context, listen: true).isLoading;


    final pinController = TextEditingController();
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
            ? const Center(child: CircularProgressIndicator())
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
                      const Text('مرحبا ',
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
                        ' أدخل لرقم هاتفك لتسجيل الدخول',
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
                        child: Container(
                          // margin: const EdgeInsets.all(20),
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Form(
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
                                onSubmitted: (value) {
                                  setState(() {
                                    otpcode = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(right: 40),
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'إرسال لرقم',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              )),
                          Container(
                            margin: const EdgeInsets.only(left: 60),
                            child: const Text(
                              'did not get the code',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ),
                          const Text(
                            'resend new code',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
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
                              ' الدخول',
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
                    ],
                  ),
                ),
              ),
      ),

      // ),
    );
  }

  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<custom_auth.AuthProvider>(context, listen: false);

   
    ap.verifyOtp(
      context,
     widget.verificationId,
       userOtp,
       () {
        
      },
    );
  }
}




/* 

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text('Pinput Example'),
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(30, 60, 87, 1),
          ),
        ),
        body: const FractionallySizedBox(
          widthFactor: 1,
          child: PinputExample(),
        ),
      ),
    ),
  );
}

/// This is the basic usage of Pinput
/// For more examples check out the demo directory
class PinputExample extends StatefulWidget {
  const PinputExample({Key? key}) : super(key: key);

  @override
  State<PinputExample> createState() => _PinputExampleState();
}

class _PinputExampleState extends State<PinputExample> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    /// Optionally you can use form to validate the Pinput
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Directionality(
            // Specify direction if desired
            textDirection: TextDirection.ltr,
            child: Pinput(
              controller: pinController,
              focusNode: focusNode,
              androidSmsAutofillMethod:
                  AndroidSmsAutofillMethod.smsUserConsentApi,
              listenForMultipleSmsOnAndroid: true,
              defaultPinTheme: defaultPinTheme,
              separatorBuilder: (index) => const SizedBox(width: 8),
              validator: (value) {
                return value == '2222' ? null : 'Pin is incorrect';
              },
              // onClipboardFound: (value) {
              //   debugPrint('onClipboardFound: $value');
              //   pinController.setText(value);
              // },
              hapticFeedbackType: HapticFeedbackType.lightImpact,
              onCompleted: (pin) {
                debugPrint('onCompleted: $pin');
              },
              onChanged: (value) {
                debugPrint('onChanged: $value');
              },
              cursor: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 9),
                    width: 22,
                    height: 1,
                    color: focusedBorderColor,
                  ),
                ],
              ),
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  color: fillColor,
                  borderRadius: BorderRadius.circular(19),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              errorPinTheme: defaultPinTheme.copyBorderWith(
                border: Border.all(color: Colors.redAccent),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              focusNode.unfocus();
              formKey.currentState!.validate();
            },
            child: const Text('Validate'),
          ),
        ],
      ),
    );
  }
}
  */


