import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:madinati/pages/otpN.dart';
 import 'package:madinati/provider/auth_provider.dart';
import 'package:madinati/pages/otpNv.dart';
import 'package:madinati/wlcom.dart';
import './pages/problmCat.dart'; 
// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:lottie/lottie.dart';
import './pages/legosplasch.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'provider/auth_provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  //  options: DefaultFirebaseOptions.currentPlatform
  options: const FirebaseOptions(
    apiKey: 'key',
    appId: 'id',
    messagingSenderId: 'sendid',
    projectId: 'myapp',
    storageBucket: 'myapp-b9yt18.appspot.com',
  )
);
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
       providers:[
          ChangeNotifierProvider(
         create :(_) =>AuthProvider())
        ],
      child: 
    MaterialApp(
      
        theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(color: Colors.black),
            labelStyle:
                TextStyle(color: Colors.black), // Change to your desired color
          ),
        ),
             localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar'),
        ],
           home: legoS(),
        //  initialRoute: '/splash', // Set the initial route to the splash screen
        // routes: {
        //   '/splash': (context) => const legoS(), // Splash screen route
        //   '/home': (context) => const problmCat(), // Home page route
        //  '/sig': (context) => const otpNv(),
        //   // Add other routes if needed
        // },
      ),
     );
  }
}
