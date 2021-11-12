import 'package:acme_fit/screens/initial_screen/widgets/log_in_widget.dart';
import 'package:acme_fit/utils/screen_config.dart';
import 'package:acme_fit/widgets/background_screen.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool isLogIn = true;
  double? gridHeight, gridWidth;
  @override
  Widget build(BuildContext context) {
    ScreenConfig.read(context);
    gridHeight = ScreenConfig.gridHeight;
    gridWidth = ScreenConfig.gridWidth;
    return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: SafeArea(
            child: Scaffold(
                body: Container(
                    height: gridHeight! * 100,
                    width: gridWidth! * 100,
                    decoration: const BoxDecoration(),
                    child: SingleChildScrollView(
                        child: Stack(
                      children: [
                        Column(children: [
                          SizedBox(
                            height: gridHeight! * 8,
                          ),
                          SizedBox(
                            height: gridHeight! * 28,
                            width: gridWidth! * 60,
                            child: Image.asset(
                              "assets/app_logo.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          isLogIn
                              ? const LogInWidget()
                              : SizedBox(
                                  height: gridHeight! * 100,
                                  width: gridWidth! * 100,
                                  child: const Center(
                                    child: Text("Coming Soon"),
                                  ),
                                ),
                        ]),
                        Positioned(
                          left: gridWidth! * 20,
                          bottom: gridHeight! * 10,
                          child: isLogIn
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: gridHeight! * 3),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Don't have an account?",
                                        style: ScreenConfig.blackH6,
                                      ),
                                      SizedBox(
                                        width: gridWidth! * 2,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            isLogIn = false;
                                          });
                                        },
                                        child: SizedBox(
                                          child: Text(
                                            "Register now !",
                                            style: TextStyle(
                                                color: Colors.blue[900],
                                                fontSize: gridHeight! * 2.2),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: gridHeight!),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Do you have an account?",
                                        style: ScreenConfig.blackH6,
                                      ),
                                      SizedBox(
                                        width: gridWidth! * 2,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            isLogIn = true;
                                          });
                                        },
                                        child: SizedBox(
                                          child: Text(
                                            "Log-In !",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.blue[900],
                                                fontSize: gridHeight! * 2.2),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                        ),
                      ],
                    ))))));
  }
}
