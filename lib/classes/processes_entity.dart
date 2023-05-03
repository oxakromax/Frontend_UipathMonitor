import 'dart:convert';

import 'package:UipathMonitor/generated/json/base/json_field.dart';
import 'package:UipathMonitor/generated/json/processes_entity.g.dart';

@JsonSerializable()
class ProcessesEntity {
  @JSONField(name: "ID")
  double? iD;
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
  double? folderid;
  @JSONField(name: "Foldername")
  String? foldername;
  @JSONField(name: "OrganizacionID")
  double? organizacionID;
  @JSONField(name: "WarningTolerance")
  double? warningTolerance;
  @JSONField(name: "ErrorTolerance")
  double? errorTolerance;
  @JSONField(name: "FatalTolerance")
  double? fatalTolerance;
  @JSONField(name: "Organizacion")
  ProcessesOrganizacion? organizacion;
  @JSONField(name: "IncidentesProceso")
  List<ProcessesIncidentesProceso>? incidentesProceso;
  @JSONField(name: "Clientes")
  List<ProcessesClientes>? clientes;
  @JSONField(name: "Usuarios")
  List<ProcessesUsuarios>? usuarios;

  ProcessesEntity();

  factory ProcessesEntity.fromJson(Map<String, dynamic> json) =>
      $ProcessesEntityFromJson(json);

  Map<String, dynamic> toJson() => $ProcessesEntityToJson(this);

  ProcessesEntity copyWith(
      {double? iD,
      String? createdAt,
      String? updatedAt,
      dynamic deletedAt,
      String? nombre,
      String? alias,
      double? folderid,
      String? foldername,
      double? organizacionID,
      double? warningTolerance,
      double? errorTolerance,
      double? fatalTolerance,
      ProcessesOrganizacion? organizacion,
      List<ProcessesIncidentesProceso>? incidentesProceso,
      List<ProcessesClientes>? clientes,
      List<ProcessesUsuarios>? usuarios}) {
    return ProcessesEntity()
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
class ProcessesOrganizacion {
  @JSONField(name: "ID")
  double? iD;
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

  ProcessesOrganizacion();

  factory ProcessesOrganizacion.fromJson(Map<String, dynamic> json) =>
      $ProcessesOrganizacionFromJson(json);

  Map<String, dynamic> toJson() => $ProcessesOrganizacionToJson(this);

  ProcessesOrganizacion copyWith(
      {double? iD,
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
    return ProcessesOrganizacion()
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
class ProcessesIncidentesProceso {
  @JSONField(name: "ID")
  double? iD;
  @JSONField(name: "CreatedAt")
  String? createdAt;
  @JSONField(name: "UpdatedAt")
  String? updatedAt;
  @JSONField(name: "DeletedAt")
  dynamic deletedAt;
  @JSONField(name: "ProcesoID")
  double? procesoID;
  @JSONField(name: "Proceso")
  dynamic proceso;
  @JSONField(name: "Incidente")
  String? incidente;
  @JSONField(name: "Tipo")
  double? tipo;
  @JSONField(name: "Estado")
  double? estado;
  @JSONField(name: "Detalles")
  List<ProcessesIncidentesProcesoDetalles>? detalles;

  ProcessesIncidentesProceso();

  factory ProcessesIncidentesProceso.fromJson(Map<String, dynamic> json) =>
      $ProcessesIncidentesProcesoFromJson(json);

  Map<String, dynamic> toJson() => $ProcessesIncidentesProcesoToJson(this);

  ProcessesIncidentesProceso copyWith(
      {double? iD,
      String? createdAt,
      String? updatedAt,
      dynamic deletedAt,
      double? procesoID,
      dynamic proceso,
      String? incidente,
      double? tipo,
      double? estado,
      List<ProcessesIncidentesProcesoDetalles>? detalles}) {
    return ProcessesIncidentesProceso()
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
class ProcessesIncidentesProcesoDetalles {
  @JSONField(name: "ID")
  double? iD;
  @JSONField(name: "CreatedAt")
  String? createdAt;
  @JSONField(name: "UpdatedAt")
  String? updatedAt;
  @JSONField(name: "DeletedAt")
  dynamic deletedAt;
  @JSONField(name: "IncidenteID")
  double? incidenteID;
  @JSONField(name: "Detalle")
  String? detalle;
  @JSONField(name: "FechaInicio")
  String? fechaInicio;
  @JSONField(name: "FechaFin")
  String? fechaFin;

  ProcessesIncidentesProcesoDetalles();

  factory ProcessesIncidentesProcesoDetalles.fromJson(
          Map<String, dynamic> json) =>
      $ProcessesIncidentesProcesoDetallesFromJson(json);

  Map<String, dynamic> toJson() =>
      $ProcessesIncidentesProcesoDetallesToJson(this);

  ProcessesIncidentesProcesoDetalles copyWith(
      {double? iD,
      String? createdAt,
      String? updatedAt,
      dynamic deletedAt,
      double? incidenteID,
      String? detalle,
      String? fechaInicio,
      String? fechaFin}) {
    return ProcessesIncidentesProcesoDetalles()
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
class ProcessesClientes {
  @JSONField(name: "ID")
  double? iD;
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
  double? organizacionID;
  @JSONField(name: "Organizacion")
  dynamic organizacion;
  @JSONField(name: "Procesos")
  dynamic procesos;

  ProcessesClientes();

  factory ProcessesClientes.fromJson(Map<String, dynamic> json) =>
      $ProcessesClientesFromJson(json);

  Map<String, dynamic> toJson() => $ProcessesClientesToJson(this);

  ProcessesClientes copyWith(
      {double? iD,
      String? createdAt,
      String? updatedAt,
      dynamic deletedAt,
      String? nombre,
      String? apellido,
      String? email,
      double? organizacionID,
      dynamic organizacion,
      dynamic procesos}) {
    return ProcessesClientes()
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
class ProcessesUsuarios {
  @JSONField(name: "ID")
  double? iD;
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

  ProcessesUsuarios();

  factory ProcessesUsuarios.fromJson(Map<String, dynamic> json) =>
      $ProcessesUsuariosFromJson(json);

  Map<String, dynamic> toJson() => $ProcessesUsuariosToJson(this);

  ProcessesUsuarios copyWith(
      {double? iD,
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
    return ProcessesUsuarios()
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
