// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:symonic_app/Model/parameter.dart';

import '../Helper/dio_helper.dart';
import 'parameter_state.dart';

class ParameterCubit extends Cubit<ParameterState> {
  final DioHelper dioHelper;

  ParameterCubit(this.dioHelper) : super(InitialParameterState());

  void getAllParameters() async {
    emit(LoadingParameterState());
    var result = await dioHelper.getAllParameters();
    result.fold(
      (errorMessage) => emit(FailureLoadAllParameterState(errorMessage)),
      (listParameters) =>
          emit(SuccessLoadAllParameterState(listParameters, message: '')),
    );
  }

  void editParameter(ParameterData parameterData) async {
    emit(LoadingParameterState());
    var result = await dioHelper.editParameter(parameterData);
    result.fold(
      (errorMessage) => emit(FailureSubmitParameterState(errorMessage)),
      (_) => emit(SuccessSubmitParameterState()),
    );
  }
}
