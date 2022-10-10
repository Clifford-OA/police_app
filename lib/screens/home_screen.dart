import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:police_app/auth/police.dart';
import 'package:police_app/screens/login_screen.dart';
import 'package:police_app/utils/dialog_box.dart';
import 'package:police_app/utils/fetch_police_data.dart';

import 'package:police_app/widgets/home_screen_item.dart';
import '../utils/Icon_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    final FetchPoliceData _fetchPoliceData = FetchPoliceData();


  List<IconModel> homeIcons = [
    IconModel(id: 1, image: "assets/search.png", title: "Search"),
    IconModel(id: 2, image: "assets/report.png", title: "Report Violator"),
    IconModel(id: 3, image: "assets/history.png", title: "History"),
    IconModel(id: 4, image: "assets/info.png", title: "Profile"),
    // IconModel(id: 5, image: "assets/add_user.png", title: "Edit Profile")
  ];

  @override
  void initState() {
    _fetchPoliceData.loadFineTypes(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final police = Provider.of<Police>(context, listen: false);
    String name = police.name;
    // ignore: avoid_print
    print("$name name");
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 250,
        leading: Image.asset(
          "assets/police.png",
        ),
        toolbarHeight: 150,
        elevation: 10,
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 248, 248, 248),
          fontSize: 24,
          fontStyle: FontStyle.italic,
        ),
        title: Text("Welcome\n$name"),
      ),
      body: Padding(
          padding:
              const EdgeInsets.only(top: 30.0, bottom: 50, left: 10, right: 10),
          child: GridView.builder(
            itemCount: homeIcons.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 50,
              crossAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) => HomeScreenitem(
              iconModel: homeIcons[index],
            ),
          )),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(70, 0, 70, 5),
          child: ElevatedButton(
            child: const Text('Sign Out'),
            onPressed: () {
              DialogBox().showLogOutDialogBox(context).then((value) => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const LoginScreen())))
                  });
              // AuthClass().signOut();
            },
          ),
        ),
      ),
    );
  }
}
