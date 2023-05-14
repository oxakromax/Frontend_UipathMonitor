class Organization {
  int? id;
  String? nombre;
  String? uipathname;
  String? tenantname;
  String? appID;
  String? appSecret;
  String? appScope;
  String? baseURL;

  Organization({
    this.id,
    this.nombre,
    this.uipathname,
    this.tenantname,
    this.appID,
    this.appSecret,
    this.appScope,
    this.baseURL,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['ID'],
      nombre: json['Nombre'],
      uipathname: json['Uipathname'],
      tenantname: json['Tenantname'],
      appID: json['AppID'],
      appSecret: json['AppSecret'],
      appScope: json['AppScope'],
      baseURL: json['BaseURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Nombre': nombre,
      'Uipathname': uipathname,
      'Tenantname': tenantname,
      'AppID': appID,
      'AppSecret': appSecret,
      'AppScope': appScope,
      'BaseURL': baseURL,
    };
  }
}
