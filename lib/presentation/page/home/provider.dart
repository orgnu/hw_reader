import 'package:flutter/material.dart';
import 'package:hw_reader/data/model/prediction.model.dart';
export 'package:hw_reader/data/model/prediction.model.dart';
export 'package:provider/provider.dart';

class HomeProvider extends ChangeNotifier {
  final List<Offset> _points = [];
  List<PredictionModel>? _prediction;

  List<Offset> get points => _points;
  List<PredictionModel>? get prediction => _prediction;
  clearBoard() {
    _points.clear();
    _prediction?.clear();
    notifyListeners();
  }

  addPoint(Offset offset) {
    _points.add(offset);
    notifyListeners();
  }

  setPrediction(pred) {
    _prediction = pred;
    notifyListeners();
  }
}
