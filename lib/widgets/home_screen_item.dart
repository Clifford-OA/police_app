import 'package:flutter/material.dart';
import 'package:police_app/screens/video_screen.dart';
import 'package:police_app/utils/Icon_model.dart';

import 'package:police_app/screens/history_screen.dart';
import 'package:police_app/screens/profile_screen.dart';
import 'package:police_app/screens/search_screen.dart';

class HomeScreenitem extends StatelessWidget {
  final IconModel iconModel;
  const HomeScreenitem({Key? key, required this.iconModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(6),
            ),
            child: GestureDetector(
              onTap: (() {
                switch (iconModel.id) {
                  case 1:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchScreen()));
                    break;
                  case 2:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VideoSelectorScreen()));
                    
                    break;
                  case 3:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HistoryLogScreen()));
                    
                    break;
                  case 4:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileScreen()));
                    
                    break;
                  // default:
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => ProfileScreen()));
                    
                  //   break;
                }
              }),
              child: Card(
                margin: const EdgeInsets.all(10),
                child: Hero(
                  tag: "${iconModel.id}",
                  child: Image.asset(iconModel.image),
                ),
              ),
            ),
          ),
        ),
        Text(
          iconModel.title,
          style: const TextStyle(
              color: Color.fromARGB(255, 4, 2, 2), fontStyle: FontStyle.italic),
        ),
      ],
    );
  }
}
