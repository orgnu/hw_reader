import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hw_reader/data/service/tensorflow.service.dart';

part 'recognition.state.dart';

class RecognitionCubit extends Cubit<RecognitionState> {
  RecognitionCubit() : super(RecognitionInitial());
  final service = TensorflowService();

  init() async {
    try {
      emit(RecognitionLoading());
      await service.loadModel();
      emit(RecognitionSuccess(service));
    } catch (e) {
      emit(RecognitionError(e.toString()));
    }
  }
}
