import 'package:UipathMonitor/classes/incidents_entity.dart';
import 'package:UipathMonitor/generated/json/base/json_convert_content.dart';

IncidentsEntity $IncidentsEntityFromJson(Map<String, dynamic> json) {
  final IncidentsEntity incidentsEntity = IncidentsEntity();
  final List<ProcessesWithIncidents>? finished =
      jsonConvert.convertListNotNull<ProcessesWithIncidents>(json['finished']);
  if (finished != null) {
    incidentsEntity.finished = finished;
  }
  final List<ProcessesWithIncidents>? ongoing =
      jsonConvert.convertListNotNull<ProcessesWithIncidents>(json['ongoing']);
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

ProcessesWithIncidents $IncidentsFinishedFromJson(Map<String, dynamic> json) {
  final ProcessesWithIncidents incidentsFinished = ProcessesWithIncidents();
  final int? iD = jsonConvert.convert<int>(json['ID']);
  if (iD != null) {
    incidentsFinished.iD = iD;
  }
  final String? createdAt = jsonConvert.convert<String>(json['CreatedAt']);
  if (createdAt != null) {
    incidentsFinished.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['UpdatedAt']);
  if (updatedAt != null) {
    incidentsFinished.updatedAt = updatedAt;
  }
  final dynamic deletedAt = jsonConvert.convert<dynamic>(json['DeletedAt']);
  if (deletedAt != null) {
    incidentsFinished.deletedAt = deletedAt;
  }
  final String? nombre = jsonConvert.convert<String>(json['Nombre']);
  if (nombre != null) {
    incidentsFinished.nombre = nombre;
  }
  final String? alias = jsonConvert.convert<String>(json['Alias']);
  if (alias != null) {
    incidentsFinished.alias = alias;
  }
  final int? folderid = jsonConvert.convert<int>(json['Folderid']);
  if (folderid != null) {
    incidentsFinished.folderid = folderid;
  }
  final String? foldername = jsonConvert.convert<String>(json['Foldername']);
  if (foldername != null) {
    incidentsFinished.foldername = foldername;
  }
  final int? organizacionID = jsonConvert.convert<int>(json['OrganizacionID']);
  if (organizacionID != null) {
    incidentsFinished.organizacionID = organizacionID;
  }
  final int? warningTolerance =
      jsonConvert.convert<int>(json['WarningTolerance']);
  if (warningTolerance != null) {
    incidentsFinished.warningTolerance = warningTolerance;
  }
  final int? errorTolerance = jsonConvert.convert<int>(json['ErrorTolerance']);
  if (errorTolerance != null) {
    incidentsFinished.errorTolerance = errorTolerance;
  }
  final int? fatalTolerance = jsonConvert.convert<int>(json['FatalTolerance']);
  if (fatalTolerance != null) {
    incidentsFinished.fatalTolerance = fatalTolerance;
  }
  final ProcessOrg? organizacion =
      jsonConvert.convert<ProcessOrg>(json['Organizacion']);
  if (organizacion != null) {
    incidentsFinished.organizacion = organizacion;
  }
  final List<IncidentsProcess>? incidentesProceso = jsonConvert
      .convertListNotNull<IncidentsProcess>(json['IncidentesProceso']);
  if (incidentesProceso != null) {
    incidentsFinished.incidentesProceso = incidentesProceso;
  }
  final List<IncidentsClients>? clientes =
      jsonConvert.convertListNotNull<IncidentsClients>(json['Clientes']);
  if (clientes != null) {
    incidentsFinished.clientes = clientes;
  }
  final List<IncidentsUsers>? usuarios =
      jsonConvert.convertListNotNull<IncidentsUsers>(json['Usuarios']);
  if (usuarios != null) {
    incidentsFinished.usuarios = usuarios;
  }
  return incidentsFinished;
}

Map<String, dynamic> $IncidentsFinishedToJson(ProcessesWithIncidents entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ID'] = entity.iD;
  data['CreatedAt'] = entity.createdAt;
  data['UpdatedAt'] = entity.updatedAt;
  data['DeletedAt'] = entity.deletedAt;
  data['Nombre'] = entity.nombre;
  data['Alias'] = entity.alias;
  data['Folderid'] = entity.folderid;
  data['Foldername'] = entity.foldername;
  data['OrganizacionID'] = entity.organizacionID;
  data['WarningTolerance'] = entity.warningTolerance;
  data['ErrorTolerance'] = entity.errorTolerance;
  data['FatalTolerance'] = entity.fatalTolerance;
  data['Organizacion'] = entity.organizacion?.toJson();
  data['IncidentesProceso'] =
      entity.incidentesProceso?.map((v) => v.toJson()).toList();
  data['Clientes'] = entity.clientes?.map((v) => v.toJson()).toList();
  data['Usuarios'] = entity.usuarios?.map((v) => v.toJson()).toList();
  return data;
}

ProcessOrg $IncidentsFinishedOrganizacionFromJson(Map<String, dynamic> json) {
  final ProcessOrg incidentsFinishedOrganizacion = ProcessOrg();
  final int? iD = jsonConvert.convert<int>(json['ID']);
  if (iD != null) {
    incidentsFinishedOrganizacion.iD = iD;
  }
  final String? createdAt = jsonConvert.convert<String>(json['CreatedAt']);
  if (createdAt != null) {
    incidentsFinishedOrganizacion.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['UpdatedAt']);
  if (updatedAt != null) {
    incidentsFinishedOrganizacion.updatedAt = updatedAt;
  }
  final dynamic deletedAt = jsonConvert.convert<dynamic>(json['DeletedAt']);
  if (deletedAt != null) {
    incidentsFinishedOrganizacion.deletedAt = deletedAt;
  }
  final String? nombre = jsonConvert.convert<String>(json['Nombre']);
  if (nombre != null) {
    incidentsFinishedOrganizacion.nombre = nombre;
  }
  final String? uipathname = jsonConvert.convert<String>(json['Uipathname']);
  if (uipathname != null) {
    incidentsFinishedOrganizacion.uipathname = uipathname;
  }
  final String? tenantname = jsonConvert.convert<String>(json['Tenantname']);
  if (tenantname != null) {
    incidentsFinishedOrganizacion.tenantname = tenantname;
  }
  final String? appID = jsonConvert.convert<String>(json['AppID']);
  if (appID != null) {
    incidentsFinishedOrganizacion.appID = appID;
  }
  final String? appSecret = jsonConvert.convert<String>(json['AppSecret']);
  if (appSecret != null) {
    incidentsFinishedOrganizacion.appSecret = appSecret;
  }
  final String? appScope = jsonConvert.convert<String>(json['AppScope']);
  if (appScope != null) {
    incidentsFinishedOrganizacion.appScope = appScope;
  }
  final String? baseURL = jsonConvert.convert<String>(json['BaseURL']);
  if (baseURL != null) {
    incidentsFinishedOrganizacion.baseURL = baseURL;
  }
  final dynamic clientes = jsonConvert.convert<dynamic>(json['Clientes']);
  if (clientes != null) {
    incidentsFinishedOrganizacion.clientes = clientes;
  }
  final dynamic procesos = jsonConvert.convert<dynamic>(json['Procesos']);
  if (procesos != null) {
    incidentsFinishedOrganizacion.procesos = procesos;
  }
  final dynamic usuarios = jsonConvert.convert<dynamic>(json['Usuarios']);
  if (usuarios != null) {
    incidentsFinishedOrganizacion.usuarios = usuarios;
  }
  return incidentsFinishedOrganizacion;
}

Map<String, dynamic> $IncidentsFinishedOrganizacionToJson(ProcessOrg entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ID'] = entity.iD;
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

IncidentsProcess $IncidentsFinishedIncidentesProcesoFromJson(
    Map<String, dynamic> json) {
  final IncidentsProcess incidentsFinishedIncidentesProceso =
      IncidentsProcess();
  final int? iD = jsonConvert.convert<int>(json['ID']);
  if (iD != null) {
    incidentsFinishedIncidentesProceso.iD = iD;
  }
  final String? createdAt = jsonConvert.convert<String>(json['CreatedAt']);
  if (createdAt != null) {
    incidentsFinishedIncidentesProceso.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['UpdatedAt']);
  if (updatedAt != null) {
    incidentsFinishedIncidentesProceso.updatedAt = updatedAt;
  }
  final dynamic deletedAt = jsonConvert.convert<dynamic>(json['DeletedAt']);
  if (deletedAt != null) {
    incidentsFinishedIncidentesProceso.deletedAt = deletedAt;
  }
  final int? procesoID = jsonConvert.convert<int>(json['ProcesoID']);
  if (procesoID != null) {
    incidentsFinishedIncidentesProceso.procesoID = procesoID;
  }
  final dynamic proceso = jsonConvert.convert<dynamic>(json['Proceso']);
  if (proceso != null) {
    incidentsFinishedIncidentesProceso.proceso = proceso;
  }
  final String? incidente = jsonConvert.convert<String>(json['Incidente']);
  if (incidente != null) {
    incidentsFinishedIncidentesProceso.incidente = incidente;
  }
  final int? tipo = jsonConvert.convert<int>(json['Tipo']);
  if (tipo != null) {
    incidentsFinishedIncidentesProceso.tipo = tipo;
  }
  final int? estado = jsonConvert.convert<int>(json['Estado']);
  if (estado != null) {
    incidentsFinishedIncidentesProceso.estado = estado;
  }
  final List<IncidentsProcessDetails>? detalles =
      jsonConvert.convertListNotNull<IncidentsProcessDetails>(json['Detalles']);
  if (detalles != null) {
    incidentsFinishedIncidentesProceso.detalles = detalles;
  }
  return incidentsFinishedIncidentesProceso;
}

Map<String, dynamic> $IncidentsFinishedIncidentesProcesoToJson(
    IncidentsProcess entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ID'] = entity.iD;
  data['CreatedAt'] = entity.createdAt;
  data['UpdatedAt'] = entity.updatedAt;
  data['DeletedAt'] = entity.deletedAt;
  data['ProcesoID'] = entity.procesoID;
  data['Proceso'] = entity.proceso;
  data['Incidente'] = entity.incidente;
  data['Tipo'] = entity.tipo;
  data['Estado'] = entity.estado;
  data['Detalles'] = entity.detalles?.map((v) => v.toJson()).toList();
  return data;
}

IncidentsProcessDetails $IncidentsFinishedIncidentesProcesoDetallesFromJson(
    Map<String, dynamic> json) {
  final IncidentsProcessDetails incidentsFinishedIncidentesProcesoDetalles =
      IncidentsProcessDetails();
  final int? iD = jsonConvert.convert<int>(json['ID']);
  if (iD != null) {
    incidentsFinishedIncidentesProcesoDetalles.iD = iD;
  }
  final String? createdAt = jsonConvert.convert<String>(json['CreatedAt']);
  if (createdAt != null) {
    incidentsFinishedIncidentesProcesoDetalles.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['UpdatedAt']);
  if (updatedAt != null) {
    incidentsFinishedIncidentesProcesoDetalles.updatedAt = updatedAt;
  }
  final dynamic deletedAt = jsonConvert.convert<dynamic>(json['DeletedAt']);
  if (deletedAt != null) {
    incidentsFinishedIncidentesProcesoDetalles.deletedAt = deletedAt;
  }
  final int? incidenteID = jsonConvert.convert<int>(json['IncidenteID']);
  if (incidenteID != null) {
    incidentsFinishedIncidentesProcesoDetalles.incidenteID = incidenteID;
  }
  final String? detalle = jsonConvert.convert<String>(json['Detalle']);
  if (detalle != null) {
    incidentsFinishedIncidentesProcesoDetalles.detalle = detalle;
  }
  final String? fechaInicio = jsonConvert.convert<String>(json['FechaInicio']);
  if (fechaInicio != null) {
    incidentsFinishedIncidentesProcesoDetalles.fechaInicio = fechaInicio;
  }
  final String? fechaFin = jsonConvert.convert<String>(json['FechaFin']);
  if (fechaFin != null) {
    incidentsFinishedIncidentesProcesoDetalles.fechaFin = fechaFin;
  }
  return incidentsFinishedIncidentesProcesoDetalles;
}

Map<String, dynamic> $IncidentsFinishedIncidentesProcesoDetallesToJson(
    IncidentsProcessDetails entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ID'] = entity.iD;
  data['CreatedAt'] = entity.createdAt;
  data['UpdatedAt'] = entity.updatedAt;
  data['DeletedAt'] = entity.deletedAt;
  data['IncidenteID'] = entity.incidenteID;
  data['Detalle'] = entity.detalle;
  data['FechaInicio'] = entity.fechaInicio;
  data['FechaFin'] = entity.fechaFin;
  return data;
}

IncidentsClients $IncidentsFinishedClientesFromJson(Map<String, dynamic> json) {
  final IncidentsClients incidentsFinishedClientes = IncidentsClients();
  final int? iD = jsonConvert.convert<int>(json['ID']);
  if (iD != null) {
    incidentsFinishedClientes.iD = iD;
  }
  final String? createdAt = jsonConvert.convert<String>(json['CreatedAt']);
  if (createdAt != null) {
    incidentsFinishedClientes.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['UpdatedAt']);
  if (updatedAt != null) {
    incidentsFinishedClientes.updatedAt = updatedAt;
  }
  final dynamic deletedAt = jsonConvert.convert<dynamic>(json['DeletedAt']);
  if (deletedAt != null) {
    incidentsFinishedClientes.deletedAt = deletedAt;
  }
  final String? nombre = jsonConvert.convert<String>(json['Nombre']);
  if (nombre != null) {
    incidentsFinishedClientes.nombre = nombre;
  }
  final String? apellido = jsonConvert.convert<String>(json['Apellido']);
  if (apellido != null) {
    incidentsFinishedClientes.apellido = apellido;
  }
  final String? email = jsonConvert.convert<String>(json['Email']);
  if (email != null) {
    incidentsFinishedClientes.email = email;
  }
  final int? organizacionID = jsonConvert.convert<int>(json['OrganizacionID']);
  if (organizacionID != null) {
    incidentsFinishedClientes.organizacionID = organizacionID;
  }
  final dynamic organizacion =
      jsonConvert.convert<dynamic>(json['Organizacion']);
  if (organizacion != null) {
    incidentsFinishedClientes.organizacion = organizacion;
  }
  final dynamic procesos = jsonConvert.convert<dynamic>(json['Procesos']);
  if (procesos != null) {
    incidentsFinishedClientes.procesos = procesos;
  }
  return incidentsFinishedClientes;
}

Map<String, dynamic> $IncidentsFinishedClientesToJson(IncidentsClients entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ID'] = entity.iD;
  data['CreatedAt'] = entity.createdAt;
  data['UpdatedAt'] = entity.updatedAt;
  data['DeletedAt'] = entity.deletedAt;
  data['Nombre'] = entity.nombre;
  data['Apellido'] = entity.apellido;
  data['Email'] = entity.email;
  data['OrganizacionID'] = entity.organizacionID;
  data['Organizacion'] = entity.organizacion;
  data['Procesos'] = entity.procesos;
  return data;
}

IncidentsUsers $IncidentsFinishedUsuariosFromJson(Map<String, dynamic> json) {
  final IncidentsUsers incidentsFinishedUsuarios = IncidentsUsers();
  final int? iD = jsonConvert.convert<int>(json['ID']);
  if (iD != null) {
    incidentsFinishedUsuarios.iD = iD;
  }
  final String? createdAt = jsonConvert.convert<String>(json['CreatedAt']);
  if (createdAt != null) {
    incidentsFinishedUsuarios.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['UpdatedAt']);
  if (updatedAt != null) {
    incidentsFinishedUsuarios.updatedAt = updatedAt;
  }
  final dynamic deletedAt = jsonConvert.convert<dynamic>(json['DeletedAt']);
  if (deletedAt != null) {
    incidentsFinishedUsuarios.deletedAt = deletedAt;
  }
  final String? nombre = jsonConvert.convert<String>(json['Nombre']);
  if (nombre != null) {
    incidentsFinishedUsuarios.nombre = nombre;
  }
  final String? apellido = jsonConvert.convert<String>(json['Apellido']);
  if (apellido != null) {
    incidentsFinishedUsuarios.apellido = apellido;
  }
  final String? email = jsonConvert.convert<String>(json['Email']);
  if (email != null) {
    incidentsFinishedUsuarios.email = email;
  }
  final String? password = jsonConvert.convert<String>(json['Password']);
  if (password != null) {
    incidentsFinishedUsuarios.password = password;
  }
  final dynamic roles = jsonConvert.convert<dynamic>(json['Roles']);
  if (roles != null) {
    incidentsFinishedUsuarios.roles = roles;
  }
  final dynamic procesos = jsonConvert.convert<dynamic>(json['Procesos']);
  if (procesos != null) {
    incidentsFinishedUsuarios.procesos = procesos;
  }
  final dynamic organizaciones =
      jsonConvert.convert<dynamic>(json['Organizaciones']);
  if (organizaciones != null) {
    incidentsFinishedUsuarios.organizaciones = organizaciones;
  }
  return incidentsFinishedUsuarios;
}

Map<String, dynamic> $IncidentsFinishedUsuariosToJson(IncidentsUsers entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ID'] = entity.iD;
  data['CreatedAt'] = entity.createdAt;
  data['UpdatedAt'] = entity.updatedAt;
  data['DeletedAt'] = entity.deletedAt;
  data['Nombre'] = entity.nombre;
  data['Apellido'] = entity.apellido;
  data['Email'] = entity.email;
  data['Password'] = entity.password;
  data['Roles'] = entity.roles;
  data['Procesos'] = entity.procesos;
  data['Organizaciones'] = entity.organizaciones;
  return data;
}
