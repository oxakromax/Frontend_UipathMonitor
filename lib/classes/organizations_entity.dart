import 'dart:convert';

import '../generated/json/base/json_field.dart';
import '../generated/json/organizations_entity.g.dart';

@JsonSerializable()
class OrganizationsEntity {
  @JSONField(name: "ID")
  double? id;
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

  OrganizationsEntity();

  factory OrganizationsEntity.fromJson(Map<String, dynamic> json) =>
      $OrganizationsEntityFromJson(json);

  Map<String, dynamic> toJson() => $OrganizationsEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
