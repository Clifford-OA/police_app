import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:police_app/auth/police.dart';
import 'package:police_app/screens/edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double kDefaultPadding = 10.0;
  @override
  Widget build(BuildContext context) {
    final police = Provider.of<Police>(context, listen: true);
    Map<String, dynamic> policeInfo = police.policeRef;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => const EditUserProfile()))),
              icon: const Icon(Icons.edit))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   padding: EdgeInsets.all(5.0),
            //   width: MediaQuery.of(context).size.width / 2,
            //   height: MediaQuery.of(context).size.width / 2,
            //   child: ClipRRect(
            //       borderRadius: BorderRadius.circular(100.0),
            //       child: FadeInImage.assetNetwork(
            //         placeholder: 'assets/no_picture.jpg',
            //         image: _policeInfo['imgUrl'],
            //         imageErrorBuilder: (context, error, stackTrace) {
            //           return Image.asset(
            //             'assets/no_picture.jpg',
            //           );
            //         },
            //         fit: BoxFit.cover,
            //       )),
            // ),
            const SizedBox(
              height: 50,
            ),

          
            ListTile(leading: const Text('Name:'), title: Text(policeInfo['name'])),
            const Divider(),
            ListTile(leading: const Text('Tel:'), title: Text(policeInfo['tel'])),
            const Divider(),
            ListTile(
                leading: const Text('Check Point:'),
                title: Text(policeInfo['checkPoint'])),
            const Divider(),
            ListTile(
                leading: const Text('Email:'), title: Text(policeInfo['email'])),
            const Divider(),
            ListTile(
                leading: const Text('Address:'), title: Text(policeInfo['address'])),
            const Divider()
          ],
        ),
      ),
    );
  }
}
