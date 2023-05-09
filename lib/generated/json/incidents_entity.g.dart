import 'package:UipathMonitor/classes/incidents_entity.dart';
import 'package:UipathMonitor/classes/processes_entity.dart';
import 'package:UipathMonitor/generated/json/base/json_convert_content.dart';

IncidentsEntity $IncidentsEntityFromJson(Map<String, dynamic> json) {
  final IncidentsEntity incidentsEntity = IncidentsEntity();
  final List<ProcessesEntity>? finished =
      jsonConvert.convertListNotNull<ProcessesEntity>(json['finished']);
  if (finished != null) {
    incidentsEntity.finished = finished;
  }
  final List<ProcessesEntity>? ongoing =
      jsonConvert.convertListNotNull<ProcessesEntity>(json['ongoing']);
  if (ongoing != null) {
    incidentsEntity.ongoing = ongoing;
  }
  return incidentsEntity;
}

Map<String, dynamic> $IncidentsEntityToJson(IncidentsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['finished'] = entity.finished?.map((v) => v.toJson()).toList();
  data['ongoing'] = entity.ongoing?.map((v) => v.toJson()).toList();
  return data;
}
