import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:police_app/auth/auth.dart';
import 'package:police_app/screens/home_screen.dart';
import 'package:police_app/widgets/history_tile.dart';

class HistoryLogScreen extends StatefulWidget {
  const HistoryLogScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<HistoryLogScreen> createState() => _HistoryLogScreenState();
}

class _HistoryLogScreenState extends State<HistoryLogScreen> {
  double kDefaultPadding = 10.0;

  // Display booked list for you
  Future<Widget> _displayHistory(BuildContext context) async {
    final authClass = Provider.of<AuthClass>(context, listen: false);
    String userId = authClass.auth.currentUser!.uid;
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
        if (data['tid'] == userId) {
          list.add(HistoryTile(data));
        }
      }
    });

    return list.length > 1
        ? Column(
            children: list,
          )
        : const Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: Center(
              child: Text('Your history list is empty'),
            ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()))),
          title: const Text('History'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FutureBuilder<Widget>(
                  future: _displayHistory(context),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
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
        ));
  }
}
