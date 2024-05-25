import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:madinati/modals/catP.dart';
import '../widjet/data/dataofwid.dart';
import '../widjet/cat_itemP.dart';

// ignore: camel_case_types
class problmCat extends StatelessWidget {
  const problmCat({super.key});

  @override
  Widget build(BuildContext context) {
    return

        

        Scaffold(
          
      appBar: AppBar(
        
        centerTitle: true,
        scrolledUnderElevation:0.00,
        title: const Text(
          'حدد المشكل',
          style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold,color: Colors.black),
        ),backgroundColor: Colors.white,

        
      ),
      body: SafeArea(
        child: Column(
          
          children: [
           
                // Container(margin: EdgeInsets.all(5),alignment: Alignment.center,child: const Text('file ',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),), 
        
            
            Expanded(
              flex: 9,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                child: GridView(
                  // shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 7 / 8,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                  ),
                  children: problmCat_data
                      .map((catP) => catitemp(
                          imagename: catP.imageName,
                          title: catP.title,
                          Catproblmid: catP.id))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,

    );
  }
}
