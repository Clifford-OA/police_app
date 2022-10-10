import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FineDetailScreen extends StatefulWidget {
  final dynamic fineHistoryDetails;
  const FineDetailScreen({
    this.fineHistoryDetails,
    Key? key,
  }) : super(key: key);
  @override
  State<FineDetailScreen> createState() => _FineDetailScreenState();
}

class _FineDetailScreenState extends State<FineDetailScreen> {
  late VideoPlayerController _videoController;
  late ChewieController chewieController;
  late Future<void> intializedVideo;

  @override
  void initState() {
    if (widget.fineHistoryDetails['evidenceUrl'].toString().contains('.mp4')) {
      _videoController = VideoPlayerController.network(
          widget.fineHistoryDetails['evidenceUrl']);
       intializedVideo = _videoController.initialize();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    chewieController = ChewieController(
      videoPlayerController: _videoController,
      aspectRatio: 2.8 / 1.5,
      autoPlay: false,
      looping: true,
    );

    Timestamp timestamp = widget.fineHistoryDetails['fine_date'];
    final challanDate = timestamp.toDate();
    final fineDate = challanDate.toString().split(' ')[0];
    String paidDate = '';

    if (widget.fineHistoryDetails['paid_date'].toString().isNotEmpty) {
      Timestamp timestamp = widget.fineHistoryDetails['paid_date'];
      final challanPaidDate = timestamp.toDate();
      paidDate = challanPaidDate.toString().split(' ')[0];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fine Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 50),
        child: SingleChildScrollView(
          child: Column(
            children: [
              fineDetailsCard('Fine ID:', widget.fineHistoryDetails['fineId']),
              fineDetailsCard('Vehicle Number:',
                  widget.fineHistoryDetails['vehicleNumber']),
              fineDetailsCard('Issued Date:', fineDate),
              fineDetailsCard(
                'Payment Date:',
                paidDate.isNotEmpty ? paidDate : '',
              ),
              fineDetailsCard('Amount: ', widget.fineHistoryDetails['amount']),
              Card(
                margin: const EdgeInsets.all(5),
                child: ListTile(
                  leading: const Text('Payment Status'),
                  title: Text(
                    widget.fineHistoryDetails['status'] ? 'Paid' : 'Not Paid',
                    style: TextStyle(
                        color: widget.fineHistoryDetails['status']
                            ? Colors.green
                            : Colors.red,
                        fontSize: 20),
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        'Description',
                        style: TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    ),
                    const Divider(thickness: 2),
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(widget.fineHistoryDetails['description'],
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18))),
                  ],
                ),
              ),
              // Card(
              //   margin: const EdgeInsets.all(15),
              //   child: FadeInImage.assetNetwork(
              //       placeholder: 'assets/loading_icon.gif',
              //       image: widget.fineHistoryDetails['imgUrl'],
              //       imageErrorBuilder: ((context, error, stackTrace) =>
              //           Image.asset('assets/loading_icon.gif'))),
              // ),
              // _videoController!.value.isInitialized
              //     ? AspectRatio(
              //         aspectRatio: _videoController!.value.aspectRatio,
              //         child: VideoPlayer(_videoController!))
              //     : Image.asset('assets/loading_icon.gif'),
              Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width - 10,
                  padding: const EdgeInsets.all(10),
                  child: FutureBuilder(
                      future: intializedVideo,
                      builder: ((context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return AspectRatio(
                              aspectRatio: _videoController.value.aspectRatio,
                              child: Chewie(
                                controller: chewieController,
                              ));
                        } else {
                          return Image.asset('assets/loading_icon.gif');
                        }
                      }))),
              // fineDetailsCard('Officer ID:', widget.fineHistoryDetails['tid']),
            ],
          ),
        ),
      ),
    );
  }

  fineDetailsCard(title, value) {
    return Card(
      margin: const EdgeInsets.all(5),
      child: ListTile(
        leading: Text(title),
        title: Text(
          value,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
