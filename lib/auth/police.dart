
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Police extends ChangeNotifier {
  Police(this.admin, this.imgUrl, this.tid, this.name, this.tel,
      this.checkPoint, this.email, this.address);

  String name;
  String tid;
  String imgUrl;
  String tel;
  String address;
  bool admin;
  String checkPoint;
  String email;

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.collection('police').doc(tid);

  Police get policeData =>
      Police(admin, imgUrl, tid, name, tel, checkPoint, email, address);

  Future<void> saveInfo() async {
    await firestoreRef.set(toMap());
  }

  List<dynamic> fineInfo = [];

  Map<String, dynamic> toMap() {
    return {
      'tid': tid,
      'name': name,
      'email': email,
      'admin': admin,
      'imgUrl': imgUrl,
      'tel': tel,
      'address': address,
      'checkPoint': checkPoint,
    };
  }

  set policeRef(Map<String, dynamic> data) {
    name = data['name'];
    imgUrl = data['imgUrl'];
    tid = data['tid'];
    checkPoint = data['checkPoint'];
    address = data['address'];
    email = data['email'];
    tel = data['tel'];
    admin = data['admin'];
    notifyListeners();
  }

  Map<String, dynamic> get policeRef {
    return {
      'tid': tid,
      'name': name,
      'email': email,
      'admin': admin,
      'checkPoint': checkPoint,
      'tel': tel,
      'address': address,
      'imgUrl': imgUrl
    };
  }
}

class FineInfo {
  FineInfo(this.charge, this.description, this.fineCode, this.title);
  String charge;
  String description;
  String fineCode;
  String title;
  Map<String, String> get serviceRef {
    return {
      'charge': charge,
      'title': title,
      'description': description,
      'fineCode': fineCode
    };
  }

  set serviceRef(dynamic data) {
    title = data['title'];
    charge = data['charge'].toDouble();
    description = data['description'];
    fineCode = data['fine_code'];
  }
}


class PoliceEvidence extends ChangeNotifier {
  String path;
  PoliceEvidence(this.path);

   String get referencePath => path;

   set referencePath(String data) {
    path = data;
 
  }

}