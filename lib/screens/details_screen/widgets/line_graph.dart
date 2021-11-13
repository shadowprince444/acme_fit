import 'package:acme_fit/models/health_tracker_data_model.dart';
import 'package:acme_fit/screens/details_screen/details_screen.dart';
import 'package:acme_fit/utils/sensor_data_constants.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';

class LineGraphWidget extends StatelessWidget {
  final TrackerDataType dataType;
  final double gridHeight, gridWidth;
  final List<TrackerDataModel> dataList;
  const LineGraphWidget(
      {Key? key,
      required this.dataType,
      required this.dataList,
      required this.gridHeight,
      required this.gridWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: gridHeight * 70,
      width: gridWidth * 100,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: gridHeight * 2, horizontal: gridWidth * 2),
        child: dataType == TrackerDataType.bp
            ? LineGraph(
                features: [
                  Feature(
                      data: List.generate(
                          dataList.length,
                          (index) => (dataList[(index)]
                                  .bloodPressureModel!
                                  .currentSystolicValue!
                                  .toDouble() /
                              maxSystolicValue)).reversed.toList(),
                      color: const Color(0xFFF00000),
                      title: "Systolic"),
                  Feature(
                      data: List.generate(
                          dataList.length,
                          (index) => (dataList[(index)]
                                  .bloodPressureModel!
                                  .currentDiastolicValue!
                                  .toDouble() /
                              maxDiastolicValue)).reversed.toList(),
                      color: const Color(0xFFF39964),
                      title: "Diastolic"),
                ],
                size: Size(gridWidth * 100, gridHeight * 62),
                labelX: List.generate((dataList.length), (index) {
                  if (index == 0) {
                    return "Days----->";
                  } else {
                    return "";
                  }
                }),
                labelY: List.generate(
                    (maxDiastolicValue / 80).truncate(),
                    (index) =>
                        ((maxDiastolicValue / 4) * (index + 1)).toString() +
                        bpUnit),
                showDescription: true,
                graphColor: Colors.black87,
              )
            : dataType == TrackerDataType.weight
                ? LineGraph(
                    features: [
                      Feature(
                          data: List.generate(
                              dataList.length,
                              (index) => (dataList[(index)].currentWeight! /
                                  maxWeight)).reversed.toList(),
                          color: const Color(0xFF84D287),
                          title: "Body Weight"),
                    ],
                    size: Size(gridWidth * 100, gridHeight * 62),
                    labelX: List.generate((dataList.length), (index) {
                      if (index == 0) {
                        return "Days----->";
                      } else {
                        return "";
                      }
                    }),
                    labelY: List.generate(
                        (maxWeight / 40).truncate(),
                        (index) =>
                            ((maxWeight / 5) * (index + 1)).toString() +
                            weightUnit),
                    showDescription: true,
                    graphColor: Colors.black87,
                  )
                : LineGraph(
                    features: [
                      Feature(
                          data: List.generate(
                              dataList.length,
                              (index) => (dataList[(index)].exerciseTime! /
                                  maxWeight)).reversed.toList(),
                          color: const Color(0xFF7FBDD2),
                          title: "Exercise Time"),
                    ],
                    size: Size(gridWidth * 100, gridHeight * 62),
                    labelX: List.generate((dataList.length), (index) {
                      if (index == 0) {
                        return "Days----->";
                      } else {
                        return "";
                      }
                    }),
                    labelY: List.generate(
                        (maxTime / 120).truncate(),
                        (index) =>
                            ((maxTime / 5) * (index + 1)).toString() +
                            excerciseUnit),
                    showDescription: true,
                    graphColor: Colors.black87,
                  ),
      ),
    );
  }
}
