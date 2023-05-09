import 'package:UipathMonitor/classes/organizations_entity.dart';
import 'package:UipathMonitor/generated/json/base/json_convert_content.dart';

OrganizationsEntity $OrganizationsEntityFromJson(Map<String, dynamic> json) {
  final OrganizationsEntity organizationsEntity = OrganizationsEntity();
  final double? id = jsonConvert.convert<double>(json['ID']);
  if (id != null) {
    organizationsEntity.id = id;
  }
  final String? createdAt = jsonConvert.convert<String>(json['CreatedAt']);
  if (createdAt != null) {
    organizationsEntity.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['UpdatedAt']);
  if (updatedAt != null) {
    organizationsEntity.updatedAt = updatedAt;
  }
  final dynamic deletedAt = jsonConvert.convert<dynamic>(json['DeletedAt']);
  if (deletedAt != null) {
    organizationsEntity.deletedAt = deletedAt;
  }
  final String? nombre = jsonConvert.convert<String>(json['Nombre']);
  if (nombre != null) {
    organizationsEntity.nombre = nombre;
  }
  final String? uipathname = jsonConvert.convert<String>(json['Uipathname']);
  if (uipathname != null) {
    organizationsEntity.uipathname = uipathname;
  }
  final String? tenantname = jsonConvert.convert<String>(json['Tenantname']);
  if (tenantname != null) {
    organizationsEntity.tenantname = tenantname;
  }
  final String? appID = jsonConvert.convert<String>(json['AppID']);
  if (appID != null) {
    organizationsEntity.appID = appID;
  }
  final String? appSecret = jsonConvert.convert<String>(json['AppSecret']);
  if (appSecret != null) {
    organizationsEntity.appSecret = appSecret;
  }
  final String? appScope = jsonConvert.convert<String>(json['AppScope']);
  if (appScope != null) {
    organizationsEntity.appScope = appScope;
  }
  final String? baseURL = jsonConvert.convert<String>(json['BaseURL']);
  if (baseURL != null) {
    organizationsEntity.baseURL = baseURL;
  }
  final dynamic clientes = jsonConvert.convert<dynamic>(json['Clientes']);
  if (clientes != null) {
    organizationsEntity.clientes = clientes;
  }
  final dynamic procesos = jsonConvert.convert<dynamic>(json['Procesos']);
  if (procesos != null) {
    organizationsEntity.procesos = procesos;
  }
  final dynamic usuarios = jsonConvert.convert<dynamic>(json['Usuarios']);
  if (usuarios != null) {
    organizationsEntity.usuarios = usuarios;
  }
  return organizationsEntity;
}

Map<String, dynamic> $OrganizationsEntityToJson(OrganizationsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ID'] = entity.id;
  data['CreatedAt'] = entity.createdAt;
  data['UpdatedAt'] = entity.updatedAt;
  data['DeletedAt'] = entity.deletedAt;
  data['Nombre'] = entity.nombre;
  data['Uipathname'] = entity.uipathname;
  data['Tenantname'] = entity.tenantname;
  data['AppID'] = entity.appID;
  data['AppSecret'] = entity.appSecret;
  data['AppScope'] = entity.appScope;
  data['BaseURL'] = entity.baseURL;
  data['Clientes'] = entity.clientes;
  data['Procesos'] = entity.procesos;
  data['Usuarios'] = entity.usuarios;
  return data;
}
