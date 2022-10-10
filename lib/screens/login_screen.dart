import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:police_app/auth/auth.dart';
import 'package:police_app/auth/police.dart';
import 'package:police_app/screens/create_user_screen.dart';
import 'package:police_app/screens/forgot_password.dart';
import 'package:police_app/screens/home_screen.dart';
import 'package:police_app/utils/fetch_police_data.dart';
import 'package:police_app/utils/text_form.dart';
import 'package:police_app/widgets/button_widget.dart';
import 'package:police_app/widgets/header_container.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FetchPoliceData _fetchPoliceData = FetchPoliceData();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;
  bool obscureValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          HeaderContainer("Login"),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
              child: ListView(
                children: [
                  textInput(
                      hint: "Corperate Email",
                      icon: Icons.email,
                      controller: _emailController),
                  textInputPassword(
                      hint: "Password",
                      icon: Icons.lock,
                      controller: _passwordController,
                      suffixIcon: Icon(obscureValue
                          ? Icons.visibility_off
                          : Icons.visibility),
                      obscureValue: obscureValue,
                      onPressedSuffixIcon: () {
                        setState(() {
                          obscureValue = !obscureValue;
                        });
                      }),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const ForgotPassword()))),
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Center(
                          child: isLoading == false
                              ? ButtonWidget(
                                  btnText: "LOGIN",
                                  onClick: _signUserIn,
                                )
                              : const CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const CreateUserScreen()))),
                        child: const Text(
                          "Register",
                          style: TextStyle(fontSize: 20, color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _signUserIn() {
    final police = Provider.of<Police>(context, listen: false);
    setState(() {
      isLoading = true;
    });
    AuthClass()
        .signIN(police, _emailController.text, _passwordController.text)
        .then((value) async {
      if (value['status']) {
        _fetchPoliceData.loadUserData(context);
        setState(() {
          isLoading = false;
        });
        return Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => const HomeScreen()));
      } else {
        setState(() {
          isLoading = false;
        });
        return ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(value['message'])));
      }
    });
  }
}
