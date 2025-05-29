import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; 
import 'package:madinati/provider/auth_provider.dart';
import './pages/legosplasch.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);


  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
       providers:[
          ChangeNotifierProvider(
         create :(_) =>AuthProvider())
        ],
      child: 
    MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(color: Colors.black),
            labelStyle:
                TextStyle(color: Colors.black), 
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
           home: const legoS(),
        
      ),
     );
  }
}
