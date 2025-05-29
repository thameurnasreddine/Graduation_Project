// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:madinati/provider/auth_provider.dart' as custom_auth;
import 'package:madinati/widjet/customdiaulogue.dart';

// ignore: must_be_immutable
class ReportP extends StatefulWidget {
  final String problmid;
  final String probmTitle;
 
   

  

  const ReportP({super.key, required this.problmid, required this.probmTitle});

  @override
  _ReportPState createState() => _ReportPState();
}

class _ReportPState extends State<ReportP> {
 String? dropdownvalue  ;  
    // ignore: prefer_typing_uninitialized_variables
    var detailscontroller;

  
  List<String> items = [];
  File? _image;
  final ImagePicker _picker = ImagePicker();
String? _currentLocation;

String? phoneNumber;
  bool _isLoading = false;


 Future<void> fetchPhoneNumber() async {
    final User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      phoneNumber = user?.phoneNumber;
    });
  }

Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showLocationErrorDialog(context, 'تم تعطيل خدمات الموقع الجغرافي');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showLocationErrorDialog(context, 'تم رفض أذونات الموقع');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showLocationErrorDialog(context,
          'يتم رفض أذونات الموقع بشكل دائم، ولا يمكننا طلب أذونات الموقع');
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentLocation =
          'Lat: ${position.latitude}, Lon: ${position.longitude}';
    });

    showLocationSuccessDialog(context, _currentLocation!);
  }

  @override
  void initState() {
    super.initState();
    fillItems(widget.problmid);
    detailscontroller = TextEditingController();
     fetchPhoneNumber();
  }

  void fillItems(String problmid) {
    setState(() {
      switch (problmid) {
        case '1':
          items = ['حفر وتشققات في الطريق', 'إشارات مرور مكسورة أو غير موجودة','غياب ممرات المشاة.','إضاءة الشوارع غير كافية أو معطلة','ازدحام مروري دائم أو غير مبرر','أخرى'];
          break;
        case '2':
          items = ['انقطاع متكرر للتيار الكهربائي.', 'أسلاك كهربائية مكشوفة أو خطرة.', 'محولات كهربائية تصدر أصواتاً أو حرارة زائدة.','إضاءة الشوارع المعطلة.','أخرى'];
          break;
        case '3':
          items = ['تراكم النفايات في الشوارع.', 'حاويات النفايات الممتلئة أو غير الكافية.', 'عدم الالتزام بجداول جمع النفايات.','انتشار الروائح الكريهة من مواقع النفايات.','أخرى'];
          break;
        case '4':
          items = ['انقطاع المياه بشكل متكرر.', 'تسربات المياه من الأنابيب.', 'انسداد شبكات الصرف الصحي.','تجمع المياه في الشوارع بعد الأمطار.','ضعف ضغط المياه في المنازل.','أخرى'];
          break;
        case '5':
          items = ['انتشار الكلاب الضالة التي تسبب تهديدًا للسكان', 'القطط الضالة التي تنبش في النفايات.', 'قوارض أو حيوانات أخرى تسبب إزعاجًا أو تنقل الأمراض.','عدم وجود مراكز إيواء للحيوانات الضالة.','أخرى'];
          break;
        case '6':
          items = ['ارتفاع معدلات السرقة أو الجريمة في المنطقة.', 'غياب دوريات الشرطة في الحي.', 'التسكع أو التجمعات غير القانونية في الأماكن العامة.','الاعتداءات الجسدية أو اللفظية المتكررة.','المناطق المظلمة وغير الآمنة ليلاً.','أخرى'];
          break;
        case '7':
          items = ['تدمير الحدائق أو المساحات الخضراء.', 'الكتابة على الجدران أو الغرافيتي.', 'تكسير أو إتلاف المقاعد العامة.','إتلاف الألعاب في ملاعب الأطفال.','أخرى'];
          break;
        case '8':
          items = ['أخرى'];
          break;
        default:
          items = ['Default Item 1', 'Default Item 2', 'Default Item 3'];
          break;
      }
    });
  }

   Future<void> _pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) {
      showCancelImageSelectionDialog(context);
      return;
    }
    setState(() {
      _image = File(pickedFile.path);
      showImageSelectedDialog(context, pickedFile.name);
    });
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      showCancelImageSelectionDialog(context);
      return;
    }
    setState(() {
      _image = File(pickedFile.path);
      showImageSelectedDialog(context, pickedFile.name);
    });
  }

 void showImageSelectedDialog(BuildContext context, String imageName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          title: 'تم اختيار الصورة',
          message: 'لقد قمت باختيار: $imageName',
          actionMessage: 'حسناً',
        );
      },
    );
  }

  void showCancelImageSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomDialog(
          title: 'تم إلغاء تحديد الصورة',
          message: 'لقد قمت بإلغاء تحديد الصورة.',
          actionMessage: 'حسناً',
        );
      },
    );
  }
void showThankYouDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomDialog(
          title: 'البيانات  تم إرسالها',
          message: 'شكراً لك على إرسالك!',
          actionMessage: 'حسناً',
        );
      },
    );
  }
  void showLocationSuccessDialog(BuildContext context, String location) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          title: 'الموقع المسترد',
          message: 'موقعك هو: $location',
          actionMessage: 'حسناً',
        );
      },
    );
  }

  void showLocationErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          title: 'خطأ في تحديد الموقع',
          message: errorMessage,
          actionMessage: 'حسناً',
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    // String valueChose;
    return Scaffold(
     resizeToAvoidBottomInset:false,
     
      appBar: AppBar(title: Text(widget.probmTitle, style: const TextStyle(color: Colors.white)), backgroundColor: Colors.black,
      automaticallyImplyLeading: false,
      actions: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Padding(
              padding: const EdgeInsets.only(left: 13, right:13),
              child: IconButton(
                icon: const Icon(Icons.arrow_back,color: Colors.white,),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
      
      body: SafeArea(
        
         child: Stack(
           children: [Center(
                   child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                
                const SizedBox(height: 10,),
            
                Container(alignment: Alignment.centerRight,margin: const EdgeInsets.only(right: 35,),child: const Text('حمل أو إلتقط صورة للمشكل   ', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),)), 
                
                Expanded(flex:1 ,child: Row( mainAxisAlignment: MainAxisAlignment.center,
                  children:[ Center(
                  child:IconButton(
                    color: Colors.black,
                    iconSize: 100,
                    icon: const Icon(Icons.camera_alt_rounded), onPressed: () {
                   _pickImageFromCamera();
                       
           
                    },
                    
                     
                  ),
                ),const SizedBox( width: 80,)
            ,Center(
              child: IconButton(
            color: Colors.black,
            iconSize: 100,
            icon: const Icon(Icons.image)
            , onPressed: () {_pickImageFromGallery();},
            
             
              )
            
             
              
            )] )  ),
                   
                const SizedBox(height: 40,),
                
                Container(alignment: Alignment.centerRight,margin: const EdgeInsets.only(right: 35,),child: const Text('حدد النطاق الجغرافي        ', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),),), 
               
                
                
                 Expanded(flex:0 ,child:  Padding(
                   padding: const EdgeInsets.only(left: 8,right: 8),
                   child: Container(
                    margin: const EdgeInsets.all(20),
                    width: double.infinity,
                    height: 45,
                     
                     child: ElevatedButton(
                            
                             style: ElevatedButton.styleFrom(backgroundColor: Colors.black ),
                   
                            onPressed: () {_getCurrentLocation();},
                   
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
                    child:  DropdownButton<String>(
                isExpanded: true,
                underline: const SizedBox(),
                hint: const Text(
                  'نوع المشكل           ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                value: dropdownvalue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue;
                  });
                },
              ),
                  ),
                ), 
                  
            
                const SizedBox(height: 20,),
            
                //  Container(alignment: Alignment.centerRight,margin: const EdgeInsets.only(right: 35,),child: const Text('ختر'),), 
           
                 Expanded(flex:3 ,child:  Container(
                margin:const EdgeInsets.symmetric(horizontal: 20),
                 child: TextField(
                  maxLines: 5,
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
                          
                          onPressed: _isLoading ? null : () { storeData(); },
           
                          child: const Text('إرسال',style: TextStyle(color: Colors.white),)
                       , 
                 ), ),
            
                 )
            
            
            
            
                
                
            
              ],
            ),

                   ),
                 ),
                 if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.black,),
                ),
              ),
                 ]
         ),
    
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    );
  }

void storeData() async {
 setState(() {
      _isLoading = true;
    });
 

 
  try {
    // ignore: unused_local_variable
    final ap = Provider.of<custom_auth.AuthProvider>(context, listen: false);

    // Check if all required data is available
    if (_image == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const CustomDialog(
            title: 'خطأ',
            message: 'الرجاء تحميل صورة.',
            actionMessage: 'حسناً',
          );
        },
      );
      setState(() {
          _isLoading = false;
        });
      return;
    }
    if (_currentLocation == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const CustomDialog(
            title: 'خطأ',
            message: 'يرجى تحديد موقعك.',
            actionMessage: 'حسناً',
          );
        },
      );
      setState(() {
          _isLoading = false;
        });
      return;
    }
    if (detailscontroller == null || detailscontroller.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const CustomDialog(
            title: 'خطأ',
            message: 'الرجاء إدخال التفاصيل.',
            actionMessage: 'حسناً',
          );
        },
      );
      setState(() {
          _isLoading = false;
        });
      return;
    }
    if (dropdownvalue == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const CustomDialog(
            title: 'خطأ',
            message: 'يرجى تحديد نوع المشكلة.',
            actionMessage: 'حسناً',
          );
        },
      );
      setState(() {
          _isLoading = false;
        });
      return;
    }

    // Upload image to Firebase Storage
    String imageUrl = await uploadImageToFirebase(_image!);

    // Store report data in Firestore
    await FirebaseFirestore.instance.collection('reports').add({
      'phoneNumber': phoneNumber,
      'probmTitle': widget.probmTitle,
      'problmid': widget.problmid,
      'image': imageUrl,
      'location': _currentLocation,
      'details': detailscontroller.text,
      'problemType': dropdownvalue,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Show a thank you dialog upon successful submission
    showThankYouDialog(context);
  } catch (e) {
    // Handle error
    // print('Error storing report data: $e');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomDialog(
          title: 'خطأ',
          message: 'حدث خطأ أثناء تخزين بيانات التقرير. يرجى المحاولة مرة أخرى.',
          actionMessage: 'حسناً',
        );
      },
    );
  } finally {
      setState(() {
        _isLoading = false;
      });
    }
}


Future<String> uploadImageToFirebase(File imageFile) async {
  try {
    // Create a reference to Firebase Storage
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child('images/$fileName');

    // Upload the image file to Firebase Storage
    UploadTask uploadTask = reference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;

    // Get the download URL of the uploaded image
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  } catch (e) {
    // ignore: avoid_print
    print('Error uploading image: $e');
    rethrow;
  }
}



}


