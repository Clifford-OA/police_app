import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:police_app/screens/vehicle_info.dart';
import 'package:police_app/widgets/rounded_button.dart';

import '../utils/validation.dart';
import '../utils/vehicleTextBox.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  CollectionReference fineList =
      FirebaseFirestore.instance.collection('fineList');
  CollectionReference civilian =
      FirebaseFirestore.instance.collection('civilian');

  final GlobalKey<FormState> _vehicleNumberFormKey = GlobalKey();
  final TextEditingController _vehicleNumber = TextEditingController();
  final TextEditingController _vehicleRegion = TextEditingController();
  final TextEditingController _vehicleYear = TextEditingController();

  late String _vehicleNumberText;
  bool _isLoading = false;
  late Map<String, dynamic> violatorData;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Search vehicle'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 200,
              padding: const EdgeInsets.only(top: 20),
              child: Image.asset('assets/police.png'),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child:  Text(
                'Welcome to Ghana Traffic Police, Challan system',
                style:  TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                'the supervision of road users compliance, with the traffic legislation, and punishment for non-compliance.',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'Please insert Vehicle no. below',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                // decoration: BoxDecoration(color: Colors.blue),
                child: IntrinsicHeight(
                  child: Form(
                    key: _vehicleNumberFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
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
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 10, 10),
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
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                        Center(
                          child: !_isLoading
                              ? RoundedButton(
                                  buttonName: 'Search',
                                  action: _validateAndSearchVehicleNumber,
                                )
                              : const CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void _validateAndSearchVehicleNumber() async {
    if (_vehicleNumberFormKey.currentState!.validate()) {
      _vehicleNumberText =
          '${_vehicleRegion.text}-${_vehicleNumber.text}-${_vehicleYear.text}';
      setState(() {
        _isLoading = true;
      });
      bool isCivilian = false;
      await civilian.get().then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          List<dynamic> vehicles = data['vehicles'];
          for (var i = 0; i < vehicles.length; i++) {
            if (vehicles[i] == _vehicleNumberText) {
              isCivilian = true;
              violatorData = data;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VehicleInformationScreen(
                          _vehicleNumberText, violatorData)));
            }
          }
        }
      });
      setState(() {
        _isLoading = false;
      });
      if (!isCivilian) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text('the vehicle number $_vehicleNumberText does not exist')));
      }

      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content:
      //         Text('the vehicle number $_vehicleNumberText has no fines')));

      // await fineList.get().then((QuerySnapshot querySnapshot) {
      //   querySnapshot.docs.forEach((doc) {
      //     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      //     String vehicles = data['vehicleNumber'];
      //     if (vehicles == _vehicleNumberText) {
      //       Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //               builder: (context) => VehicleInformationScreen(
      //                   _vehicleNumberText, violatorData)));
      //     }
      //   });
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //       content:
      //           Text('the vehicle number $_vehicleNumberText has no fines')));
      // });

    }
  }
}
