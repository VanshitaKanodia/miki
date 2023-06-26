import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:miki/service/auth_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {


  Future<void> _handleSignIn() async {
    try {
      await AuthService().signInWithGoogle();
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => handleAuthState(),
      ),
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(top: 60, bottom: 20),
                  child: Text('WELCOME',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),),
                ),
                FaIcon(
                  FontAwesomeIcons.circleUser,
                  size: 55,
                  color: Colors.black,
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 50),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            onChanged: (value) {},
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              fontSize: 25,
                            ),
                            decoration: const InputDecoration(
                                hintText: 'Username or Email',
                                hintStyle:
                                TextStyle(fontSize: 15, letterSpacing: 1.2)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 50),
                          child: TextFormField(
                            obscureText: true,
                            obscuringCharacter: '*',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            onChanged: (value) {},
                            decoration: const InputDecoration(
                                hintText: 'Password',
                                hintStyle:
                                TextStyle(fontSize: 15, letterSpacing: 1.2)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => SimpleMapScreen()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: const Text(
                                'LOG IN',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  _handleSignIn();
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.google,
                                  size: 50,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 113, 113, 113)),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text('Sign Up',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color.fromARGB(
                                            255, 29, 93, 158))),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
