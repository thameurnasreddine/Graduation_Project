import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';

class otpN extends StatefulWidget {
  const otpN({super.key});

  @override
  State<otpN> createState() => _otpNState();
}

// ignore: camel_case_types
class _otpNState extends State<otpN> {
  final TextEditingController phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                      const Text('مرحبا ',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    ' أدخل لرقم هاتفك لتسجيل الدخول',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                        fontFamily: 'Cairo',

                    ),
                    textAlign: TextAlign.center,
                    
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                       Padding(
                         padding: const EdgeInsets.only(left: 15,right: 15),
                         child: TextField(
                          
                         
                          textDirection: TextDirection.ltr,
                            
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                            controller: phonecontroller,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 18),
                              suffixIcon: Row(
                                mainAxisSize:MainAxisSize.min ,
                                children: [
                                  // Container(
                                  //    decoration: BoxDecoration(border: Border(right: BorderSide(color: Colors.black,width: 1,)), ),
                                  // ),
                                 const Expanded(flex: 0, child: Text('│213+',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),)),

                                  Expanded(
                                    flex: 0,
                                    child: Align(
                                      widthFactor: 1,
                                      heightFactor: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left:4,),
                                        child: Container(
                                          margin: const  EdgeInsets.all(7),
                                          height: 25,
                                           child: Image.asset(
                                                                  'assets/images/dz.png',
                                                              
                                                                )
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                             
                              hintText: " ",
                              hintStyle: const TextStyle(color: Colors.black),
                         
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide:
                                     const BorderSide(color: Colors.black,width: 3),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:  BorderRadius.circular(18),
                                borderSide:
                                    const BorderSide(color: Colors.black,width: 3),
                              ),
                            )),
                       ),
                    
                  
                  const SizedBox(
                    height: 20,
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      // Use ElevatedButton instead of RaisedButton
                      // style: ButtonStyle(backgroundColor:Colors(0x000000),
                         style: ElevatedButton.styleFrom(backgroundColor: Colors.black ),
                      
                      onPressed: () {


                      SendPhoneNumber();

                      },
                     

                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 15,color: Colors.white),
                      ),
                      // style: const ButtonStyle(backgroundColor:),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
   void SendPhoneNumber(){
         final ap =Provider.of<AuthProvider>(context,listen :false)  ;
         
          String phoneNumber =phonecontroller.text.trim();

ap.signInWithPhone(context, "+213$phoneNumber");
        }
}
