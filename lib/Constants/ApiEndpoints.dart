import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

class ApiEndpoints {
  static const String BaseUrl = "http://192.168.100.28:8080";

  // Arrays of {Method, Endpoint}
  static const List<String> Login = ["/auth", "POST"];
  static const List<String> ForgotPassword = ["/forgot", "POST"];
  static const List<String> PingAuth = ["/pingAuth", "GET"];
  static const List<String> GetTime = ["/Time", "GET"];
  static const List<String> GetProfile = ["/user/profile", "GET"];
  static const List<String> UpdateProfile = ["/user/profile", "PUT"];
  static const List<String> GetUserOrganizations = [
    "/user/organizations",
    "GET"
  ];
  static const List<String> GetUserProcesses = ["/user/processes", "GET"];
  static const List<String> GetUserIncidents = ["/user/incidents", "GET"];
  static const List<String> PostIncidentDetails = [
    "/user/incidents/details",
    "POST"
  ];
  static const List<String> DeleteUser = ["/admin/users", "DELETE"];
  static const List<String> GetUsers = ["/admin/users", "GET"];
  static const List<String> CreateUser = ["/admin/users", "POST"];
  static const List<String> UpdateUser = ["/admin/users", "PUT"];
  static const List<String> GetAllRoles = ["/admin/users/roles", "GET"];
  static const List<String> CreateOrganization = [
    "/admin/organization",
    "POST"
  ];
  static const List<String> UpdateOrganization = ["/admin/organization", "PUT"];
  static const List<String> DeleteOrganization = [
    "/admin/organization",
    "DELETE"
  ];
  static const List<String> GetOrganizations = ["/admin/organization", "GET"];
  static const List<String> CreateUpdateOrganizationClient = [
    "/admin/organization/client",
    "POST"
  ];
  static const List<String> DeleteOrganizationClient = [
    "/admin/organization/client",
    "DELETE"
  ];
  static const List<String> UpdateProcessAlias = [
    "/admin/organization/process",
    "PUT"
  ];
  static const List<String> UpdateOrganizationUser = [
    "/admin/organization/user",
    "PUT"
  ];
  static const List<String> UpdateUipathProcess = [
    "/admin/UpdateUipathProcess",
    "PATCH"
  ];
  static const List<String> GetProcesses = ["/user/processes", "GET"];
  static const List<String> GetProcess = ["/user/processes/:id", "GET"];
  static const List<String> DeleteClientsFromProcess = [
    "/user/processes/:id/clients",
    "DELETE"
  ];
  static const List<String> AddClientsToProcess = [
    "/user/processes/:id/clients",
    "POST"
  ];
  static const List<String> AddUsersToProcess = [
    "/user/processes/:id/users",
    "POST"
  ];
  static const List<String> DeleteUsersFromProcess = [
    "/user/processes/:id/users",
    "DELETE"
  ];
  static const List<String> UpdateProcess = ["/user/processes/:id", "PUT"];
  static const List<String> GetPossibleUsers = [
    "/user/processes/:id/possibleUsers",
    "GET"
  ];
  static const List<String> GetPossibleClients = [
    "/user/processes/:id/possibleClients",
    "GET"
  ];
  static const List<String> NewIncident = [
    "/user/processes/:id/newIncident",
    "POST"
  ];
  static const List<String> GetClientTicket = ["/client/tickets", "GET"];
  static const List<String> GetOrgData = ["/admin/downloads/orgs", "GET"];
  static const List<String> GetProcessesData = [
    "/admin/downloads/processes",
    "GET"
  ];
  static const List<String> GetUserData = ["/admin/downloads/users", "GET"];
  static const List<String> GetTicketSettings = [
    "/user/incidents/details",
    "GET"
  ];
  static const List<String> GetTicketsType = [
    "/user/processes/TicketsType",
    "GET"
  ];

  static Future<String> SaveResponseToFile(StreamedResponse response) async {
    final contentDisposition = response.headers['content-disposition'];

    // Ajustando la expresión regular
    final match = RegExp(r'filename=([^;]*)').firstMatch(contentDisposition!);

    // Eliminando espacios en blanco al principio o al final del nombre del archivo, si los hay.
    final fileName = match?.group(1)?.trim() ?? 'default_file_name.ext';

    final bytes = await response.stream.toBytes();
    final directory = await getApplicationDocumentsDirectory();
    String pathSeparator = Platform.isWindows ? '\\' : '/';
    final filePath = '${directory.path}$pathSeparator$fileName';

    final file = File(filePath);
    await file.writeAsBytes(bytes);

    return filePath;
  }

  static Request getHttpRequest(List<String> endpoint,
      {Map<String, String>? params,
      Map<String, String>? queryParams,
      Map<String, String>? headers,
      dynamic body,
      Map<String, String>? bodyFields}) {
    // Reemplazar parámetros en la URL
    String url = endpoint[0];
    if (params != null) {
      params.forEach((key, value) {
        url = url.replaceAll(':$key', value);
      });
    }

    // Agregar parámetros de consulta a la URL
    if (queryParams != null) {
      final queryString = Uri(queryParameters: queryParams).query;
      url += '?$queryString';
    }

    // Crear la solicitud
    var request = Request(endpoint[1], Uri.parse(BaseUrl + url));

    // Agregar encabezados si se proporcionan
    if (headers != null) {
      request.headers.addAll(headers);
    }

    // Agregar cuerpo si se proporciona
    if (body != null) {
      request.body = json.encode(body);
    }

    // Agregar campos de cuerpo si se proporcionan
    if (bodyFields != null) {
      request.bodyFields = bodyFields;
    }

    return request;
  }

  static MultipartRequest getMultipartRequest(List<String> endpoint,
      {Map<String, String>? params,
      Map<String, String>? queryParams,
      Map<String, String>? headers,
      Map<String, String>? fields}) {
    // Reemplazar parámetros en la URL
    String url = endpoint[0];
    if (params != null) {
      params.forEach((key, value) {
        url = url.replaceAll(':$key', value);
      });
    }

    // Agregar parámetros de consulta a la URL
    if (queryParams != null) {
      final queryString = Uri(queryParameters: queryParams).query;
      url += '?$queryString';
    }

    // Crear la solicitud
    var request = MultipartRequest(endpoint[1], Uri.parse(BaseUrl + url));

    // Agregar encabezados si se proporcionan
    if (headers != null) {
      request.headers.addAll(headers);
    }

    // Agregar campos de cuerpo si se proporcionan
    if (fields != null) {
      request.fields.addAll(fields);
    }

    return request;
  }
}
