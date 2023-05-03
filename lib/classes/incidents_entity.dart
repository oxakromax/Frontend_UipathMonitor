import 'dart:convert';

import 'package:UipathMonitor/generated/json/base/json_field.dart';
import 'package:UipathMonitor/generated/json/incidents_entity.g.dart';

@JsonSerializable()
class IncidentsEntity {
  List<ProcessesWithIncidents>? finished;
  List<ProcessesWithIncidents>? ongoing;

  IncidentsEntity();

  factory IncidentsEntity.fromJson(Map<String, dynamic> json) =>
      $IncidentsEntityFromJson(json);

  Map<String, dynamic> toJson() => $IncidentsEntityToJson(this);

  IncidentsEntity copyWith(
      {List<ProcessesWithIncidents>? finished,
      List<ProcessesWithIncidents>? ongoing}) {
    return IncidentsEntity()
      ..finished = finished ?? this.finished
      ..ongoing = ongoing ?? this.ongoing;
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ProcessesWithIncidents {
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
  ProcessOrg? organizacion;
  @JSONField(name: "IncidentesProceso")
  List<IncidentsProcess>? incidentesProceso;
  @JSONField(name: "Clientes")
  List<IncidentsClients>? clientes;
  @JSONField(name: "Usuarios")
  List<IncidentsUsers>? usuarios;

  ProcessesWithIncidents();

  factory ProcessesWithIncidents.fromJson(Map<String, dynamic> json) =>
      $IncidentsFinishedFromJson(json);

  Map<String, dynamic> toJson() => $IncidentsFinishedToJson(this);

  ProcessesWithIncidents copyWith(
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
      ProcessOrg? organizacion,
      List<IncidentsProcess>? incidentesProceso,
      List<IncidentsClients>? clientes,
      List<IncidentsUsers>? usuarios}) {
    return ProcessesWithIncidents()
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
class ProcessOrg {
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
  dynamic procesos;
  @JSONField(name: "Usuarios")
  dynamic usuarios;

  ProcessOrg();

  factory ProcessOrg.fromJson(Map<String, dynamic> json) =>
      $IncidentsFinishedOrganizacionFromJson(json);

  Map<String, dynamic> toJson() => $IncidentsFinishedOrganizacionToJson(this);

  ProcessOrg copyWith(
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
      dynamic procesos,
      dynamic usuarios}) {
    return ProcessOrg()
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
class IncidentsProcess {
  @JSONField(name: "ID")
  int? iD;
  @JSONField(name: "CreatedAt")
  String? createdAt;
  @JSONField(name: "UpdatedAt")
  String? updatedAt;
  @JSONField(name: "DeletedAt")
  dynamic deletedAt;
  @JSONField(name: "ProcesoID")
  int? procesoID;
  @JSONField(name: "Proceso")
  dynamic proceso;
  @JSONField(name: "Incidente")
  String? incidente;
  @JSONField(name: "Tipo")
  int? tipo;
  @JSONField(name: "Estado")
  int? estado;
  @JSONField(name: "Detalles")
  List<IncidentsProcessDetails>? detalles;

  IncidentsProcess();

  factory IncidentsProcess.fromJson(Map<String, dynamic> json) =>
      $IncidentsFinishedIncidentesProcesoFromJson(json);

  Map<String, dynamic> toJson() =>
      $IncidentsFinishedIncidentesProcesoToJson(this);

  IncidentsProcess copyWith(
      {int? iD,
      String? createdAt,
      String? updatedAt,
      dynamic deletedAt,
      int? procesoID,
      dynamic proceso,
      String? incidente,
      int? tipo,
      int? estado,
      List<IncidentsProcessDetails>? detalles}) {
    return IncidentsProcess()
      ..iD = iD ?? this.iD
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..deletedAt = deletedAt ?? this.deletedAt
      ..procesoID = procesoID ?? this.procesoID
      ..proceso = proceso ?? this.proceso
      ..incidente = incidente ?? this.incidente
      ..tipo = tipo ?? this.tipo
      ..estado = estado ?? this.estado
      ..detalles = detalles ?? this.detalles;
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class IncidentsProcessDetails {
  @JSONField(name: "ID")
  int? iD;
  @JSONField(name: "CreatedAt")
  String? createdAt;
  @JSONField(name: "UpdatedAt")
  String? updatedAt;
  @JSONField(name: "DeletedAt")
  dynamic deletedAt;
  @JSONField(name: "IncidenteID")
  int? incidenteID;
  @JSONField(name: "Detalle")
  String? detalle;
  @JSONField(name: "FechaInicio")
  String? fechaInicio;
  @JSONField(name: "FechaFin")
  String? fechaFin;

  IncidentsProcessDetails();

  factory IncidentsProcessDetails.fromJson(Map<String, dynamic> json) =>
      $IncidentsFinishedIncidentesProcesoDetallesFromJson(json);

  Map<String, dynamic> toJson() =>
      $IncidentsFinishedIncidentesProcesoDetallesToJson(this);

  IncidentsProcessDetails copyWith(
      {int? iD,
      String? createdAt,
      String? updatedAt,
      dynamic deletedAt,
      int? incidenteID,
      String? detalle,
      String? fechaInicio,
      String? fechaFin}) {
    return IncidentsProcessDetails()
      ..iD = iD ?? this.iD
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..deletedAt = deletedAt ?? this.deletedAt
      ..incidenteID = incidenteID ?? this.incidenteID
      ..detalle = detalle ?? this.detalle
      ..fechaInicio = fechaInicio ?? this.fechaInicio
      ..fechaFin = fechaFin ?? this.fechaFin;
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class IncidentsClients {
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
  @JSONField(name: "Apellido")
  String? apellido;
  @JSONField(name: "Email")
  String? email;
  @JSONField(name: "OrganizacionID")
  int? organizacionID;
  @JSONField(name: "Organizacion")
  dynamic organizacion;
  @JSONField(name: "Procesos")
  dynamic procesos;

  IncidentsClients();

  factory IncidentsClients.fromJson(Map<String, dynamic> json) =>
      $IncidentsFinishedClientesFromJson(json);

  Map<String, dynamic> toJson() => $IncidentsFinishedClientesToJson(this);

  IncidentsClients copyWith(
      {int? iD,
      String? createdAt,
      String? updatedAt,
      dynamic deletedAt,
      String? nombre,
      String? apellido,
      String? email,
      int? organizacionID,
      dynamic organizacion,
      dynamic procesos}) {
    return IncidentsClients()
      ..iD = iD ?? this.iD
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..deletedAt = deletedAt ?? this.deletedAt
      ..nombre = nombre ?? this.nombre
      ..apellido = apellido ?? this.apellido
      ..email = email ?? this.email
      ..organizacionID = organizacionID ?? this.organizacionID
      ..organizacion = organizacion ?? this.organizacion
      ..procesos = procesos ?? this.procesos;
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class IncidentsUsers {
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
  @JSONField(name: "Apellido")
  String? apellido;
  @JSONField(name: "Email")
  String? email;
  @JSONField(name: "Password")
  String? password;
  @JSONField(name: "Roles")
  dynamic roles;
  @JSONField(name: "Procesos")
  dynamic procesos;
  @JSONField(name: "Organizaciones")
  dynamic organizaciones;

  IncidentsUsers();

  factory IncidentsUsers.fromJson(Map<String, dynamic> json) =>
      $IncidentsFinishedUsuariosFromJson(json);

  Map<String, dynamic> toJson() => $IncidentsFinishedUsuariosToJson(this);

  IncidentsUsers copyWith(
      {int? iD,
      String? createdAt,
      String? updatedAt,
      dynamic deletedAt,
      String? nombre,
      String? apellido,
      String? email,
      String? password,
      dynamic roles,
      dynamic procesos,
      dynamic organizaciones}) {
    return IncidentsUsers()
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
