import 'package:UipathMonitor/classes/user_entity.dart';
import 'package:UipathMonitor/generated/json/base/json_convert_content.dart';

UserEntity $UserEntityFromJson(Map<String, dynamic> json) {
  final UserEntity userEntity = UserEntity();
  final int? iD = jsonConvert.convert<int>(json['ID']);
  if (iD != null) {
    userEntity.iD = iD;
  }
  final String? createdAt = jsonConvert.convert<String>(json['CreatedAt']);
  if (createdAt != null) {
    userEntity.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['UpdatedAt']);
  if (updatedAt != null) {
    userEntity.updatedAt = updatedAt;
  }
  final String? deletedAt = jsonConvert.convert<String>(json['DeletedAt']);
  if (deletedAt != null) {
    userEntity.deletedAt = deletedAt;
  }
  final String? nombre = jsonConvert.convert<String>(json['Nombre']);
  if (nombre != null) {
    userEntity.nombre = nombre;
  }
  final String? apellido = jsonConvert.convert<String>(json['Apellido']);
  if (apellido != null) {
    userEntity.apellido = apellido;
  }
  final String? email = jsonConvert.convert<String>(json['Email']);
  if (email != null) {
    userEntity.email = email;
  }
  final String? password = jsonConvert.convert<String>(json['Password']);
  if (password != null) {
    userEntity.password = password;
  }
  final List<UserRoles>? roles =
      jsonConvert.convertListNotNull<UserRoles>(json['Roles']);
  if (roles != null) {
    userEntity.roles = roles;
  }
  final List<UserProcesos>? procesos =
      jsonConvert.convertListNotNull<UserProcesos>(json['Procesos']);
  if (procesos != null) {
    userEntity.procesos = procesos;
  }
  final List<UserOrganizaciones>? organizaciones = jsonConvert
      .convertListNotNull<UserOrganizaciones>(json['Organizaciones']);
  if (organizaciones != null) {
    userEntity.organizaciones = organizaciones;
  }
  return userEntity;
}

Map<String, dynamic> $UserEntityToJson(UserEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ID'] = entity.iD;
  data['CreatedAt'] = entity.createdAt;
  data['UpdatedAt'] = entity.updatedAt;
  data['DeletedAt'] = entity.deletedAt;
  data['Nombre'] = entity.nombre;
  data['Apellido'] = entity.apellido;
  data['Email'] = entity.email;
  data['Password'] = entity.password;
  data['Roles'] = entity.roles?.map((v) => v.toJson()).toList();
  data['Procesos'] = entity.procesos?.map((v) => v.toJson()).toList();
  data['Organizaciones'] =
      entity.organizaciones?.map((v) => v.toJson()).toList();
  return data;
}

UserRoles $UserRolesFromJson(Map<String, dynamic> json) {
  final UserRoles userRoles = UserRoles();
  final int? iD = jsonConvert.convert<int>(json['ID']);
  if (iD != null) {
    userRoles.iD = iD;
  }
  final String? createdAt = jsonConvert.convert<String>(json['CreatedAt']);
  if (createdAt != null) {
    userRoles.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['UpdatedAt']);
  if (updatedAt != null) {
    userRoles.updatedAt = updatedAt;
  }
  final dynamic deletedAt = jsonConvert.convert<dynamic>(json['DeletedAt']);
  if (deletedAt != null) {
    userRoles.deletedAt = deletedAt;
  }
  final String? nombre = jsonConvert.convert<String>(json['Nombre']);
  if (nombre != null) {
    userRoles.nombre = nombre;
  }
  final String? description = jsonConvert.convert<String>(json['Description']);
  if (description != null) {
    userRoles.description = description;
  }
  final dynamic usuarios = jsonConvert.convert<dynamic>(json['Usuarios']);
  if (usuarios != null) {
    userRoles.usuarios = usuarios;
  }
  final List<UserRolesRutas>? rutas =
      jsonConvert.convertListNotNull<UserRolesRutas>(json['Rutas']);
  if (rutas != null) {
    userRoles.rutas = rutas;
  }
  return userRoles;
}

Map<String, dynamic> $UserRolesToJson(UserRoles entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ID'] = entity.iD;
  data['CreatedAt'] = entity.createdAt;
  data['UpdatedAt'] = entity.updatedAt;
  data['DeletedAt'] = entity.deletedAt;
  data['Nombre'] = entity.nombre;
  data['Description'] = entity.description;
  data['Usuarios'] = entity.usuarios;
  data['Rutas'] = entity.rutas?.map((v) => v.toJson()).toList();
  return data;
}

UserRolesRutas $UserRolesRutasFromJson(Map<String, dynamic> json) {
  final UserRolesRutas userRolesRutas = UserRolesRutas();
  final int? iD = jsonConvert.convert<int>(json['ID']);
  if (iD != null) {
    userRolesRutas.iD = iD;
  }
  final String? createdAt = jsonConvert.convert<String>(json['CreatedAt']);
  if (createdAt != null) {
    userRolesRutas.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['UpdatedAt']);
  if (updatedAt != null) {
    userRolesRutas.updatedAt = updatedAt;
  }
  final dynamic deletedAt = jsonConvert.convert<dynamic>(json['DeletedAt']);
  if (deletedAt != null) {
    userRolesRutas.deletedAt = deletedAt;
  }
  final String? method = jsonConvert.convert<String>(json['Method']);
  if (method != null) {
    userRolesRutas.method = method;
  }
  final String? route = jsonConvert.convert<String>(json['Route']);
  if (route != null) {
    userRolesRutas.route = route;
  }
  final dynamic roles = jsonConvert.convert<dynamic>(json['Roles']);
  if (roles != null) {
    userRolesRutas.roles = roles;
  }
  return userRolesRutas;
}

Map<String, dynamic> $UserRolesRutasToJson(UserRolesRutas entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ID'] = entity.iD;
  data['CreatedAt'] = entity.createdAt;
  data['UpdatedAt'] = entity.updatedAt;
  data['DeletedAt'] = entity.deletedAt;
  data['Method'] = entity.method;
  data['Route'] = entity.route;
  data['Roles'] = entity.roles;
  return data;
}

UserProcesos $UserProcesosFromJson(Map<String, dynamic> json) {
  final UserProcesos userProcesos = UserProcesos();
  final int? iD = jsonConvert.convert<int>(json['ID']);
  if (iD != null) {
    userProcesos.iD = iD;
  }
  final String? createdAt = jsonConvert.convert<String>(json['CreatedAt']);
  if (createdAt != null) {
    userProcesos.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['UpdatedAt']);
  if (updatedAt != null) {
    userProcesos.updatedAt = updatedAt;
  }
  final dynamic deletedAt = jsonConvert.convert<dynamic>(json['DeletedAt']);
  if (deletedAt != null) {
    userProcesos.deletedAt = deletedAt;
  }
  final String? nombre = jsonConvert.convert<String>(json['Nombre']);
  if (nombre != null) {
    userProcesos.nombre = nombre;
  }
  final String? alias = jsonConvert.convert<String>(json['Alias']);
  if (alias != null) {
    userProcesos.alias = alias;
  }
  final int? folderid = jsonConvert.convert<int>(json['Folderid']);
  if (folderid != null) {
    userProcesos.folderid = folderid;
  }
  final String? foldername = jsonConvert.convert<String>(json['Foldername']);
  if (foldername != null) {
    userProcesos.foldername = foldername;
  }
  final int? organizacionID = jsonConvert.convert<int>(json['OrganizacionID']);
  if (organizacionID != null) {
    userProcesos.organizacionID = organizacionID;
  }
  final int? warningTolerance =
      jsonConvert.convert<int>(json['WarningTolerance']);
  if (warningTolerance != null) {
    userProcesos.warningTolerance = warningTolerance;
  }
  final int? errorTolerance = jsonConvert.convert<int>(json['ErrorTolerance']);
  if (errorTolerance != null) {
    userProcesos.errorTolerance = errorTolerance;
  }
  final int? fatalTolerance = jsonConvert.convert<int>(json['FatalTolerance']);
  if (fatalTolerance != null) {
    userProcesos.fatalTolerance = fatalTolerance;
  }
  final dynamic organizacion =
      jsonConvert.convert<dynamic>(json['Organizacion']);
  if (organizacion != null) {
    userProcesos.organizacion = organizacion;
  }
  final dynamic incidentesProceso =
      jsonConvert.convert<dynamic>(json['IncidentesProceso']);
  if (incidentesProceso != null) {
    userProcesos.incidentesProceso = incidentesProceso;
  }
  final dynamic clientes = jsonConvert.convert<dynamic>(json['Clientes']);
  if (clientes != null) {
    userProcesos.clientes = clientes;
  }
  final dynamic usuarios = jsonConvert.convert<dynamic>(json['Usuarios']);
  if (usuarios != null) {
    userProcesos.usuarios = usuarios;
  }
  return userProcesos;
}

Map<String, dynamic> $UserProcesosToJson(UserProcesos entity) {
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
  data['Organizacion'] = entity.organizacion;
  data['IncidentesProceso'] = entity.incidentesProceso;
  data['Clientes'] = entity.clientes;
  data['Usuarios'] = entity.usuarios;
  return data;
}

UserOrganizaciones $UserOrganizacionesFromJson(Map<String, dynamic> json) {
  final UserOrganizaciones userOrganizaciones = UserOrganizaciones();
  final int? iD = jsonConvert.convert<int>(json['ID']);
  if (iD != null) {
    userOrganizaciones.iD = iD;
  }
  final String? createdAt = jsonConvert.convert<String>(json['CreatedAt']);
  if (createdAt != null) {
    userOrganizaciones.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['UpdatedAt']);
  if (updatedAt != null) {
    userOrganizaciones.updatedAt = updatedAt;
  }
  final dynamic deletedAt = jsonConvert.convert<dynamic>(json['DeletedAt']);
  if (deletedAt != null) {
    userOrganizaciones.deletedAt = deletedAt;
  }
  final String? nombre = jsonConvert.convert<String>(json['Nombre']);
  if (nombre != null) {
    userOrganizaciones.nombre = nombre;
  }
  final String? uipathname = jsonConvert.convert<String>(json['Uipathname']);
  if (uipathname != null) {
    userOrganizaciones.uipathname = uipathname;
  }
  final String? tenantname = jsonConvert.convert<String>(json['Tenantname']);
  if (tenantname != null) {
    userOrganizaciones.tenantname = tenantname;
  }
  final String? appID = jsonConvert.convert<String>(json['AppID']);
  if (appID != null) {
    userOrganizaciones.appID = appID;
  }
  final String? appSecret = jsonConvert.convert<String>(json['AppSecret']);
  if (appSecret != null) {
    userOrganizaciones.appSecret = appSecret;
  }
  final String? appScope = jsonConvert.convert<String>(json['AppScope']);
  if (appScope != null) {
    userOrganizaciones.appScope = appScope;
  }
  final String? baseURL = jsonConvert.convert<String>(json['BaseURL']);
  if (baseURL != null) {
    userOrganizaciones.baseURL = baseURL;
  }
  final dynamic clientes = jsonConvert.convert<dynamic>(json['Clientes']);
  if (clientes != null) {
    userOrganizaciones.clientes = clientes;
  }
  final List<UserOrganizacionesProcesos>? procesos = jsonConvert
      .convertListNotNull<UserOrganizacionesProcesos>(json['Procesos']);
  if (procesos != null) {
    userOrganizaciones.procesos = procesos;
  }
  final dynamic usuarios = jsonConvert.convert<dynamic>(json['Usuarios']);
  if (usuarios != null) {
    userOrganizaciones.usuarios = usuarios;
  }
  return userOrganizaciones;
}

Map<String, dynamic> $UserOrganizacionesToJson(UserOrganizaciones entity) {
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
  data['Procesos'] = entity.procesos?.map((v) => v.toJson()).toList();
  data['Usuarios'] = entity.usuarios;
  return data;
}

UserOrganizacionesProcesos $UserOrganizacionesProcesosFromJson(
    Map<String, dynamic> json) {
  final UserOrganizacionesProcesos userOrganizacionesProcesos =
      UserOrganizacionesProcesos();
  final int? iD = jsonConvert.convert<int>(json['ID']);
  if (iD != null) {
    userOrganizacionesProcesos.iD = iD;
  }
  final String? createdAt = jsonConvert.convert<String>(json['CreatedAt']);
  if (createdAt != null) {
    userOrganizacionesProcesos.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['UpdatedAt']);
  if (updatedAt != null) {
    userOrganizacionesProcesos.updatedAt = updatedAt;
  }
  final dynamic deletedAt = jsonConvert.convert<dynamic>(json['DeletedAt']);
  if (deletedAt != null) {
    userOrganizacionesProcesos.deletedAt = deletedAt;
  }
  final String? nombre = jsonConvert.convert<String>(json['Nombre']);
  if (nombre != null) {
    userOrganizacionesProcesos.nombre = nombre;
  }
  final String? alias = jsonConvert.convert<String>(json['Alias']);
  if (alias != null) {
    userOrganizacionesProcesos.alias = alias;
  }
  final int? folderid = jsonConvert.convert<int>(json['Folderid']);
  if (folderid != null) {
    userOrganizacionesProcesos.folderid = folderid;
  }
  final String? foldername = jsonConvert.convert<String>(json['Foldername']);
  if (foldername != null) {
    userOrganizacionesProcesos.foldername = foldername;
  }
  final int? organizacionID = jsonConvert.convert<int>(json['OrganizacionID']);
  if (organizacionID != null) {
    userOrganizacionesProcesos.organizacionID = organizacionID;
  }
  final int? warningTolerance =
      jsonConvert.convert<int>(json['WarningTolerance']);
  if (warningTolerance != null) {
    userOrganizacionesProcesos.warningTolerance = warningTolerance;
  }
  final int? errorTolerance = jsonConvert.convert<int>(json['ErrorTolerance']);
  if (errorTolerance != null) {
    userOrganizacionesProcesos.errorTolerance = errorTolerance;
  }
  final int? fatalTolerance = jsonConvert.convert<int>(json['FatalTolerance']);
  if (fatalTolerance != null) {
    userOrganizacionesProcesos.fatalTolerance = fatalTolerance;
  }
  final dynamic organizacion =
      jsonConvert.convert<dynamic>(json['Organizacion']);
  if (organizacion != null) {
    userOrganizacionesProcesos.organizacion = organizacion;
  }
  final dynamic incidentesProceso =
      jsonConvert.convert<dynamic>(json['IncidentesProceso']);
  if (incidentesProceso != null) {
    userOrganizacionesProcesos.incidentesProceso = incidentesProceso;
  }
  final dynamic clientes = jsonConvert.convert<dynamic>(json['Clientes']);
  if (clientes != null) {
    userOrganizacionesProcesos.clientes = clientes;
  }
  final dynamic usuarios = jsonConvert.convert<dynamic>(json['Usuarios']);
  if (usuarios != null) {
    userOrganizacionesProcesos.usuarios = usuarios;
  }
  return userOrganizacionesProcesos;
}

Map<String, dynamic> $UserOrganizacionesProcesosToJson(
    UserOrganizacionesProcesos entity) {
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
  data['Organizacion'] = entity.organizacion;
  data['IncidentesProceso'] = entity.incidentesProceso;
  data['Clientes'] = entity.clientes;
  data['Usuarios'] = entity.usuarios;
  return data;
}
