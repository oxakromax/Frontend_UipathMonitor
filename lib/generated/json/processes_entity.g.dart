import 'package:UipathMonitor/classes/processes_entity.dart';
import 'package:UipathMonitor/generated/json/base/json_convert_content.dart';

ProcessesEntity $ProcessesEntityFromJson(Map<String, dynamic> json) {
  final ProcessesEntity processesEntity = ProcessesEntity();
  final int? iD = jsonConvert.convert<int>(json['ID']);
  if (iD != null) {
    processesEntity.iD = iD;
  }
  final String? createdAt = jsonConvert.convert<String>(json['CreatedAt']);
  if (createdAt != null) {
    processesEntity.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['UpdatedAt']);
  if (updatedAt != null) {
    processesEntity.updatedAt = updatedAt;
  }
  final dynamic deletedAt = jsonConvert.convert<dynamic>(json['DeletedAt']);
  if (deletedAt != null) {
    processesEntity.deletedAt = deletedAt;
  }
  final String? nombre = jsonConvert.convert<String>(json['Nombre']);
  if (nombre != null) {
    processesEntity.nombre = nombre;
  }
  final String? alias = jsonConvert.convert<String>(json['Alias']);
  if (alias != null) {
    processesEntity.alias = alias;
  }
  final int? uipathProcessID =
      jsonConvert.convert<int>(json['UipathProcessID']);
  if (uipathProcessID != null) {
    processesEntity.uipathProcessID = uipathProcessID;
  }
  final int? folderid = jsonConvert.convert<int>(json['Folderid']);
  if (folderid != null) {
    processesEntity.folderid = folderid;
  }
  final String? foldername = jsonConvert.convert<String>(json['Foldername']);
  if (foldername != null) {
    processesEntity.foldername = foldername;
  }
  final int? organizacionID = jsonConvert.convert<int>(json['OrganizacionID']);
  if (organizacionID != null) {
    processesEntity.organizacionID = organizacionID;
  }
  final int? warningTolerance =
      jsonConvert.convert<int>(json['WarningTolerance']);
  if (warningTolerance != null) {
    processesEntity.warningTolerance = warningTolerance;
  }
  final int? errorTolerance = jsonConvert.convert<int>(json['ErrorTolerance']);
  if (errorTolerance != null) {
    processesEntity.errorTolerance = errorTolerance;
  }
  final int? fatalTolerance = jsonConvert.convert<int>(json['FatalTolerance']);
  if (fatalTolerance != null) {
    processesEntity.fatalTolerance = fatalTolerance;
  }
  final bool? activeMonitoring =
      jsonConvert.convert<bool>(json['ActiveMonitoring']);
  if (activeMonitoring != null) {
    processesEntity.activeMonitoring = activeMonitoring;
  }
  final int? prioridad = jsonConvert.convert<int>(json['Prioridad']);
  if (prioridad != null) {
    processesEntity.prioridad = prioridad;
  }
  final ProcessesOrganizacion? organizacion =
      jsonConvert.convert<ProcessesOrganizacion>(json['Organizacion']);
  if (organizacion != null) {
    processesEntity.organizacion = organizacion;
  }
  final List<ProcessesIncidentesProceso>? incidentesProceso =
      jsonConvert.convertListNotNull<ProcessesIncidentesProceso>(
          json['IncidentesProceso']);
  if (incidentesProceso != null) {
    processesEntity.incidentesProceso = incidentesProceso;
  }
  final List<ProcessesClientes>? clientes =
      jsonConvert.convertListNotNull<ProcessesClientes>(json['Clientes']);
  if (clientes != null) {
    processesEntity.clientes = clientes;
  }
  final List<ProcessesUsuarios>? usuarios =
      jsonConvert.convertListNotNull<ProcessesUsuarios>(json['Usuarios']);
  if (usuarios != null) {
    processesEntity.usuarios = usuarios;
  }
  return processesEntity;
}

Map<String, dynamic> $ProcessesEntityToJson(ProcessesEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ID'] = entity.iD;
  data['CreatedAt'] = entity.createdAt;
  data['UpdatedAt'] = entity.updatedAt;
  data['DeletedAt'] = entity.deletedAt;
  data['Nombre'] = entity.nombre;
  data['Alias'] = entity.alias;
  data['UipathProcessID'] = entity.uipathProcessID;
  data['Folderid'] = entity.folderid;
  data['Foldername'] = entity.foldername;
  data['OrganizacionID'] = entity.organizacionID;
  data['WarningTolerance'] = entity.warningTolerance;
  data['ErrorTolerance'] = entity.errorTolerance;
  data['FatalTolerance'] = entity.fatalTolerance;
  data['ActiveMonitoring'] = entity.activeMonitoring;
  data['Prioridad'] = entity.prioridad;
  data['Organizacion'] = entity.organizacion?.toJson();
  data['IncidentesProceso'] =
      entity.incidentesProceso?.map((v) => v.toJson()).toList();
  data['Clientes'] = entity.clientes?.map((v) => v.toJson()).toList();
  data['Usuarios'] = entity.usuarios?.map((v) => v.toJson()).toList();
  return data;
}

ProcessesOrganizacion $ProcessesOrganizacionFromJson(
    Map<String, dynamic> json) {
  final ProcessesOrganizacion processesOrganizacion = ProcessesOrganizacion();
  final int? iD = jsonConvert.convert<int>(json['ID']);
  if (iD != null) {
    processesOrganizacion.iD = iD;
  }
  final String? createdAt = jsonConvert.convert<String>(json['CreatedAt']);
  if (createdAt != null) {
    processesOrganizacion.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['UpdatedAt']);
  if (updatedAt != null) {
    processesOrganizacion.updatedAt = updatedAt;
  }
  final dynamic deletedAt = jsonConvert.convert<dynamic>(json['DeletedAt']);
  if (deletedAt != null) {
    processesOrganizacion.deletedAt = deletedAt;
  }
  final String? nombre = jsonConvert.convert<String>(json['Nombre']);
  if (nombre != null) {
    processesOrganizacion.nombre = nombre;
  }
  final String? uipathname = jsonConvert.convert<String>(json['Uipathname']);
  if (uipathname != null) {
    processesOrganizacion.uipathname = uipathname;
  }
  final String? tenantname = jsonConvert.convert<String>(json['Tenantname']);
  if (tenantname != null) {
    processesOrganizacion.tenantname = tenantname;
  }
  final String? appID = jsonConvert.convert<String>(json['AppID']);
  if (appID != null) {
    processesOrganizacion.appID = appID;
  }
  final String? appSecret = jsonConvert.convert<String>(json['AppSecret']);
  if (appSecret != null) {
    processesOrganizacion.appSecret = appSecret;
  }
  final String? appScope = jsonConvert.convert<String>(json['AppScope']);
  if (appScope != null) {
    processesOrganizacion.appScope = appScope;
  }
  final String? baseURL = jsonConvert.convert<String>(json['BaseURL']);
  if (baseURL != null) {
    processesOrganizacion.baseURL = baseURL;
  }
  final dynamic clientes =
      jsonConvert.convert<ProcessesClientes>(json['Clientes']);
  if (clientes != null) {
    processesOrganizacion.clientes = clientes;
  }
  final dynamic procesos =
      jsonConvert.convert<ProcessesEntity>(json['Procesos']);
  if (procesos != null) {
    processesOrganizacion.procesos = procesos;
  }
  final dynamic usuarios =
      jsonConvert.convert<ProcessesUsuarios>(json['Usuarios']);
  if (usuarios != null) {
    processesOrganizacion.usuarios = usuarios;
  }
  return processesOrganizacion;
}

Map<String, dynamic> $ProcessesOrganizacionToJson(
    ProcessesOrganizacion entity) {
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

ProcessesIncidentesProceso $ProcessesIncidentesProcesoFromJson(
    Map<String, dynamic> json) {
  final ProcessesIncidentesProceso processesIncidentesProceso =
      ProcessesIncidentesProceso();
  final int? iD = jsonConvert.convert<int>(json['ID']);
  if (iD != null) {
    processesIncidentesProceso.iD = iD;
  }
  final String? createdAt = jsonConvert.convert<String>(json['CreatedAt']);
  if (createdAt != null) {
    processesIncidentesProceso.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['UpdatedAt']);
  if (updatedAt != null) {
    processesIncidentesProceso.updatedAt = updatedAt;
  }
  final dynamic deletedAt = jsonConvert.convert<dynamic>(json['DeletedAt']);
  if (deletedAt != null) {
    processesIncidentesProceso.deletedAt = deletedAt;
  }
  final int? procesoID = jsonConvert.convert<int>(json['ProcesoID']);
  if (procesoID != null) {
    processesIncidentesProceso.procesoID = procesoID;
  }
  final dynamic proceso = jsonConvert.convert<dynamic>(json['Proceso']);
  if (proceso != null) {
    processesIncidentesProceso.proceso = proceso;
  }
  final String? incidente = jsonConvert.convert<String>(json['Descripcion']);
  if (incidente != null) {
    processesIncidentesProceso.descripcion = incidente;
  }
  final int? tipo = jsonConvert.convert<int>(json['Tipo']);
  if (tipo != null) {
    processesIncidentesProceso.tipo = tipo;
  }
  final String? estado = jsonConvert.convert<String>(json['Estado']);
  if (estado != null) {
    processesIncidentesProceso.estado = estado;
  }
  final List<ProcessesIncidentesProcesoDetalles>? detalles = jsonConvert
      .convertListNotNull<ProcessesIncidentesProcesoDetalles>(json['Detalles']);
  if (detalles != null) {
    processesIncidentesProceso.detalles = detalles;
  }
  return processesIncidentesProceso;
}

Map<String, dynamic> $ProcessesIncidentesProcesoToJson(
    ProcessesIncidentesProceso entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ID'] = entity.iD;
  data['CreatedAt'] = entity.createdAt;
  data['UpdatedAt'] = entity.updatedAt;
  data['DeletedAt'] = entity.deletedAt;
  data['ProcesoID'] = entity.procesoID;
  data['Proceso'] = entity.proceso;
  data['Descripcion'] = entity.descripcion;
  data['Tipo'] = entity.tipo;
  data['Estado'] = entity.estado;
  data['Detalles'] = entity.detalles?.map((v) => v.toJson()).toList();
  return data;
}

ProcessesIncidentesProcesoDetalles $ProcessesIncidentesProcesoDetallesFromJson(
    Map<String, dynamic> json) {
  final ProcessesIncidentesProcesoDetalles processesIncidentesProcesoDetalles =
      ProcessesIncidentesProcesoDetalles();
  final int? iD = jsonConvert.convert<int>(json['ID']);
  if (iD != null) {
    processesIncidentesProcesoDetalles.iD = iD;
  }
  final String? createdAt = jsonConvert.convert<String>(json['CreatedAt']);
  if (createdAt != null) {
    processesIncidentesProcesoDetalles.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['UpdatedAt']);
  if (updatedAt != null) {
    processesIncidentesProcesoDetalles.updatedAt = updatedAt;
  }
  final dynamic deletedAt = jsonConvert.convert<dynamic>(json['DeletedAt']);
  if (deletedAt != null) {
    processesIncidentesProcesoDetalles.deletedAt = deletedAt;
  }
  final int? incidenteID = jsonConvert.convert<int>(json['IncidenteID']);
  if (incidenteID != null) {
    processesIncidentesProcesoDetalles.incidenteID = incidenteID;
  }
  final String? detalle = jsonConvert.convert<String>(json['Detalle']);
  if (detalle != null) {
    processesIncidentesProcesoDetalles.detalle = detalle;
  }
  final String? fechaInicio = jsonConvert.convert<String>(json['FechaInicio']);
  if (fechaInicio != null) {
    processesIncidentesProcesoDetalles.fechaInicio = fechaInicio;
  }
  final String? fechaFin = jsonConvert.convert<String>(json['FechaFin']);
  if (fechaFin != null) {
    processesIncidentesProcesoDetalles.fechaFin = fechaFin;
  }
  return processesIncidentesProcesoDetalles;
}

Map<String, dynamic> $ProcessesIncidentesProcesoDetallesToJson(
    ProcessesIncidentesProcesoDetalles entity) {
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

ProcessesClientes $ProcessesClientesFromJson(Map<String, dynamic> json) {
  final ProcessesClientes processesClientes = ProcessesClientes();
  final int? iD = jsonConvert.convert<int>(json['ID']);
  if (iD != null) {
    processesClientes.iD = iD;
  }
  final String? createdAt = jsonConvert.convert<String>(json['CreatedAt']);
  if (createdAt != null) {
    processesClientes.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['UpdatedAt']);
  if (updatedAt != null) {
    processesClientes.updatedAt = updatedAt;
  }
  final dynamic deletedAt = jsonConvert.convert<dynamic>(json['DeletedAt']);
  if (deletedAt != null) {
    processesClientes.deletedAt = deletedAt;
  }
  final String? nombre = jsonConvert.convert<String>(json['Nombre']);
  if (nombre != null) {
    processesClientes.nombre = nombre;
  }
  final String? apellido = jsonConvert.convert<String>(json['Apellido']);
  if (apellido != null) {
    processesClientes.apellido = apellido;
  }
  final String? email = jsonConvert.convert<String>(json['Email']);
  if (email != null) {
    processesClientes.email = email;
  }
  final int? organizacionID = jsonConvert.convert<int>(json['OrganizacionID']);
  if (organizacionID != null) {
    processesClientes.organizacionID = organizacionID;
  }
  final dynamic organizacion =
      jsonConvert.convert<dynamic>(json['Organizacion']);
  if (organizacion != null) {
    processesClientes.organizacion = organizacion;
  }
  final dynamic procesos = jsonConvert.convert<dynamic>(json['Procesos']);
  if (procesos != null) {
    processesClientes.procesos = procesos;
  }
  return processesClientes;
}

Map<String, dynamic> $ProcessesClientesToJson(ProcessesClientes entity) {
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

ProcessesUsuarios $ProcessesUsuariosFromJson(Map<String, dynamic> json) {
  final ProcessesUsuarios processesUsuarios = ProcessesUsuarios();
  final int? iD = jsonConvert.convert<int>(json['ID']);
  if (iD != null) {
    processesUsuarios.iD = iD;
  }
  final String? createdAt = jsonConvert.convert<String>(json['CreatedAt']);
  if (createdAt != null) {
    processesUsuarios.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['UpdatedAt']);
  if (updatedAt != null) {
    processesUsuarios.updatedAt = updatedAt;
  }
  final dynamic deletedAt = jsonConvert.convert<dynamic>(json['DeletedAt']);
  if (deletedAt != null) {
    processesUsuarios.deletedAt = deletedAt;
  }
  final String? nombre = jsonConvert.convert<String>(json['Nombre']);
  if (nombre != null) {
    processesUsuarios.nombre = nombre;
  }
  final String? apellido = jsonConvert.convert<String>(json['Apellido']);
  if (apellido != null) {
    processesUsuarios.apellido = apellido;
  }
  final String? email = jsonConvert.convert<String>(json['Email']);
  if (email != null) {
    processesUsuarios.email = email;
  }
  final String? password = jsonConvert.convert<String>(json['Password']);
  if (password != null) {
    processesUsuarios.password = password;
  }
  final dynamic roles = jsonConvert.convert<dynamic>(json['Roles']);
  if (roles != null) {
    processesUsuarios.roles = roles;
  }
  final dynamic procesos = jsonConvert.convert<dynamic>(json['Procesos']);
  if (procesos != null) {
    processesUsuarios.procesos = procesos;
  }
  final dynamic organizaciones =
      jsonConvert.convert<dynamic>(json['Organizaciones']);
  if (organizaciones != null) {
    processesUsuarios.organizaciones = organizaciones;
  }
  return processesUsuarios;
}

Map<String, dynamic> $ProcessesUsuariosToJson(ProcessesUsuarios entity) {
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
