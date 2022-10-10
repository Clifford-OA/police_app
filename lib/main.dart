import 'dart:async';

import 'package:flutter/material.dart';
import 'package:police_app/auth/auth.dart';
import 'package:police_app/auth/police.dart';
import 'package:police_app/screens/home_screen.dart';
import 'package:police_app/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:police_app/utils/fetch_police_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return const Text(
            'Error',
            textDirection: TextDirection.ltr,
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<AuthClass>(
                create: (_) => AuthClass(),
              ),
               ChangeNotifierProvider<PoliceEvidence>(
                create: (_) => PoliceEvidence(''),
              ),
              ChangeNotifierProvider<Police>(
                  create: (_) => Police(
                        false,
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                      ))
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Login',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: const SplashPage(),
            ),
          );
        }

        // if not yet initialized show a process indicator
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final FetchPoliceData _fetchPoliceData = FetchPoliceData();

  @override
  void initState() {
    final authClass = Provider.of<AuthClass>(context, listen: false);
    // final firebaseUser = FirebaseAuth.instance.currentUser;
    final police = authClass.currentPolice;
    // print(uid);
    // print(uid.runtimeType);
    super.initState();
    _fetchPoliceData.loadUserData(context);
    Timer(const Duration(milliseconds: 4000), () {
      // if (uid == null ) {
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => LoginScreen()));
      // } else {
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => HomeScreen()));
      // }
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  police == null ? const LoginScreen() : const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Colors.white12],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter),
        ),
        child: Center(
            child: SizedBox(
          height: 200,
          child: Center(
            child: Image.asset("assets/police.png"),
          ),
        )),
      ),
    );
  }
}
