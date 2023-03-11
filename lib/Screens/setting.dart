import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubit/parameter_cubit.dart';
import '../Cubit/parameter_state.dart';
import '../Helper/dio_helper.dart';
import 'form_add_screen.dart';

class Setting extends StatefulWidget {
  @override
  State createState() => new SettingState();
}

class SettingState extends State<Setting> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  late ParameterCubit parameterCubit;

  @override
  void initState() {
    parameterCubit = ParameterCubit(DioHelper());
    parameterCubit.getAllParameters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        title: Text('Setting Parameter'),
      ),
      body: BlocProvider<ParameterCubit>(
        create: (_) => parameterCubit,
        child: BlocListener<ParameterCubit, ParameterState>(
          listener: (_, state) {
            if (state is FailureLoadAllParameterState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                ),
              );
            } else if (state is FailureDeleteParameterState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                ),
              );
            } else if (state is SuccessLoadAllParameterState) {
              if (state.message != null && state.message.isNotEmpty)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
            }
          },
          child: BlocBuilder<ParameterCubit, ParameterState>(
            builder: (_, state) {
              if (state is LoadingParameterState) {
                return Center(
                  child: Platform.isIOS
                      ? CupertinoActivityIndicator()
                      : CircularProgressIndicator(),
                );
              } else if (state is FailureLoadAllParameterState) {
                return Center(
                  child: Text(state.errorMessage),
                );
              } else if (state is SuccessLoadAllParameterState) {
                var listParameters = state.listParameters;
                return ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: listParameters.length,
                  itemBuilder: (_, index) {
                    var parameterData = listParameters[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              parameterData.nama,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              parameterData.ambangbatas,
                              style: Theme.of(context).textTheme.caption,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  child: Text('EDIT'),
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue),
                                  ),
                                  onPressed: () async {
                                    var result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => AddEditParameter(
                                          parameterData: parameterData,
                                        ),
                                      ),
                                    );
                                    if (result != null) {
                                      parameterCubit.getAllParameters();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
