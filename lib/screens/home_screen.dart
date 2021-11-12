import 'package:acme_fit/screens/initial_screen/initial_screen.dart';
import 'package:acme_fit/screens/initial_screen/widgets/log_in_widget.dart';
import 'package:acme_fit/utils/screen_config.dart';
import 'package:acme_fit/viewmodels/authentication_vm.dart';
import 'package:acme_fit/viewmodels/user_data_vm.dart';
import 'package:acme_fit/widgets/network_image_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  double? gridHeight, gridWidth;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenConfig.read(context);
    gridHeight = ScreenConfig.gridHeight;
    gridWidth = ScreenConfig.gridWidth;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          enableFeedback: false,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          unselectedItemColor: Colors.grey,
          selectedItemColor: const Color(0xFF84D287),
          backgroundColor: Colors.white,
          currentIndex: currentIndex,
          onTap: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          iconSize: gridHeight! * 4,
          items: const [
            BottomNavigationBarItem(
              label: "",
              icon: Icon(FontAwesomeIcons.houseUser),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Icon(FontAwesomeIcons.wallet),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Icon(FontAwesomeIcons.chartBar),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Icon(FontAwesomeIcons.user),
            )
          ]),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            left: gridWidth! * 5,
            right: gridWidth! * 5),
        height: gridHeight! * 100,
        width: gridWidth! * 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: gridHeight! * 10,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text(
                                  "Do you Want to Log Out?",
                                  style: ScreenConfig.mulishH2,
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "No",
                                        style: ScreenConfig.mulishH3,
                                      )),
                                  TextButton(
                                      onPressed: () async {
                                        await FirebaseAuth.instance
                                            .signOut()
                                            .then((value) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const InitialScreen()));
                                        });
                                      },
                                      child: Text(
                                        "Yes",
                                        style: ScreenConfig.mulishH3,
                                      ))
                                ],
                              ));
                    },
                    icon: Icon(
                      Icons.grid_view_rounded,
                      color: Colors.black,
                      size: gridHeight! * 5,
                    ),
                  ),
                  Expanded(child: Container()),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(gridHeight! * 3),
                        border: Border.all(
                            color: Colors.grey, width: gridHeight! * .2)),
                    child: Container(
                      margin: EdgeInsets.all(gridWidth!),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(gridHeight! * 2),
                          border: Border.all(
                              color: Colors.grey, width: gridHeight! * .2)),
                      height: gridHeight! * 6,
                      width: gridHeight! * 6,
                      child: Consumer<AuthenticationVM>(
                          builder: (context, authenticationVM, _) {
                        return NetworkImageLoader(
                          boxFit: BoxFit.cover,
                          path: authenticationVM.imageUrl,
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(right: gridWidth! * 3, bottom: gridHeight!),
              height: gridHeight! * 8,
              width: gridWidth! * 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Consumer<UserDataVM>(builder: (context, userDataVM, _) {
                    return Expanded(
                      child: Text(
                        "Hello ${userDataVM.userName ?? ""}",
                        style: ScreenConfig.mulishH1,
                      ),
                    );
                  }),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.settings,
                        color: Colors.black,
                        size: gridHeight! * 5,
                      )),
                ],
              ),
            ),
            Text(
              "Welcome Back !",
              style: ScreenConfig.mulishH5,
            ),
            SizedBox(
              height: gridHeight! * 2,
            ),
            Consumer<AuthenticationVM>(builder: (context, authenticationVM, _) {
              return Column(
                children: [],
              );
            }),
            ColoredDataContainer(
              f1: () {},
              gridWidth: gridWidth!,
              gridHeight: gridHeight!,
              primaryColor: const Color(0xFFF39964),
              backgroundColor: const Color(0xFFFFEFE2),
              title: "Blood Pressure",
              icon: Icons.favorite,
              lastReading: "80/120 mmHg",
              subTitle: "Total Sales Today",
            ),
            SizedBox(
              height: gridHeight! * 4,
            ),
            Consumer<AuthenticationVM>(builder: (context, authenticationVM, _) {
              return ColoredDataContainer(
                f1: () {},
                gridWidth: gridWidth!,
                gridHeight: gridHeight!,
                primaryColor: const Color(0xFF84D287),
                backgroundColor: const Color(0xFFF0FCF0),
                title: "Body Weight",
                icon: Icons.speed_outlined,
                lastReading: "80 Kg",
                subTitle: "Perday Ratio",
              );
            }),
            SizedBox(
              height: gridHeight! * 4,
            ),
            ColoredDataContainer(
              f1: () {},
              gridWidth: gridWidth!,
              gridHeight: gridHeight!,
              primaryColor: const Color(0xFF7FBDD2),
              backgroundColor: const Color(0xFFE6F5FA),
              title: "Daily Exercise",
              icon: Icons.directions_run_rounded,
              lastReading: "30 minutes",
              subTitle: "Total Orders Today",
            ),
          ],
        ),
      ),
    );
  }
}

class ColoredDataContainer extends StatefulWidget {
  const ColoredDataContainer(
      {Key? key,
      required this.f1,
      required this.gridWidth,
      required this.subTitle,
      required this.gridHeight,
      required this.backgroundColor,
      required this.primaryColor,
      required this.title,
      this.icon,
      this.lastReading})
      : super(key: key);
  final String title, subTitle;
  final Color primaryColor, backgroundColor;
  final IconData? icon;
  final String? lastReading;
  final double gridWidth, gridHeight;
  final Function()? f1;

  @override
  State<ColoredDataContainer> createState() => _ColoredDataContainerState();
}

class _ColoredDataContainerState extends State<ColoredDataContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.f1!,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: widget.gridWidth * 5,
            vertical: widget.gridHeight * 2.5),
        decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius:
                BorderRadius.all(Radius.circular(widget.gridHeight * 4))),
        height: widget.gridHeight * 18,
        width: widget.gridWidth * 90,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: widget.gridWidth * 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: ScreenConfig.mulishH3,
                    ),
                    Text(
                      "Last Reading",
                      style: ScreenConfig.mulishH5,
                    ),
                    Text(
                      widget.lastReading ?? "-/-",
                      style: ScreenConfig.mulishH2,
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(widget.gridHeight * 2),
              child: Icon(
                widget.icon,
                color: widget.primaryColor,
                size: widget.gridHeight * 6,
              ),
            ),
            // Stack(
            //   children: [
            //     SizedBox(
            //       height: widget.gridHeight * 18,
            //       width: widget.gridWidth * 30,
            //       child: Center(
            //         child: CircularPercentIndicator(
            //           progressColor: widget.primaryColor,
            //           backgroundColor: Colors.transparent,
            //           radius: widget.gridHeight * 10,
            //           center: Text(
            //             "${widget.percentage!.round()}%",
            //             style: ScreenConfig.mulishH4,
            //           ),
            //           percent: widget.percentage! / 100,
            //         ),
            //       ),
            //     ),
            //     widget.percentage! > 50.0
            //         ? Positioned(
            //             right: 0,
            //             child: Transform.rotate(
            //                 angle: .7,
            //                 child: Icon(
            //                   Icons.arrow_upward_rounded,
            //                   size: widget.gridHeight * 4,
            //                   color: widget.primaryColor.withOpacity(.5),
            //                 )),
            //           )
            //         : Positioned(
            //             right: 0,
            //             child: Transform.rotate(
            //                 angle: 2.5,
            //                 child: Icon(
            //                   Icons.arrow_upward_rounded,
            //                   size: widget.gridHeight * 4,
            //                   color: widget.primaryColor.withOpacity(.5),
            //                 )),
            //           )
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
