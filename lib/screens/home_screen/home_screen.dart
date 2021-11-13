import 'package:acme_fit/screens/details_screen/details_screen.dart';
import 'package:acme_fit/screens/home_screen/widgets/data_widget.dart';
import 'package:acme_fit/screens/initial_screen/initial_screen.dart';
import 'package:acme_fit/screens/initial_screen/widgets/log_in_widget.dart';
import 'package:acme_fit/screens/tracked_data_adding_screen/add_tracked_data_screen.dart';
import 'package:acme_fit/utils/screen_config.dart';
import 'package:acme_fit/viewmodels/authentication_vm.dart';
import 'package:acme_fit/viewmodels/user_data_vm.dart';
import 'package:acme_fit/widgets/colored_containers.dart';
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
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddTrackedDataScreen()));
        },
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Colors.grey.withOpacity(.2)),
          height: gridHeight! * 6,
          width: gridHeight! * 6,
          child: Icon(
            Icons.add,
            color: Colors.deepOrange,
            size: gridHeight! * 4,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
          enableFeedback: false,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          unselectedItemColor: Colors.grey,
          selectedItemColor: const Color(0xFF84D287),
          //backgroundColor: Colors.blue,
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
              icon: Icon(FontAwesomeIcons.shoppingBag),
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
            ColoredContainer(
              f1: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DetailesScreen(
                            trackerDataType: TrackerDataType.bp)));
              },
              gridWidth: gridWidth!,
              gridHeight: gridHeight!,
              backgroundColor: const Color(0xFFFFEFE2),
              child: DataWidget(
                subtitle: "Previous Reading",
                gridHeight: gridHeight!,
                gridWidth: gridWidth!,
                title: "Blood Pressure",
                icon: Icon(
                  Icons.favorite,
                  color: const Color(0xFFF39964),
                  size: gridHeight! * 6,
                ),
                lastReading: "80/120 mmHg",
              ),
            ),
            SizedBox(
              height: gridHeight! * 4,
            ),
            ColoredContainer(
              f1: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DetailesScreen(
                            trackerDataType: TrackerDataType.weight)));
              },
              gridWidth: gridWidth!,
              gridHeight: gridHeight!,
              backgroundColor: const Color(0xFFF0FCF0),
              child: DataWidget(
                subtitle: "Previous Reading",
                gridHeight: gridHeight!,
                gridWidth: gridWidth!,
                title: "Body Weight",
                icon: Icon(
                  Icons.speed_outlined,
                  color: const Color(0xFFF39964),
                  size: gridHeight! * 6,
                ),
                lastReading: "80 Kg",
              ),
            ),
            SizedBox(
              height: gridHeight! * 4,
            ),
            ColoredContainer(
              f1: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DetailesScreen(
                            trackerDataType: TrackerDataType.exercise)));
              },
              gridWidth: gridWidth!,
              gridHeight: gridHeight!,
              backgroundColor: const Color(0xFFE6F5FA),
              child: DataWidget(
                subtitle: "Previous Reading",
                gridHeight: gridHeight!,
                gridWidth: gridWidth!,
                title: "Daily Exercise",
                icon: Icon(
                  Icons.directions_run_rounded,
                  color: const Color(0xFFF39964),
                  size: gridHeight! * 6,
                ),
                lastReading: "30 minutes",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
