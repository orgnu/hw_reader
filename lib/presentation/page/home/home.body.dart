// create a class that extends the StatefulWidget widget and name it HomeBody?
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hw_reader/config/size.constants.dart';
import 'package:hw_reader/data/model/prediction.model.dart';
import 'package:hw_reader/data/service/tensorflow.service.dart';
import 'package:hw_reader/presentation/page/home/widgets/painter.dart';
import 'package:hw_reader/presentation/page/home/widgets/prediction.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final _points = <Offset>[];
  final _service = TensorflowService();
  late List<PredictionModel> _prediction;
  bool initialize = false;

  @override
  void initState() {
    super.initState();
    _initModel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: const <Widget>[
                    Text(
                      'MNIST database of handwritten digits',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'The digits have been size-normalized and centered in a fixed-size images (28 x 28)',
                    )
                  ],
                ),
              ),
            ),
            _mnistPreviewImage(),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        _drawCanvasWidget(),
        const SizedBox(
          height: 10,
        ),
        PredictionWidget(
          predictions: _prediction,
        ),
      ],
    );
  }

  Widget _drawCanvasWidget() {
    return Container(
      width: SizeConstants.canvasSize + SizeConstants.borderSize * 2,
      height: SizeConstants.canvasSize + SizeConstants.borderSize * 2,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: SizeConstants.borderSize,
        ),
      ),
      child: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          Offset localPosition = details.localPosition;
          if (localPosition.dx >= 0 &&
              localPosition.dx <= SizeConstants.canvasSize &&
              localPosition.dy >= 0 &&
              localPosition.dy <= SizeConstants.canvasSize) {
            setState(() {
              _points.add(localPosition);
            });
          }
        },
        onPanEnd: (DragEndDetails details) {
          // _points.add(null);
          _recognize();
        },
        child: CustomPaint(
          painter: DrawingPainter(_points),
        ),
      ),
    );
  }

  Widget _mnistPreviewImage() {
    return Container(
      width: 100,
      height: 100,
      color: Colors.black,
      child: FutureBuilder(
        future: _previewImage(),
        builder: (BuildContext _, snapshot) {
          if (snapshot.hasData) {
            return Image.memory(
              snapshot.data!,
              fit: BoxFit.fill,
            );
          } else {
            return const Center(
              child: Text('Error'),
            );
          }
        },
      ),
    );
  }

  void _initModel() async {
    await _service.loadModel();
  }

  Future<Uint8List> _previewImage() async {
    return await _service.previewImage(_points);
  }

  void _recognize() async {
    List<dynamic> pred = await _service.recognize(_points);
    setState(() {
      _prediction = pred.map((json) => PredictionModel.fromJson(json)).toList();
    });
  }
}
