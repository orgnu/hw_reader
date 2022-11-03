class PredictionModel {
  final double confidence;
  final int index;
  final String label;

  PredictionModel({required this.confidence, required this.index, required this.label});

  factory PredictionModel.fromJson(Map<dynamic, dynamic> json) => PredictionModel(
        confidence: json['confidence'],
        index: json['index'],
        label: json['label'],
      );
}
