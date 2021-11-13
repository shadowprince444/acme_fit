import 'package:acme_fit/models/health_tracker_data_model.dart';
import 'package:acme_fit/repository/tracker_data_repository.dart';
import 'package:acme_fit/screens/details_screen/widgets/data_tile_widget.dart';
import 'package:acme_fit/utils/screen_config.dart';
import 'package:acme_fit/viewmodels/authentication_vm.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

enum TrackerDataType { bp, weight, exercise }

class DetailesScreen extends StatefulWidget {
  final TrackerDataType trackerDataType;
  const DetailesScreen({Key? key, required this.trackerDataType})
      : super(key: key);

  @override
  _DetailesScreenState createState() => _DetailesScreenState();
}

class _DetailesScreenState extends State<DetailesScreen> {
  TrackerDataType? trackerType;
  late String userId;
  double? gridHeight, gridWidth;

  @override
  void initState() {
    userId = Provider.of<AuthenticationVM>(context, listen: false).userId;
    trackerType = widget.trackerDataType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenConfig.read(context);
    gridHeight = ScreenConfig.gridHeight;
    gridWidth = ScreenConfig.gridWidth;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: gridHeight! * 100,
          width: gridWidth! * 100,
          child: Column(
            children: [
              SizedBox(
                height: gridHeight! * 10,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back,
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
                            borderRadius:
                                BorderRadius.circular(gridHeight! * 2),
                            border: Border.all(
                                color: Colors.grey, width: gridHeight! * .2)),
                        height: gridHeight! * 6,
                        width: gridHeight! * 6,
                        child: Container(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder<List<TrackerDataModel>>(
                    stream: TrackerDataRepo.getTrackedData(userId),
                    builder: (context,
                        AsyncSnapshot<List<TrackerDataModel>> snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                            child: Text(
                          "Sorry....!Something went wrong try again after sometimes ${snapshot.error}",
                          style: ScreenConfig.errortxt,
                        ));
                      }

                      if (snapshot.hasData) {
                        if (snapshot.data != null) {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                switch (trackerType) {
                                  case TrackerDataType.bp:
                                    return DataListTileWidget(
                                      dataModel: snapshot.data![index],
                                      dataType: TrackerDataType.bp,
                                      subTitle: timeConverter(
                                          snapshot.data![index].submittedTime!),
                                      gridHeight: gridHeight!,
                                      gridWidth: gridWidth!,
                                      backgroundColor: const Color(0xFFFFEFE2),
                                      title: "Blood Pressure",
                                      icon: Icons.favorite,
                                      lastReading:
                                          "${snapshot.data![index].bloodPressureModel!.currentSystolicValue} / ${snapshot.data![index].bloodPressureModel!.currentDiastolicValue} mmHg",
                                      primaryColor: const Color(0xFFF39964),
                                    );
                                  case TrackerDataType.exercise:
                                    return DataListTileWidget(
                                      dataModel: snapshot.data![index],
                                      dataType: TrackerDataType.exercise,
                                      subTitle: timeConverter(
                                          snapshot.data![index].submittedTime!),
                                      gridHeight: gridHeight!,
                                      gridWidth: gridWidth!,
                                      backgroundColor: const Color(0xFFE6F5FA),
                                      title: "Daily Exercise",
                                      primaryColor: const Color(0xFF7FBDD2),
                                      icon: Icons.directions_run_rounded,
                                      lastReading:
                                          "${snapshot.data![index].exerciseTime} minutes",
                                    );

                                  case TrackerDataType.weight:
                                    return DataListTileWidget(
                                      dataModel: snapshot.data![index],
                                      dataType: TrackerDataType.weight,
                                      subTitle: timeConverter(
                                          snapshot.data![index].submittedTime!),
                                      gridHeight: gridHeight!,
                                      gridWidth: gridWidth!,
                                      backgroundColor: const Color(0xFFF0FCF0),
                                      title: "Body Weight",
                                      icon: Icons.speed_outlined,
                                      lastReading:
                                          "${snapshot.data![index].currentWeight} Kg",
                                      primaryColor: const Color(0xFF84D287),
                                    );
                                  default:
                                    Container();
                                }
                                return ListTile(
                                  title: Text(
                                    snapshot.data![index].currentWeight
                                        .toString(),
                                    style: ScreenConfig.mulishH2,
                                  ),
                                );
                              });
                        }
                      } else {
                        return Center(
                          child: Text(
                            "No data available,add your readings daily inorder to track them efficiently",
                            style: ScreenConfig.mulishH4,
                          ),
                        );
                      }

                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String timeConverter(DateTime dateTime) {
    if (dateTime.isAfter(DateTime.now().subtract(Duration(
        hours: TimeOfDay.now().hour, minutes: TimeOfDay.now().minute)))) {
      return DateFormat("hh : mm a").format(dateTime);
    } else {
      return DateFormat("hh : mm a ,dd:MMM:yyyy").format(dateTime);
    }
  }
}
