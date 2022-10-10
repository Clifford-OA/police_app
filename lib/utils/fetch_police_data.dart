import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:police_app/auth/auth.dart';
import 'package:police_app/auth/police.dart';

class FetchPoliceData {
  void loadUserData(BuildContext context) async {
    CollectionReference policeCollection =
        FirebaseFirestore.instance.collection('police');
    final authClass = Provider.of<AuthClass>(context, listen: false);
    final policeClass = Provider.of<Police>(context, listen: false);
    String tid = authClass.auth.currentUser!.uid;

    await policeCollection.doc(tid).get().then((query) {
      Map<String, dynamic> data = query.data() as Map<String, dynamic>;
      policeClass.policeRef = data;
    });
  }

  void loadFineTypes(BuildContext context) async {
    final policeClass = Provider.of<Police>(context, listen: false);

    List<dynamic> fineInfo = [];

    await FirebaseFirestore.instance
        .collection('fineInfo')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        fineInfo.add(data);
      }
    });
    policeClass.fineInfo = [];
    policeClass.fineInfo.addAll(fineInfo);
  }
}
