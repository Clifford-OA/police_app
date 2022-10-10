import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_camera/flutter_camera.dart';
import 'package:police_app/screens/report_violator_screen.dart';

class GetVideoScreen extends StatefulWidget {
  const GetVideoScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GetVideoScreenState createState() => _GetVideoScreenState();
}

class _GetVideoScreenState extends State<GetVideoScreen> {
  @override
  Widget build(BuildContext context) {
    return FlutterCamera(
      color: Colors.amber,
      onImageCaptured: (value) {
        final path = value.path;
        if (path.contains('.jpg')) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Image.file(File(path)),
                );
              });
        }
      },
      onVideoRecorded: (value) {
        final path = value.path;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ReportViolatorScreen(
                      videoFile: File(path),
                      name: value.name,
                    )));

        ///Show video preview .mp4
      },
    );
    // return Container();
  }
}
