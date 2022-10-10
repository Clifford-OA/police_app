import 'package:flutter/material.dart';
import 'package:police_app/auth/auth.dart';
import 'package:police_app/screens/home_screen.dart';
import 'package:police_app/screens/login_screen.dart';

class DialogBox {
  bool _isLoading = false;

  Future showLogOutDialogBox(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return _isLoading == false
            ? AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: const Text('Logout Alert!!',
                    style: TextStyle(
                      fontFamily: 'NimbusSanL',
                      fontWeight: FontWeight.w700,
                      color: Colors.red,
                      fontSize: 20,
                    )),
                content: Builder(
                  builder: (context) {
                    // Get available height and width of the build area of this widget. Make a choice depending on the size.
                    var height = MediaQuery.of(context).size.height;
                    var width = MediaQuery.of(context).size.width;

                    return SizedBox(
                        height: height / 4,
                        width: width,
                        child: const Center(
                          child: Text("Are you sure you want to logout"),
                        ));
                  },
                ),
                actions: <Widget>[
                  OutlinedButton(
                    child: const Text(
                      "No",
                      style: TextStyle(
                        fontFamily: 'NimbusSanL',
                        fontWeight: FontWeight.w700,
                        color: Colors.black54,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => const HomeScreen()));
                      
                    },
                  ),
                  OutlinedButton(
                    child: const Text(
                      "Yes",
                      style: TextStyle(
                        fontFamily: 'NimbusSanL',
                        fontWeight: FontWeight.w700,
                        color: Colors.red,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      _isLoading = true;
                      AuthClass().signOut();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const LoginScreen()));
                      // _confirmBook(context, label);
                    },
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
