import 'dart:io';

import 'package:flutter/material.dart';
import 'package:police_app/widgets/get_video.dart';

class VideoSelectorScreen extends StatefulWidget {
  const VideoSelectorScreen({Key? key}) : super(key: key);

  @override
  State<VideoSelectorScreen> createState() => _VideoSelectorScreenState();
}

class _VideoSelectorScreenState extends State<VideoSelectorScreen> {
  File? file;
  String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Video'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: Center(
              child: MaterialButton(
                color: Colors.indigo[900],
                onPressed: () async {
                  // await getfile();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GetVideoScreen(),
                    ),
                  );
                },
                child: const Text(
                  'record video',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
