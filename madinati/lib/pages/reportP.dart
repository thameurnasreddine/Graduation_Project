import 'package:flutter/material.dart';

class ReportP extends StatefulWidget {
  final String problmid;
  final String probmTitle;
  final String file;
  final String localisation;
   String type;
  
  final String details;

  

  ReportP({Key? key, required this.problmid, required this.probmTitle, required this.file, required this.localisation, required this.type, required this.details}) : super(key: key);

  @override
  _ReportPState createState() => _ReportPState();
}

class _ReportPState extends State<ReportP> {
 String? dropdownvalue  ;  
    var detailscontroller;

  
  // List of items in our dropdown menu 
  var items = [     
    'Item 1', 
    'Item 2', 
    'Item 3', 
    'Item 4', 
    'Item 5', 
  ];
  @override
  Widget build(BuildContext context) {
    // String valueChose;
    return Scaffold(
     
      appBar: AppBar(title: Text(widget.probmTitle, style: const TextStyle(color: Colors.white)), backgroundColor: Colors.black,),
      body: SafeArea(
        // Your code here
         child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              
              const SizedBox(height: 10,),
          
              Container(alignment: Alignment.centerRight,margin: const EdgeInsets.only(right: 35,),child: const Text('إختر '),), 
              
              Expanded(flex:1 ,child: Row( mainAxisAlignment: MainAxisAlignment.center,
                children:[ Center(
                child: IconButton(
                  color: Colors.black,
                  iconSize: 100,
                  icon: const Icon(Icons.camera_alt_rounded), onPressed: () {

                     

                  },
                  
                   
                ),
              ),const SizedBox( width: 80,)
          ,Center(
            child: IconButton(
          color: Colors.black,
          iconSize: 100,
          icon: Icon(Icons.image)
          , onPressed: () {},
          
           
            ),
          )] )  ),
          
              const SizedBox(height: 40,),
              
              Container(alignment: Alignment.centerRight,margin: const EdgeInsets.only(right: 35,),child: const Text('إختر '),), 
             
              
              
               Expanded(flex:0 ,child:  Padding(
                 padding: const EdgeInsets.only(left: 8,right: 8),
                 child: Container(
                  margin: const EdgeInsets.all(20),
                  width: double.infinity,
                  height: 45,
                   
                   child: ElevatedButton(
                          
                           style: ElevatedButton.styleFrom(backgroundColor: Colors.black ),
                 
                          onPressed: () {},
                 
                          child: const Icon(Icons.location_on,color: Colors.white,))
                       , 
                 ),
               ),),
          
              const SizedBox(height: 20,),
          
              // Container(alignment: Alignment.centerRight,margin: const EdgeInsets.only(right: 35,),child: const Text('إختر'),), 

          
               
               Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(left: 15,right: 15),
                  decoration:  BoxDecoration(
                   border: Border.all(color: Colors.black,width: 3.5) ,
                  borderRadius:BorderRadius.circular(12),
                  ),
                  child: DropdownButton( 
                    isExpanded: true,
                    underline:const SizedBox(),
                    hint: const Text('إختر          ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,),textAlign: TextAlign.center,),
                   
                  value: dropdownvalue,  
                  icon: const Icon(Icons.keyboard_arrow_down),     
                  items: items.map((String items) { 
                    return DropdownMenuItem( 
                      value: items,
                  
                      child: Text(items), 
                    ); 
                  }).toList(), 
                  
                  onChanged: (String? newValue) {  
                    setState(() { 
                      dropdownvalue = newValue!; 
                    }); 
                  }, 
                              ),
                ),
              ), 
                
          
              const SizedBox(height: 20,),
          
              //  Container(alignment: Alignment.centerRight,margin: const EdgeInsets.only(right: 35,),child: const Text('ختر'),), 

               Expanded(flex:2 ,child:  Container(
              margin:const EdgeInsets.symmetric(horizontal: 20),
               child: TextField(
                maxLines: 4,
                  style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          controller: detailscontroller,
                          decoration: InputDecoration(
                            // errorMaxLines: 10,
                            hintText: " التفاصيل",
                            //labelText: 'your phone',
                            hintStyle: const TextStyle(color: Colors.black),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black, width: 3.5,),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black,width: 3.5,),
                            ),
                          )
               ),
               ),

                ),
          
              const SizedBox(height: 20,),  
          
               Expanded(flex:0 ,child:  Container(
                margin: const EdgeInsets.all(20),
                width: double.infinity,
                height: 45,
                 
                 child: ElevatedButton(
                        
                         style: ElevatedButton.styleFrom(backgroundColor: Colors.black ),
                        
                        onPressed: () {},

                        child: const Text('send',style: TextStyle(color: Colors.white),)
                     , 
               ), ),
          
               )
          
          
          
          
              
              
          
            ],
          ),
        ),
      ),
    
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
    );
  }
}
















