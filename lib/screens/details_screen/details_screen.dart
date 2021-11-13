import 'package:acme_fit/models/health_tracker_data_model.dart';
import 'package:acme_fit/repository/tracker_data_repository.dart';
import 'package:acme_fit/screens/details_screen/widgets/data_tile_widget.dart';
import 'package:acme_fit/screens/details_screen/widgets/line_graph.dart';
import 'package:acme_fit/screens/tracked_data_adding_screen/add_tracked_data_screen.dart';
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
  late String? userId;
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
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: gridHeight! * 5,
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(left: gridWidth! * 5),
                      child: Text(
                        trackerType == TrackerDataType.bp
                            ? "Blood Pressure Log"
                            : trackerType == TrackerDataType.exercise
                                ? "Exercise Log"
                                : "Weight Log",
                        style: ScreenConfig.mulishH1,
                      ),
                    )),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder<List<TrackerDataModel>>(
                    stream: TrackerDataRepo.getTrackedData(userId!),
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
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                LineGraphWidget(
                                    dataType: trackerType!,
                                    dataList: snapshot.data!,
                                    gridHeight: gridHeight!,
                                    gridWidth: gridWidth!),
                                ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                          height: gridHeight! * 2,
                                        ),
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      switch (trackerType) {
                                        case TrackerDataType.bp:
                                          return DataListTileWidget(
                                            dataModel: snapshot.data![index],
                                            dataType: TrackerDataType.bp,
                                            subTitle: timeConverter(snapshot
                                                .data![index].submittedTime!),
                                            gridHeight: gridHeight!,
                                            gridWidth: gridWidth!,
                                            backgroundColor:
                                                const Color(0xFFFFEFE2),
                                            title: "Blood Pressure",
                                            icon: Icons.favorite,
                                            lastReading:
                                                "${snapshot.data![index].bloodPressureModel!.currentSystolicValue} / ${snapshot.data![index].bloodPressureModel!.currentDiastolicValue} mmHg",
                                            primaryColor:
                                                const Color(0xFFF39964),
                                          );
                                        case TrackerDataType.exercise:
                                          return DataListTileWidget(
                                            dataModel: snapshot.data![index],
                                            dataType: TrackerDataType.exercise,
                                            subTitle: timeConverter(snapshot
                                                .data![index].submittedTime!),
                                            gridHeight: gridHeight!,
                                            gridWidth: gridWidth!,
                                            backgroundColor:
                                                const Color(0xFFE6F5FA),
                                            title: "Daily Exercise",
                                            primaryColor:
                                                const Color(0xFF7FBDD2),
                                            icon: Icons.directions_run_rounded,
                                            lastReading:
                                                "${snapshot.data![index].exerciseTime} minutes",
                                          );

                                        case TrackerDataType.weight:
                                          return DataListTileWidget(
                                            dataModel: snapshot.data![index],
                                            dataType: TrackerDataType.weight,
                                            subTitle: timeConverter(snapshot
                                                .data![index].submittedTime!),
                                            gridHeight: gridHeight!,
                                            gridWidth: gridWidth!,
                                            backgroundColor:
                                                const Color(0xFFF0FCF0),
                                            title: "Body Weight",
                                            icon: Icons.speed_outlined,
                                            lastReading:
                                                "${snapshot.data![index].currentWeight} Kg",
                                            primaryColor:
                                                const Color(0xFF84D287),
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
                                    }),
                              ],
                            ),
                          );
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
