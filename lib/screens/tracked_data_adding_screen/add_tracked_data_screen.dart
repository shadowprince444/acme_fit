import 'package:acme_fit/models/blood_pressure_model.dart';
import 'package:acme_fit/models/health_tracker_data_model.dart';
import 'package:acme_fit/repository/tracker_data_repository.dart';
import 'package:acme_fit/screens/tracked_data_adding_screen/adding_widget.dart';
import 'package:acme_fit/utils/screen_config.dart';
import 'package:acme_fit/viewmodels/authentication_vm.dart';
import 'package:acme_fit/widgets/colored_containers.dart';
import 'package:acme_fit/widgets/custom_alert_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddTrackedDataScreen extends StatefulWidget {
  const AddTrackedDataScreen({Key? key}) : super(key: key);

  @override
  _AddTrackedDataScreenState createState() => _AddTrackedDataScreenState();
}

class _AddTrackedDataScreenState extends State<AddTrackedDataScreen> {
  double? gridHeight, gridWidth;
  final formKey = GlobalKey<FormState>();
  TextEditingController systolicValueController =
      TextEditingController(text: "0");
  TextEditingController diastolicValueController =
      TextEditingController(text: "0");
  TextEditingController exerciseTimeController =
      TextEditingController(text: "0");
  TextEditingController currentWeightController =
      TextEditingController(text: "0");

  int currentSystolicValue = 0, currentDiastolicValue = 0, exerciseTime = 0;
  double currentWeight = 0;
  @override
  Widget build(BuildContext context) {
    ScreenConfig.read(context);
    gridHeight = ScreenConfig.gridHeight;
    gridWidth = ScreenConfig.gridWidth;
    return Scaffold(
      floatingActionButton: SizedBox(
        width: gridWidth! * 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF39964),
                  shape: BoxShape.circle,
                ),
                height: gridHeight! * 10,
                width: gridWidth! * 12,
                child: Center(
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: gridHeight! * 3,
                  ),
                ),
              ),
              onTap: () {
                currentWeightController.clear();
                diastolicValueController.clear();
                systolicValueController.clear();
                exerciseTimeController.clear();
              },
            ),
            InkWell(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF84D287),
                  shape: BoxShape.circle,
                ),
                height: gridHeight! * 10,
                width: gridWidth! * 12,
                child: Center(
                  child: Icon(
                    Icons.upload_rounded,
                    color: Colors.white,
                    size: gridHeight! * 3,
                  ),
                ),
              ),
              onTap: () {
                if (currentWeightController.text == "" ||
                    diastolicValueController.text == "" ||
                    systolicValueController.text == "" ||
                    exerciseTimeController.text == "" ||
                    currentWeightController.text == "0" ||
                    diastolicValueController.text == "0" ||
                    systolicValueController.text == "0" ||
                    exerciseTimeController.text == "0") {
                  showDialog(
                      context: context,
                      builder: (context) => CustomAlertDialogueBox(
                          b1: "",
                          b2: "okay",
                          content: "Please enter valid readings",
                          navigation1: () {},
                          navigation2: () {
                            Navigator.pop(context);
                          },
                          title: "Incomplete Data",
                          icon: Container()));
                } else {
                  BloodPressureModel bpModel = BloodPressureModel(
                      currentDiastolicValue: currentDiastolicValue,
                      currentSystolicValue: currentSystolicValue);
                  TrackerDataModel trkModel = TrackerDataModel(
                      bloodPressureModel: bpModel,
                      currentWeight: currentWeight,
                      exerciseTime: exerciseTime,
                      submittedTime: DateTime.now());
                  submit(
                      trkModel,
                      Provider.of<AuthenticationVM>(context, listen: false)
                          .userId!);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
      body: SizedBox(
        height: ScreenConfig.gridHeight! * 100,
        width: ScreenConfig.gridWidth! * 100,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top),
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
                        "Add Record",
                        style: ScreenConfig.mulishH1,
                      ),
                    )),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: gridHeight! * 3,
                      ),
                      ColoredContainer(
                          f1: () {},
                          gridWidth: gridWidth!,
                          gridHeight: gridHeight!,
                          backgroundColor: const Color(0xFFFFEFE2),
                          child: AddingWidget(
                            gridHeight: gridHeight!,
                            gridWidth: gridWidth!,
                            title: "Blood Pressure",
                            icon: Icons.favorite,
                            primaryColor: const Color(0xFFF39964),
                            textField: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: gridWidth! * 8,
                                    child: TextFormField(
                                      controller: systolicValueController,
                                      keyboardType: TextInputType.number,
                                      maxLength: 3,
                                      decoration: const InputDecoration(
                                          counterText: "", hintText: "0"),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onChanged: (String? value) {
                                        if (value != null && value != "") {
                                          currentSystolicValue =
                                              int.parse(value);
                                        } else {
                                          currentSystolicValue = 0;
                                        }
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: gridWidth!),
                                    child: SizedBox(
                                      child: Text(
                                        "/",
                                        style: ScreenConfig.mulishH1,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: gridWidth! * 8,
                                    child: TextField(
                                      controller: diastolicValueController,
                                      decoration: const InputDecoration(
                                          counterText: "", hintText: "0"),
                                      keyboardType: TextInputType.number,
                                      maxLength: 3,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onChanged: (String? value) {
                                        if (value != null && value != "") {
                                          currentDiastolicValue =
                                              int.parse(value);
                                        } else {
                                          currentDiastolicValue = 0;
                                        }
                                      },
                                    ),
                                  ),
                                  Text(
                                    "mmHg",
                                    style: ScreenConfig.mulishH4,
                                  )
                                ],
                              ),
                            ),
                          )),
                      SizedBox(
                        height: gridHeight! * 3,
                      ),
                      ColoredContainer(
                          f1: () {},
                          gridWidth: gridWidth!,
                          gridHeight: gridHeight!,
                          backgroundColor: const Color(0xFFF0FCF0),
                          child: AddingWidget(
                            gridHeight: gridHeight!,
                            gridWidth: gridWidth!,
                            title: "Body Weight",
                            icon: Icons.speed_outlined,
                            primaryColor: const Color(0xFF84D287),
                            textField: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: gridWidth! * 8,
                                    child: TextField(
                                      controller: currentWeightController,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      maxLength: 3,
                                      decoration: const InputDecoration(
                                          counterText: "", hintText: "0"),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      onChanged: (String? value) {
                                        if (value != null && value != "") {
                                          currentWeight = double.parse(value);
                                        } else {
                                          currentWeight = 0.0;
                                        }
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: gridWidth! * 2),
                                    child: Text(
                                      "Kgs",
                                      style: ScreenConfig.mulishH4,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                      SizedBox(
                        height: gridHeight! * 3,
                      ),
                      ColoredContainer(
                          f1: () {},
                          gridWidth: gridWidth!,
                          gridHeight: gridHeight!,
                          backgroundColor: const Color(0xFFE6F5FA),
                          child: AddingWidget(
                            gridHeight: gridHeight!,
                            gridWidth: gridWidth!,
                            title: "Daily Exercise",
                            primaryColor: const Color(0xFF7FBDD2),
                            icon: Icons.directions_run_rounded,
                            textField: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: gridWidth! * 8,
                                    child: TextField(
                                      controller: exerciseTimeController,
                                      keyboardType: TextInputType.number,
                                      maxLength: 4,
                                      decoration: const InputDecoration(
                                          counterText: "", hintText: "0"),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onChanged: (String? value) {
                                        if (value != null && value != "") {
                                          exerciseTime = int.parse(value);
                                        } else {
                                          exerciseTime = 0;
                                        }
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: gridWidth!),
                                    child: SizedBox(
                                      child: Text(
                                        "Minutes",
                                        style: ScreenConfig.mulishH4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      SizedBox(
                        height: gridHeight! * 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  submit(TrackerDataModel trkModel, String userId) async {
    await TrackerDataRepo.addData(userId, trkModel);
  }
}
