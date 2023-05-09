import 'dart:convert';

import 'package:UipathMonitor/classes/user_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/organization.dart';

class ApiProvider with ChangeNotifier {
  final String _baseUrl;
  String _token;

  ApiProvider(this._baseUrl, this._token);

  Map<String, String> _standartHeader() {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_token',
    };
  }

  Future<dynamic> GetUsers(
      {int? id,
      String query = '',
      String relational_query = '',
      String relational_condition = ''}) async {
    final request = http.Request('GET',
        Uri.parse('$_baseUrl/admin/users?' + (id != null ? 'id=$id' : '')));
    request.body = json.encode({
      "query": query,
      "relational_query": relational_query,
      "relational_condition": relational_condition
    });
    request.headers.addAll(_standartHeader());
    final response = await request.send();
    if (response.statusCode != 200) {
      throw Exception('Failed to get users');
    }
    final respStr = await response.stream.bytesToString();
    return json.decode(respStr);
  }

  // Create Organization
  Future<int> createOrganization(Organization organization) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/admin/organization'),
      headers: _standartHeader(),
      body: json.encode(organization.toJson()),
    );

    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      throw Exception('Failed to create organization');
    }
  }

  // Get Organizations
  Future<List<Organization>> getOrganizations() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/admin/organization'),
      headers: _standartHeader(),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => Organization.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<Map<String, dynamic>> getOrganization(int id) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/admin/organization?id=$id'),
      headers: _standartHeader(),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get organization');
    }
  }

  // Update Organization
  Future<Organization> updateOrganization(Organization organization) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/admin/organization?id=${organization.id}'),
      headers: _standartHeader(),
      body: json.encode(organization.toJson()),
    );

    if (response.statusCode == 200) {
      return Organization.fromJson(json.decode(response.body));
    } else {
      var jsonResponse = json.decode(response.body);
      throw Exception(jsonResponse.toString());
    }
  }

  // Delete Organization
  Future<void> deleteOrganization(int organizationId) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/admin/organization?id=$organizationId'),
      headers: _standartHeader(),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete organization');
    }
  }

  updateToken(String token) {
    _token = token;
    notifyListeners();
  }

  Future<void> updateOrganizationProcess(int proceso, String text) async {
    // PUT : /admin/organization/process
    // Query Params: id, alias
    final response = await http.put(
        Uri.parse(
            '$_baseUrl/admin/organization/process?id=$proceso&alias=$text'),
        headers: _standartHeader());
    if (response.statusCode != 200) {
      throw Exception('Failed to update process');
    }
  }

  Future<bool> CreateOrUpdateOrganizationClient(
      Map<String, dynamic> Client) async {
    // POST : /admin/organization/client
    // Body: {Nombre, Apellido, Email, OrganizacionId}
    final response = await http.post(
        Uri.parse('$_baseUrl/admin/organization/client'),
        headers: _standartHeader(),
        body: json.encode(Client));
    if (response.statusCode != 200) {
      return false;
    }
    return true;
  }

  Future<void> deleteOrganizationClient(dynamic cliente) async {
    // DELETE "/admin/organization/client"
    // cliente is a map with all data of the client, send it as json body
    final request = await http.Request(
        'DELETE', Uri.parse('$_baseUrl/admin/organization/client'));
    request.body = json.encode(cliente);
    request.headers.addAll(_standartHeader());
    final response = await request.send();
    if (response.statusCode != 200) {
      throw Exception('Failed to delete client');
    }
  }

  Future<void> UpdateOrganizationUser(int orgID,
      {List<int> newUsers = const [], List<int> deleteUsers = const []}) async {
    // PUT /admin/organization/user"
    // Body Example:
    //     {
    //   "org_id": 1,
    //   "new_users": [2, 3],
    //   "delete_users": [4, 5]
    // }
    final request = await http.Request(
        'PUT', Uri.parse('$_baseUrl/admin/organization/user'));
    request.body = json.encode(
        {"org_id": orgID, "new_users": newUsers, "delete_users": deleteUsers});
    request.headers.addAll(_standartHeader());
    final response = await request.send();
    if (response.statusCode != 200) {
      throw Exception('Failed to update users');
    }
  }

  Future addUser(Map<String, dynamic> json) async {
    final request =
        await http.Request('POST', Uri.parse('$_baseUrl/admin/users'));
    request.body = jsonEncode(json);
    request.headers.addAll(_standartHeader());
    final response = await request.send();
    if (response.statusCode != 200) {
      throw Exception('Failed to add user');
    }
  }

  Future deleteUser(int? iD) async {
    final request =
        await http.Request('DELETE', Uri.parse('$_baseUrl/admin/users?id=$iD'));
    request.headers.addAll(_standartHeader());
    final response = await request.send();
    if (response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
  }

  Future editUser(UserEntity user) async {
    final request = await http.Request(
        'PUT', Uri.parse('$_baseUrl/admin/users?id=${user.iD}'));
    request.body = jsonEncode(user.toJson());
    request.headers.addAll(_standartHeader());
    final response = await request.send();
    if (response.statusCode != 200) {
      throw Exception('Failed to edit user');
    }
  }

  Future<List<UserRoles>> GetAllUserRoles() async {
    // /admin/users/roles GET
    final request =
        await http.Request('GET', Uri.parse('$_baseUrl/admin/users/roles'));
    request.headers.addAll(_standartHeader());
    final response = await request.send();
    if (response.statusCode != 200) {
      throw Exception('Failed to get user roles');
    }
    return jsonDecode(await response.stream.bytesToString())
        .map<UserRoles>((x) => UserRoles.fromJson(x))
        .toList();
  }

  Future<dynamic> GetProcesses() async {
    // /admin/processes GET
    final request =
        await http.Request('GET', Uri.parse('$_baseUrl/user/processes'));
    request.headers.addAll(_standartHeader());
    final response = await request.send();
    if (response.statusCode != 200) {
      throw Exception('Failed to get processes');
    }
    return jsonDecode(await response.stream.bytesToString());
  }
}
