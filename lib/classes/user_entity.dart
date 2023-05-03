import 'dart:convert';

import 'package:UipathMonitor/generated/json/base/json_field.dart';
import 'package:UipathMonitor/generated/json/user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  @JSONField(name: "ID")
  int? iD;
  @JSONField(name: "CreatedAt")
  String? createdAt;
  @JSONField(name: "UpdatedAt")
  String? updatedAt;
  @JSONField(name: "DeletedAt")
  String? deletedAt;
  @JSONField(name: "Nombre")
  String? nombre;
  @JSONField(name: "Apellido")
  String? apellido;
  @JSONField(name: "Email")
  String? email;
  @JSONField(name: "Password")
  String? password;
  @JSONField(name: "Roles")
  List<UserRoles>? roles;
  @JSONField(name: "Procesos")
  List<UserProcesos>? procesos;
  @JSONField(name: "Organizaciones")
  List<UserOrganizaciones>? organizaciones;

  UserEntity();

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      $UserEntityFromJson(json);

  Map<String, dynamic> toJson() => $UserEntityToJson(this);

  UserEntity copyWith(
      {int? iD,
      String? createdAt,
      String? updatedAt,
      dynamic deletedAt,
      String? nombre,
      String? apellido,
      String? email,
      String? password,
      List<UserRoles>? roles,
      List<UserProcesos>? procesos,
      List<UserOrganizaciones>? organizaciones}) {
    return UserEntity()
      ..iD = iD ?? this.iD
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..deletedAt = deletedAt ?? this.deletedAt
      ..nombre = nombre ?? this.nombre
      ..apellido = apellido ?? this.apellido
      ..email = email ?? this.email
      ..password = password ?? this.password
      ..roles = roles ?? this.roles
      ..procesos = procesos ?? this.procesos
      ..organizaciones = organizaciones ?? this.organizaciones;
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UserRoles {
  @JSONField(name: "ID")
  int? iD;
  @JSONField(name: "CreatedAt")
  String? createdAt;
  @JSONField(name: "UpdatedAt")
  String? updatedAt;
  @JSONField(name: "DeletedAt")
  dynamic deletedAt;
  @JSONField(name: "Nombre")
  String? nombre;
  @JSONField(name: "Description")
  String? description;
  @JSONField(name: "Usuarios")
  dynamic usuarios;
  @JSONField(name: "Rutas")
  List<UserRolesRutas>? rutas;

  UserRoles();

  factory UserRoles.fromJson(Map<String, dynamic> json) =>
      $UserRolesFromJson(json);

  Map<String, dynamic> toJson() => $UserRolesToJson(this);

  UserRoles copyWith(
      {int? iD,
      String? createdAt,
      String? updatedAt,
      dynamic deletedAt,
      String? nombre,
      String? description,
      dynamic usuarios,
      List<UserRolesRutas>? rutas}) {
    return UserRoles()
      ..iD = iD ?? this.iD
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..deletedAt = deletedAt ?? this.deletedAt
      ..nombre = nombre ?? this.nombre
      ..description = description ?? this.description
      ..usuarios = usuarios ?? this.usuarios
      ..rutas = rutas ?? this.rutas;
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UserRolesRutas {
  @JSONField(name: "ID")
  int? iD;
  @JSONField(name: "CreatedAt")
  String? createdAt;
  @JSONField(name: "UpdatedAt")
  String? updatedAt;
  @JSONField(name: "DeletedAt")
  dynamic deletedAt;
  @JSONField(name: "Method")
  String? method;
  @JSONField(name: "Route")
  String? route;
  @JSONField(name: "Roles")
  dynamic roles;

  UserRolesRutas();

  factory UserRolesRutas.fromJson(Map<String, dynamic> json) =>
      $UserRolesRutasFromJson(json);

  Map<String, dynamic> toJson() => $UserRolesRutasToJson(this);

  UserRolesRutas copyWith(
      {int? iD,
      String? createdAt,
      String? updatedAt,
      dynamic deletedAt,
      String? method,
      String? route,
      dynamic roles}) {
    return UserRolesRutas()
      ..iD = iD ?? this.iD
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..deletedAt = deletedAt ?? this.deletedAt
      ..method = method ?? this.method
      ..route = route ?? this.route
      ..roles = roles ?? this.roles;
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UserProcesos {
  @JSONField(name: "ID")
  int? iD;
  @JSONField(name: "CreatedAt")
  String? createdAt;
  @JSONField(name: "UpdatedAt")
  String? updatedAt;
  @JSONField(name: "DeletedAt")
  dynamic deletedAt;
  @JSONField(name: "Nombre")
  String? nombre;
  @JSONField(name: "Alias")
  String? alias;
  @JSONField(name: "Folderid")
  int? folderid;
  @JSONField(name: "Foldername")
  String? foldername;
  @JSONField(name: "OrganizacionID")
  int? organizacionID;
  @JSONField(name: "WarningTolerance")
  int? warningTolerance;
  @JSONField(name: "ErrorTolerance")
  int? errorTolerance;
  @JSONField(name: "FatalTolerance")
  int? fatalTolerance;
  @JSONField(name: "Organizacion")
  dynamic organizacion;
  @JSONField(name: "IncidentesProceso")
  dynamic incidentesProceso;
  @JSONField(name: "Clientes")
  dynamic clientes;
  @JSONField(name: "Usuarios")
  dynamic usuarios;

  UserProcesos();

  factory UserProcesos.fromJson(Map<String, dynamic> json) =>
      $UserProcesosFromJson(json);

  Map<String, dynamic> toJson() => $UserProcesosToJson(this);

  UserProcesos copyWith(
      {int? iD,
      String? createdAt,
      String? updatedAt,
      dynamic deletedAt,
      String? nombre,
      String? alias,
      int? folderid,
      String? foldername,
      int? organizacionID,
      int? warningTolerance,
      int? errorTolerance,
      int? fatalTolerance,
      dynamic organizacion,
      dynamic incidentesProceso,
      dynamic clientes,
      dynamic usuarios}) {
    return UserProcesos()
      ..iD = iD ?? this.iD
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..deletedAt = deletedAt ?? this.deletedAt
      ..nombre = nombre ?? this.nombre
      ..alias = alias ?? this.alias
      ..folderid = folderid ?? this.folderid
      ..foldername = foldername ?? this.foldername
      ..organizacionID = organizacionID ?? this.organizacionID
      ..warningTolerance = warningTolerance ?? this.warningTolerance
      ..errorTolerance = errorTolerance ?? this.errorTolerance
      ..fatalTolerance = fatalTolerance ?? this.fatalTolerance
      ..organizacion = organizacion ?? this.organizacion
      ..incidentesProceso = incidentesProceso ?? this.incidentesProceso
      ..clientes = clientes ?? this.clientes
      ..usuarios = usuarios ?? this.usuarios;
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UserOrganizaciones {
  @JSONField(name: "ID")
  int? iD;
  @JSONField(name: "CreatedAt")
  String? createdAt;
  @JSONField(name: "UpdatedAt")
  String? updatedAt;
  @JSONField(name: "DeletedAt")
  dynamic deletedAt;
  @JSONField(name: "Nombre")
  String? nombre;
  @JSONField(name: "Uipathname")
  String? uipathname;
  @JSONField(name: "Tenantname")
  String? tenantname;
  @JSONField(name: "AppID")
  String? appID;
  @JSONField(name: "AppSecret")
  String? appSecret;
  @JSONField(name: "AppScope")
  String? appScope;
  @JSONField(name: "BaseURL")
  String? baseURL;
  @JSONField(name: "Clientes")
  dynamic clientes;
  @JSONField(name: "Procesos")
  List<UserOrganizacionesProcesos>? procesos;
  @JSONField(name: "Usuarios")
  dynamic usuarios;

  UserOrganizaciones();

  factory UserOrganizaciones.fromJson(Map<String, dynamic> json) =>
      $UserOrganizacionesFromJson(json);

  Map<String, dynamic> toJson() => $UserOrganizacionesToJson(this);

  UserOrganizaciones copyWith(
      {int? iD,
      String? createdAt,
      String? updatedAt,
      dynamic deletedAt,
      String? nombre,
      String? uipathname,
      String? tenantname,
      String? appID,
      String? appSecret,
      String? appScope,
      String? baseURL,
      dynamic clientes,
      List<UserOrganizacionesProcesos>? procesos,
      dynamic usuarios}) {
    return UserOrganizaciones()
      ..iD = iD ?? this.iD
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..deletedAt = deletedAt ?? this.deletedAt
      ..nombre = nombre ?? this.nombre
      ..uipathname = uipathname ?? this.uipathname
      ..tenantname = tenantname ?? this.tenantname
      ..appID = appID ?? this.appID
      ..appSecret = appSecret ?? this.appSecret
      ..appScope = appScope ?? this.appScope
      ..baseURL = baseURL ?? this.baseURL
      ..clientes = clientes ?? this.clientes
      ..procesos = procesos ?? this.procesos
      ..usuarios = usuarios ?? this.usuarios;
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UserOrganizacionesProcesos {
  @JSONField(name: "ID")
  int? iD;
  @JSONField(name: "CreatedAt")
  String? createdAt;
  @JSONField(name: "UpdatedAt")
  String? updatedAt;
  @JSONField(name: "DeletedAt")
  dynamic deletedAt;
  @JSONField(name: "Nombre")
  String? nombre;
  @JSONField(name: "Alias")
  String? alias;
  @JSONField(name: "Folderid")
  int? folderid;
  @JSONField(name: "Foldername")
  String? foldername;
  @JSONField(name: "OrganizacionID")
  int? organizacionID;
  @JSONField(name: "WarningTolerance")
  int? warningTolerance;
  @JSONField(name: "ErrorTolerance")
  int? errorTolerance;
  @JSONField(name: "FatalTolerance")
  int? fatalTolerance;
  @JSONField(name: "Organizacion")
  dynamic organizacion;
  @JSONField(name: "IncidentesProceso")
  dynamic incidentesProceso;
  @JSONField(name: "Clientes")
  dynamic clientes;
  @JSONField(name: "Usuarios")
  dynamic usuarios;

  UserOrganizacionesProcesos();

  factory UserOrganizacionesProcesos.fromJson(Map<String, dynamic> json) =>
      $UserOrganizacionesProcesosFromJson(json);

  Map<String, dynamic> toJson() => $UserOrganizacionesProcesosToJson(this);

  UserOrganizacionesProcesos copyWith(
      {int? iD,
      String? createdAt,
      String? updatedAt,
      dynamic deletedAt,
      String? nombre,
      String? alias,
      int? folderid,
      String? foldername,
      int? organizacionID,
      int? warningTolerance,
      int? errorTolerance,
      int? fatalTolerance,
      dynamic organizacion,
      dynamic incidentesProceso,
      dynamic clientes,
      dynamic usuarios}) {
    return UserOrganizacionesProcesos()
      ..iD = iD ?? this.iD
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..deletedAt = deletedAt ?? this.deletedAt
      ..nombre = nombre ?? this.nombre
      ..alias = alias ?? this.alias
      ..folderid = folderid ?? this.folderid
      ..foldername = foldername ?? this.foldername
      ..organizacionID = organizacionID ?? this.organizacionID
      ..warningTolerance = warningTolerance ?? this.warningTolerance
      ..errorTolerance = errorTolerance ?? this.errorTolerance
      ..fatalTolerance = fatalTolerance ?? this.fatalTolerance
      ..organizacion = organizacion ?? this.organizacion
      ..incidentesProceso = incidentesProceso ?? this.incidentesProceso
      ..clientes = clientes ?? this.clientes
      ..usuarios = usuarios ?? this.usuarios;
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}
