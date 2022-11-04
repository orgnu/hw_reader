part of 'recognition.cubit.dart';

abstract class RecognitionState extends Equatable {
  const RecognitionState();

  @override
  List<Object> get props => [];
}

class RecognitionInitial extends RecognitionState {}

class RecognitionLoading extends RecognitionState {}
class RecognitionError extends RecognitionState {
  final String message;

  const RecognitionError(this.message);
}

class RecognitionSuccess extends RecognitionState {
  final TensorflowService service;

  const RecognitionSuccess(this.service);
}
