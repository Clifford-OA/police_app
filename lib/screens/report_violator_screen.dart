// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'dart:io' as io;
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:police_app/auth/police.dart';
import 'package:police_app/utils/send_email.dart';
import 'package:police_app/widgets/rounded_button.dart';
import 'package:uuid/uuid.dart';
import 'package:police_app/auth/auth.dart';
import 'package:police_app/screens/history_screen.dart';
import 'package:police_app/utils/get_image.dart';
import 'package:police_app/utils/validation.dart';
import 'package:police_app/utils/vehicleTextBox.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class ReportViolatorScreen extends StatefulWidget {
  io.File? videoFile;
  String name;
  ReportViolatorScreen({Key? key,required this.name, required this.videoFile}) : super(key: key);

  @override
  _ReportViolatorScreenState createState() => _ReportViolatorScreenState();
}

class _ReportViolatorScreenState extends State<ReportViolatorScreen> {
  CollectionReference fineList =
      FirebaseFirestore.instance.collection('fineList');
  final GlobalKey<FormState> _vehicleNumberFormKey = GlobalKey();
  final TextEditingController _vehicleNumber = TextEditingController();
  final TextEditingController _vehicleRegion = TextEditingController();
  final TextEditingController _vehicleYear = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  late VideoPlayerController? _videoController;

  late String _vehicleNumberText;
  late io.File imageFile;
  // io.File? videoFile;
  var vehicleYearInputFormatter = [
    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
    FilteringTextInputFormatter.deny(RegExp('[]'))
  ];
  var vehicleRegionInputFormatter = [
    FilteringTextInputFormatter.allow(RegExp('[A-Z]')),
  ];

  var vehicleNumberInputFormatter = [
    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
  ];

  bool _isLoading = false;
  String imgUrl = '';
  String videoUrl = '';

  late String path;

  final GetImage _getImgRef = GetImage();
  String fineCode = '';
  String selectedAmount = '0';
  String selectedFineTitle = 'select title';

  List<String> fineTitle = ['select title'];
  List<dynamic> fineInfo = [];

  @override
  void initState() {
    final policeClass = Provider.of<Police>(context, listen: false);
    fineInfo = policeClass.fineInfo;
    for (var fine in fineInfo) {
      {fineTitle.add(fine['title']);}
    }
    print(DateTime.now());
    setState(() {
      _vehicleRegion.clear();
      _vehicleNumber.clear();
      _vehicleYear.clear();
      _description.clear();
    });

    _videoController = VideoPlayerController.file(widget.videoFile!)
      ..initialize().then((_) {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _videoController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chewieController = ChewieController(
      videoPlayerController: _videoController!,
      aspectRatio: 1,
      // aspectRatio: 2.8 / 1.5,
      autoPlay: false,
      looping: true,
    );
    return Scaffold(
        appBar: AppBar(
          title: const Text('Report Violator'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 230,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                  // image: DecorationImage(
                  //   fit: BoxFit.cover,
                  //   colorFilter:
                  //       ColorFilter.mode(Colors.black26, BlendMode.darken),
                  //   image: AssetImage('assets/police.png'),
                  // ),
                  color: Color.fromARGB(255, 98, 118, 134),
                ),
                child: AspectRatio(
                    aspectRatio: _videoController!.value.aspectRatio,
                    child: Chewie(
                      controller: chewieController,
                    )),
                //  Image.file(
                //     imageFile,
                //     fit: BoxFit.cover,
                //   )
              ),
              Form(
                  key: _vehicleNumberFormKey,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: SizedBox(
                                width: 100.0,
                                child: vehiclenumberformtextBox(
                                  Validation().regionValidation,
                                  null,
                                  TextInputType.text,
                                  _vehicleRegion,
                                  'Region\nCode',
                                  'AS',
                                  2,
                                  vehicleRegionInputFormatter,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                              child: SizedBox(
                                width: 115.0,
                                child: vehiclenumberformtextBox(
                                  Validation().vehicleNumberValidation,
                                  null,
                                  TextInputType.number,
                                  _vehicleNumber,
                                  'Number',
                                  '1234',
                                  4,
                                  vehicleNumberInputFormatter,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: SizedBox(
                                width: 100.0,
                                child: vehiclenumberformtextBox(
                                  Validation().yearValidation,
                                  null,
                                  TextInputType.number,
                                  _vehicleYear,
                                  'Year',
                                  '22',
                                  2,
                                  vehicleYearInputFormatter,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      //   child: TextFormField(
                      //     validator: Validation().momoValidation,
                      //     inputFormatters: vehicleNumberInputFormatter,
                      //     keyboardType: TextInputType.number,
                      //     controller: _momoNumberController,
                      //     decoration: const InputDecoration(
                      //       filled: true,
                      //       border: OutlineInputBorder(),
                      //       hintText: 'Momo number',
                      //     ),
                      //     // maxLines: 3,
                      //   ),
                      // ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: TextFormField(
                          validator: Validation().locationValidation,
                          controller: _locationController,
                          decoration: const InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(),
                            hintText: 'Location',
                          ),
                          // maxLines: 3,
                        ),
                      ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // Container(
                      //   width: MediaQuery.of(context).size.width - 50,
                      //   child: DropdownButton(
                      //     value: selectedAmount,
                      //     items: _fineAmounts.map((String workingDay) {
                      //       return DropdownMenuItem(
                      //         value: workingDay,
                      //         child: Text(workingDay),
                      //       );
                      //     }).toList(),
                      //     hint: Text('Choose amount'),
                      //     dropdownColor: Colors.white,
                      //     icon: Icon(Icons.arrow_drop_down),
                      //     iconSize: 25,
                      //     isExpanded: true,
                      //     style: TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 22,
                      //     ),
                      //     onChanged: (String? newValue) {
                      //       setState(() {
                      //         selectedAmount = newValue!;
                      //       });
                      //     },
                      //   ),
                      // ),

                      const SizedBox(
                        height: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Title(
                            color: Colors.black,
                            child: const Text(
                              'Title of fine',
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 50,
                            child: DropdownButton(
                              value: selectedFineTitle,
                              items: fineTitle.map((String title) {
                                return DropdownMenuItem(
                                  value: title,
                                  child: Text(title,
                                      style: const TextStyle(fontSize: 17)),
                                );
                              }).toList(),
                              hint: const Text('Choose title'),
                              dropdownColor: Colors.white,
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 25,
                              isExpanded: true,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedFineTitle = newValue!;
                                });
                                for (var i in fineInfo) {
                                  if (i['title'] == newValue!) {
                                    selectedAmount = i['charge'];
                                    fineCode = i['fine_code'];
                                    break;
                                  }
                                  selectedAmount = '0';
                                }
                                // fineInfo.map((data) => {

                                // });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Title(
                                color: Colors.blue,
                                child: const Text(
                                  'Fine Amount',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.blueGrey),
                                )),
                            ListTile(
                              leading: Text(
                                'Ghc $selectedAmount',
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.orangeAccent),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: _isLoading == false
                            ? RoundedButton(
                                buttonName: 'Report',
                                action: _validateAndBook,
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }

  // Future _getImageNew() async {
  //   final policeEvidence = Provider.of<PoliceEvidence>(context, listen: false);
  //   String path = policeEvidence.referencePath;
  //   if (path.contains('.mp4')) {
  //     io.File c = io.File(path);
  //     setState(() {});
  //   } else {
  //     print('its a video');
  //   }
  // }


  Future<void> _validateAndBook() async {

    if (_vehicleNumberFormKey.currentState!.validate()) {
      _vehicleNumberText =
          '${_vehicleRegion.text}-${_vehicleNumber.text}-${_vehicleYear.text}';
      final errorResult = _validate();
      if (errorResult['status']) {
        setState(() {
          _isLoading = true;
        });
            videoUrl = await _getImgRef.uploadVideo(widget.videoFile!, widget.name);
        _addToFineList();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorResult['message'])));
      }
    }
  }

  Future<void> _addToFineList() async {
    var uuid = const Uuid();

    // List fineItem = [];
    String vehiNumber = _vehicleNumberText;
    final docId = uuid.v4().split('-')[0];
    CollectionReference civilian =
        FirebaseFirestore.instance.collection('civilian');
    late Map<String, dynamic> violatorData;

    await civilian.get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        List<dynamic> vehicles = data['vehicles'];
        for (var i = 0; i < vehicles.length; i++) {
          if (vehicles[i] == vehiNumber) {
            violatorData = data;
            break;
          }
        }
      }
    });

    // fineItem.add(toMap(docId));
    await fineList.doc(docId).set(toMap(docId, violatorData)).then((value) {
      print('Fine created');
      setState(() {
        _isLoading = false;
      });
      SendEmailClass().sendSms(
          phone: violatorData['phone'],
          toEmail: violatorData['email'],
          description: selectedFineTitle,
          fineAmount: selectedAmount,
          fineId: docId,
          location: _locationController.text,
          vehicleNum: _vehicleNumberText);
      // print(violatorData);
      // SendEmailClass().sendMail(
      //     context: context,
      //     toEmail: violatorData['email'],
      //     description: selectedFineTitle,
      //     fineAmount: selectedAmount,
      //     fineId: docId,
      //     toName: violatorData['name']);
      // _addToBookDateList();
      // SendEmailClass().sendEmail(
      //     toEmail: violatorData['email'],
      //     description: _description.text,
      //     fineAmount: selectedAmount,
      //     toName: violatorData['name']);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HistoryLogScreen()));
    }).catchError((error) {
      print("Failed to create fine: $error");
    });
  }

  Map<String, dynamic> toMap(String fineId, violatorDetail) {
    final authClass = Provider.of<AuthClass>(context, listen: false);
    final tid = authClass.auth.currentUser!.uid;

    return {
      'vehicleNumber': _vehicleNumberText,
      'amount': selectedAmount,
      'description': selectedFineTitle,
      'fine_code': fineCode,
      'evidenceUrl': videoUrl,
      'challenge_fine': false,
      'fineId': fineId,
      'location': _locationController.text,
      'fine_date': DateTime.now(),
      'paid_date': '',
      'violator_email': violatorDetail['email'],
      'violator_name': violatorDetail['name'],
      'violator_tel': violatorDetail['phone'],
      'status': false,
      'tid': tid,
    };
  }

  _validate() {
    Map errorHandler = {'status': false, 'message': ''};
    if (selectedFineTitle == 'select title') {
      errorHandler['message'] = 'Title of road violation';
      return errorHandler;
    } else if (selectedAmount == '0') {
      errorHandler['message'] = 'Title of rule violated not selected';
      return errorHandler;
    } else {
      errorHandler['status'] = true;
      return errorHandler;
    }
  }
}
