import 'dart:convert';

import 'package:UipathMonitor/classes/processes_entity.dart';
import 'package:UipathMonitor/generated/json/base/json_field.dart';
import 'package:UipathMonitor/generated/json/incidents_entity.g.dart';

@JsonSerializable()
class IncidentsEntity {
  List<ProcessesEntity>? finished;
  List<ProcessesEntity>? ongoing;

  IncidentsEntity();

  factory IncidentsEntity.fromJson(Map<String, dynamic> json) =>
      $IncidentsEntityFromJson(json);

  Map<String, dynamic> toJson() => $IncidentsEntityToJson(this);

  IncidentsEntity copyWith(
      {List<ProcessesEntity>? finished, List<ProcessesEntity>? ongoing}) {
    return IncidentsEntity()
      ..finished = finished ?? this.finished
      ..ongoing = ongoing ?? this.ongoing;
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}
