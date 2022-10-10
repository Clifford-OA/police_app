
import 'package:flutter/material.dart';
import 'package:flutter_camera/flutter_camera.dart';
import 'package:provider/provider.dart';
import 'package:police_app/auth/police.dart';

class CameraPage extends StatefulWidget {

   const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  Widget build(BuildContext context) {
    final policeEvidence = Provider.of<PoliceEvidence>(context, listen: false);
    return FlutterCamera(
      color: Colors.amber,
      onImageCaptured: (value) {
       policeEvidence.referencePath = value.path;
       
      },
      onVideoRecorded: (value) {
         policeEvidence.referencePath = value.path;   
      },
    );
  }
}
