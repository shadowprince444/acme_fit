import 'package:acme_fit/models/health_tracker_data_model.dart';
import 'package:acme_fit/repository/tracker_data_repository.dart';
import 'package:acme_fit/screens/details_screen/details_screen.dart';
import 'package:acme_fit/screens/home_screen/widgets/data_widget.dart';
import 'package:acme_fit/utils/screen_config.dart';
import 'package:acme_fit/viewmodels/authentication_vm.dart';

import 'package:acme_fit/widgets/colored_containers.dart';
import 'package:acme_fit/widgets/custom_alert_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DataListTileWidget extends StatelessWidget {
  final TrackerDataType dataType;
  final TrackerDataModel dataModel;
  final double gridHeight, gridWidth;
  final Color backgroundColor, primaryColor;
  final IconData icon;
  final String title, lastReading, subTitle;
  const DataListTileWidget(
      {Key? key,
      required this.dataType,
      required this.dataModel,
      required this.gridHeight,
      required this.gridWidth,
      required this.backgroundColor,
      required this.subTitle,
      required this.icon,
      required this.lastReading,
      required this.primaryColor,
      required this.title})
      : super(key: key);

//   @override
//   State<DataListTileWidget> createState() => _DataListTileWidgetState();
// }

// class _DataListTileWidgetState extends State<DataListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return ColoredContainer(
        f1: () {},
        gridWidth: gridWidth,
        gridHeight: gridHeight,
        backgroundColor: backgroundColor,
        child: DataWidget(
          subtitle: subTitle,
          gridWidth: gridWidth,
          gridHeight: gridHeight,
          icon: IconButton(
              onPressed: () {
                switch (dataType) {
                  case TrackerDataType.bp:
                    editBloodPressure(context);

                    break;
                  case TrackerDataType.weight:
                    editWeight(context);
                    break;
                  case TrackerDataType.exercise:
                    editexerciseTime(context);
                    break;
                  default:
                    return;
                }
              },
              icon: Icon(
                Icons.edit,
                color: primaryColor,
                size: gridHeight * 4,
              )),
          title: title,
          lastReading: lastReading,
        ));
  }

  editBloodPressure(BuildContext context) async {
    TextEditingController systolicValueEditingController =
        TextEditingController(
            text:
                dataModel.bloodPressureModel!.currentSystolicValue.toString());
    TextEditingController diastolicValueEditingController =
        TextEditingController(
            text:
                dataModel.bloodPressureModel!.currentSystolicValue.toString());

    showDialog(
        context: context,
        builder: (context) => CustomAlertDialogueBox(
              b1: "Cancel",
              b2: "Save",
              content: "",
              navigation1: () {
                Navigator.pop(context);
              },
              navigation2: () {
                TrackerDataModel trk = dataModel;
                if (diastolicValueEditingController.text != "") {
                  trk.bloodPressureModel!.currentDiastolicValue =
                      int.parse(diastolicValueEditingController.text);
                } else {
                  trk.bloodPressureModel!.currentDiastolicValue = 0;
                }
                if (systolicValueEditingController.text != "") {
                  trk.bloodPressureModel!.currentSystolicValue =
                      int.parse(systolicValueEditingController.text);
                } else {
                  trk.bloodPressureModel!.currentSystolicValue = 0;
                }
                try {
                  TrackerDataRepo.editTrackedData(
                          trk,
                          Provider.of<AuthenticationVM>(context, listen: false)
                              .userId)
                      .then((value) => Navigator.pop(context));
                } catch (e) {
                  Navigator.pop(context);
                }
              },
              title: "Edit the following?",
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: gridWidth * 8,
                      child: TextField(
                        controller: systolicValueEditingController,
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        decoration: const InputDecoration(counterText: ""),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        // onChanged: (String? value) {
                        //   if (value != null && value != "") {
                        //     currentSystolicValue = int.parse(value);
                        //   } else {
                        //     currentSystolicValue = 0;
                        //   }
                        // }, // Only numbers can be entered
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: gridWidth),
                      child: SizedBox(
                        child: Text(
                          "/",
                          style: ScreenConfig.mulishH1,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: gridWidth * 8,
                      child: TextField(
                        controller: diastolicValueEditingController,
                        decoration: const InputDecoration(counterText: ""),
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        // onChanged: (String? value) {
                        //   if (value != null && value != "") {
                        //     currentDiastolicValue =
                        //         int.parse(value);
                        //   } else {
                        //     currentDiastolicValue = 0;
                        //   }
                        // }, // Only numbers can be entered
                      ),
                    ),
                    Text(
                      "mmHg",
                      style: ScreenConfig.mulishH4,
                    )
                  ],
                ),
              ),
            ));
  }

  editWeight(BuildContext context) async {
    TextEditingController weightEditingController =
        TextEditingController(text: dataModel.currentWeight.toString());

    showDialog(
        context: context,
        builder: (context) => CustomAlertDialogueBox(
              b1: "Cancel",
              b2: "Save",
              content: "",
              navigation1: () {
                Navigator.pop(context);
              },
              navigation2: () {
                TrackerDataModel trk = dataModel;
                if (weightEditingController.text != "") {
                  trk.currentWeight =
                      double.parse(weightEditingController.text);
                } else {
                  trk.currentWeight = 0;
                }
                try {
                  TrackerDataRepo.editTrackedData(
                          trk,
                          Provider.of<AuthenticationVM>(context, listen: false)
                              .userId)
                      .then((value) => Navigator.pop(context));
                } catch (e) {
                  Navigator.pop(context);
                }
              },
              title: "Edit the following?",
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: gridWidth * 8,
                      child: TextField(
                        controller: weightEditingController,
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        decoration: const InputDecoration(counterText: ""),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        // onChanged: (String? value) {
                        //   if (value != null && value != "") {
                        //     currentSystolicValue = int.parse(value);
                        //   } else {
                        //     currentSystolicValue = 0;
                        //   }
                        // }, // Only numbers can be entered
                      ),
                    ),
                    Text(
                      "Kgs",
                      style: ScreenConfig.mulishH4,
                    )
                  ],
                ),
              ),
            ));
  }

  editexerciseTime(BuildContext context) async {
    TextEditingController exerciseEditingController =
        TextEditingController(text: dataModel.exerciseTime.toString());

    showDialog(
        context: context,
        builder: (context) => CustomAlertDialogueBox(
              b1: "Cancel",
              b2: "Save",
              content: "",
              navigation1: () {
                Navigator.pop(context);
              },
              navigation2: () {
                TrackerDataModel trk = dataModel;
                if (exerciseEditingController.text != "") {
                  trk.exerciseTime = int.parse(exerciseEditingController.text);
                } else {
                  trk.exerciseTime = 0;
                }
                try {
                  TrackerDataRepo.editTrackedData(
                          trk,
                          Provider.of<AuthenticationVM>(context, listen: false)
                              .userId)
                      .then((value) => Navigator.pop(context));
                } catch (e) {
                  Navigator.pop(context);
                }
              },
              title: "Edit the following?",
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: gridWidth * 8,
                      child: TextField(
                        controller: exerciseEditingController,
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        decoration: const InputDecoration(counterText: ""),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        // onChanged: (String? value) {
                        //   if (value != null && value != "") {
                        //     currentSystolicValue = int.parse(value);
                        //   } else {
                        //     currentSystolicValue = 0;
                        //   }
                        // }, // Only numbers can be entered
                      ),
                    ),
                    Text(
                      "Minutes",
                      style: ScreenConfig.mulishH4,
                    )
                  ],
                ),
              ),
            ));
  }
}
