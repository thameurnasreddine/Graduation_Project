import 'package:flutter/material.dart';
import '../pages/reportP.dart';

// ignore: camel_case_types
class catitemp extends StatelessWidget {
  final String imagename;
  final String title;
  // ignore: non_constant_identifier_names
  final String Catproblmid;

  const catitemp(
      {super.key,
      required this.imagename,
      required this.title,
      required this.Catproblmid});

  void selectproblem(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (c) => ReportP(problmid: Catproblmid, probmTitle: title, file: '', localisation: '', details: '', type: '',),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        selectproblem(context);
      },
      splashColor: Colors.white,
      borderRadius: BorderRadius.circular(7),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Image.asset(imagename, height: 300, fit: BoxFit.cover),
          ),
          Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                // color: Colors.black.withOpacity(0.400),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 18,fontFamily: 'Cairo',fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
