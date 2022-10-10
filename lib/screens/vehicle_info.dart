import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:police_app/screens/edit_profile.dart';
import 'package:police_app/widgets/challan_card.dart';

class VehicleInformationScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final vehicleNumber;
  // ignore: prefer_typing_uninitialized_variables
  final violatorData;
  const VehicleInformationScreen(this.vehicleNumber, this.violatorData,
      {Key? key})
      : super(key: key);

  @override
  State<VehicleInformationScreen> createState() =>
      _VehicleInformationScreenState();
}

class _VehicleInformationScreenState extends State<VehicleInformationScreen> {
  Future<Widget> _displayVehicleInfo(
      BuildContext context, String vehicleNumber) async {
    List<Widget> list = [
      const SizedBox(height: 0.0),
    ];
    await FirebaseFirestore.instance
        .collection('fineList')
        .orderBy('fine_date', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        if (data['vehicleNumber'] == vehicleNumber) {
          list.add(ChallanCard(data));
        }
      }
    });
    return list.length > 1
        ? Column(
            children: list,
          )
        : Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Center(
              child: Text(
                '"$vehicleNumber" has no fine history',
                style: const TextStyle(fontSize: 20),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Vehicle Information'),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => const EditUserProfile()))),
              icon: const Icon(Icons.report))
        ],
        elevation: 0,
      ),
      body: SizedBox(
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.3),
                      height: size.height / 1.7,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          )),
                      child: ListView(
                        children: [
                          FutureBuilder<Widget>(
                              future: _displayVehicleInfo(
                                  context, widget.vehicleNumber),
                              builder: (BuildContext context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.hasData) {
                                    return snapshot.data as Widget;
                                  }
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15, left: 15, bottom: 10, right: 10),
                      child: Container(
                        margin: const EdgeInsets.only(right: 30),
                        child: Center(
                          child: Column(
                            children: [
                              const Text(
                                'Owner name',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(widget.violatorData['name'].toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400)),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'Vehicle number',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                widget.vehicleNumber,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'Phone number',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                widget.violatorData['phone'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'GPS Address',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                widget.violatorData['address'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  
  }
}
