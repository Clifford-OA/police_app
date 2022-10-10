import 'package:flutter/material.dart';

import '../screens/fine_detail_screen.dart';

class HistoryTile extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final service;
  const HistoryTile(this.service, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String amount = service['fineId'];
    return GestureDetector(
        child: Card(
          margin: const EdgeInsets.all(5),
          child: ListTile(
            // leading: FadeInImage.assetNetwork(
            //   placeholder: 'assets/info.png',
            //   width: 80,
            //   // height: 120,
            //   image: service['imgUrl'],
            //   imageErrorBuilder: (context, error, stackTrace) {
            //     return Image.asset(
            //       'assets/info.png',
            //     );
            //   },
            //   fit: BoxFit.cover,
            // ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service['vehicleNumber'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  service['description'], softWrap: true,
                  // overflow: TextOverflow.,
                ),
              ],
            ),
            subtitle: Text(amount, style: const TextStyle(color: Colors.purple)),
            trailing: service['status']
                ? const Text('Paid',
                    style: TextStyle(fontSize: 20, color: Colors.green))
                : const Text('Not Paid',
                    style: TextStyle(fontSize: 20, color: Colors.red)),
          ),
        ),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => FineDetailScreen(
                      fineHistoryDetails: service,
                    )))));
  }
}
