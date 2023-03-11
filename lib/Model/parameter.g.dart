// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParameterData _$ParameterDataFromJson(Map<String, dynamic> json) {
  return ParameterData(
    id: json['id'] as int,
    nama: json['nama'] as String,
    ambangbatas: json['ambangbatas'] as String,
  );
}

Map<String, dynamic> _$ParameterDataToJson(ParameterData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
      'ambangbatas': instance.ambangbatas,
    };
