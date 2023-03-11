import 'package:symonic_app/Model/parameter.dart';

abstract class ParameterState {}

class InitialParameterState extends ParameterState {}

class LoadingParameterState extends ParameterState {}

class FailureLoadAllParameterState extends ParameterState {
  final String errorMessage;

  FailureLoadAllParameterState(this.errorMessage);

  @override
  String toString() {
    return 'FailureLoadAllParameterState{errorMessage: $errorMessage}';
  }
}

class SuccessLoadAllParameterState extends ParameterState {
  final List<ParameterData> listParameters;
  final String message;

  SuccessLoadAllParameterState(this.listParameters, {required this.message});

  @override
  String toString() {
    return 'SuccessLoadAllParameterState{listParameters: $listParameters, message: $message}';
  }
}

class FailureSubmitParameterState extends ParameterState {
  final String errorMessage;

  FailureSubmitParameterState(this.errorMessage);

  @override
  String toString() {
    return 'FailureSubmitParameterState{errorMessage: $errorMessage}';
  }
}

class SuccessSubmitParameterState extends ParameterState {}

class FailureDeleteParameterState extends ParameterState {
  final String errorMessage;

  FailureDeleteParameterState(this.errorMessage);

  @override
  String toString() {
    return 'FailureDeleteParameterState{errorMessage: $errorMessage}';
  }
}
