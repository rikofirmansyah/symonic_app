// ignore: import_of_legacy_library_into_null_safe
import 'package:json_annotation/json_annotation.dart';

part 'parameter.g.dart';

@JsonSerializable()
class ParameterData {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'nama')
  final String nama;
  @JsonKey(name: 'ambangbatas')
  final String ambangbatas;

  ParameterData({
    required this.id,
    required this.nama,
    required this.ambangbatas,
  });

  factory ParameterData.fromJson(Map<String, dynamic> json) =>
      _$ParameterDataFromJson(json);

  Map<String, dynamic> toJson() => _$ParameterDataToJson(this);

  @override
  String toString() {
    return 'ParameterData{id: $id, nama: $nama, ambangbatas: $ambangbatas}';
  }
}
