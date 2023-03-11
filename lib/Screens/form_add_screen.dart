import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:symonic_app/Cubit/parameter_cubit.dart';
import 'package:symonic_app/Cubit/parameter_state.dart';
import 'package:symonic_app/Helper/dio_helper.dart';
import 'package:symonic_app/Model/parameter.dart';

class AddEditParameter extends StatefulWidget {
  final ParameterData parameterData;

  AddEditParameter({
    required this.parameterData,
  });

  @override
  _AddEditParameterState createState() => _AddEditParameterState();
}

class _AddEditParameterState extends State<AddEditParameter> {
  final parameterCubit = ParameterCubit(DioHelper());
  final scaffoldState = GlobalKey<ScaffoldState>();
  final formState = GlobalKey<FormState>();
  final focusNodeButtonSubmit = FocusNode();
  var controllerNama = TextEditingController();
  var controllerAmbangbatas = TextEditingController();
  var isEdit = false;
  var isSuccess = false;

  @override
  void initState() {
    isEdit = widget.parameterData != null;
    if (isEdit) {
      controllerNama.text = widget.parameterData.nama;
      controllerAmbangbatas.text = widget.parameterData.ambangbatas;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isSuccess) {
          Navigator.pop(context, true);
        }
        return true;
      },
      child: Scaffold(
        key: scaffoldState,
        appBar: AppBar(
          title: Text(widget.parameterData == null
              ? 'Add Parameter'
              : 'Edit Parameter'),
        ),
        body: BlocProvider<ParameterCubit>(
          create: (_) => parameterCubit,
          child: BlocListener<ParameterCubit, ParameterState>(
            listener: (_, state) {
              if (state is SuccessSubmitParameterState) {
                isSuccess = true;
                if (isEdit) {
                  Navigator.pop(context, true);
                } else {
                  // ignore: deprecated_member_use
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Parameter addes successfully'),
                    ),
                  );
                  setState(() {
                    controllerNama.clear();
                    controllerAmbangbatas.clear();
                  });
                }
              } else if (state is FailureSubmitParameterState) {
                // ignore: deprecated_member_use
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                  ),
                );
              }
            },
            child: Stack(
              children: [
                _buildWidgetForm(),
                _buildWidgetLoading(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetForm() {
    return Form(
      key: formState,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: controllerAmbangbatas,
              decoration: InputDecoration(
                labelText: 'Ambang Batas',
              ),
              validator: (value) {
                debugPrint('value ambang batas: $value');
                return value == null || value.isEmpty
                    ? 'Enter Ambang Batas'
                    : null;
              },
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text('SUBMIT'),
                focusNode: focusNodeButtonSubmit,
                onPressed: () {
                  focusNodeButtonSubmit.requestFocus();
                  if (formState.currentState!.validate()) {
                    var nama = controllerNama.text.trim();
                    var ambangbatas = controllerAmbangbatas.text.trim();
                    if (isEdit) {
                      var parameterData = ParameterData(
                        id: widget.parameterData.id,
                        nama: nama,
                        ambangbatas: ambangbatas,
                      );
                      parameterCubit.editParameter(parameterData);
                    }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetLoading() {
    return BlocBuilder<ParameterCubit, ParameterState>(
      builder: (_, state) {
        if (state is LoadingParameterState) {
          return Container(
            color: Colors.black.withOpacity(.5),
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Platform.isIOS
                  ? CupertinoActivityIndicator()
                  : CircularProgressIndicator(),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
