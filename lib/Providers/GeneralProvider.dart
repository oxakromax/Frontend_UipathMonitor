import 'dart:convert';

import 'package:UipathMonitor/classes/user_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeneralProvider with ChangeNotifier {
  String _token = '';
  List<UserRolesRutas> _rutas = [];
  UserEntity? _user;
  final String _url;
  GeneralProvider(this._url);

  String get token => _token;

  String get url => _url;

  UserEntity? get user => _user;

  bool isAuthorized(String ruta) {
    return _rutas.any((element) => element.route == ruta);
  }

  void setUser(UserEntity newUser) {
    _user = newUser;
    newUser.roles?.forEach((element) {
      element.rutas?.forEach((ruta) {
        _rutas.add(ruta);
      });
    });
    notifyListeners();
  }

  void setToken(String newToken) {
    _token = newToken;
    notifyListeners();
  }

  void logout(BuildContext context) {
    setToken('');
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  Future<void> saveLocalProgress(Map<String, Object?> incident) async {
    var userId = user?.iD;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String incidentJson = jsonEncode(incident);

    List<String> localProgressList =
        prefs.getStringList('user_progress_$userId') ?? [];
    localProgressList.add(incidentJson);
    await prefs.setStringList('user_progress_$userId', localProgressList);
  }

  Future<List<Map<String, Object?>>?> getLocalProgress() async {
    var userId = user?.iD;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? localProgressList =
        prefs.getStringList('user_progress_$userId');
    if (localProgressList != null) {
      return localProgressList.map((incidentJson) {
        Map<String, Object?> incidentJsonMap = jsonDecode(incidentJson);
        return incidentJsonMap;
      }).toList();
    }
    return null;
  }

  Future<void> removeLocalProgress(Map<String, Object?> incident) async {
    var userId = user?.iD;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? localProgressList =
        prefs.getStringList('user_progress_$userId');
    if (localProgressList != null) {
      localProgressList.removeWhere((incidentJson) {
        Map<String, Object?> incidentJsonMap = jsonDecode(incidentJson);
        return incidentJsonMap['id'] == incident['id'];
      });
      await prefs.setStringList('user_progress_$userId', localProgressList);
    }
  }
}
