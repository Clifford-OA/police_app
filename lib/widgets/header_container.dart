import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HeaderContainer extends StatelessWidget {
  var text = "Login";

  HeaderContainer(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Colors.white12],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100))),
      child: Stack(
        children: <Widget>[
          Positioned(
              bottom: 20,
              right: 20,
              child: Text(
                text,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              )),
          Center(
            child: SizedBox(
              height: 100,
              child: Center(
                child: Image.asset("assets/police.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
