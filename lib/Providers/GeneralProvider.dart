import 'dart:async';
import 'dart:convert';

import 'package:UipathMonitor/classes/user_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/ApiEndpoints.dart';

class GeneralProvider with ChangeNotifier {
  String _token = '';
  List<UserRolesRutas> _rutas = [];
  List<UserRoles> _roles = [];
  UserEntity? _user;

  // little map to store pass and user
  Map<String, String> _userMap = {
    'user': '',
    'pass': '',
  };

  // Timer to check if the user is logged in
  Timer? _timer;

  String get token => _token;


  UserEntity? get user => _user;

  bool isAuthorized(String ruta) {
    return _rutas.any((element) => element.route == ruta);
  }

  bool HasRole(String role) {
    return _roles
        .any((element) => element.nombre == role || element.nombre == 'admin');
  }

  bool HasProcess(int id) {
    return _user?.procesos?.any((element) => element.iD == id) ?? false;
  }

  void StartTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      // Check first to "/pingAuth" if the user is logged in, if response is 200 is logged, if is 401 is not logged
      // if not logged, try to login, if login is success, set the token, if not cancel the timer
      if (_token == "") {
        timer.cancel();
        return;
      }
      var request =
          ApiEndpoints.getHttpRequest(ApiEndpoints.PingAuth, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      });
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        return;
      }
      // Route Auth
      request = ApiEndpoints.getHttpRequest(ApiEndpoints.Login, headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      }, bodyFields: {
        'email': _userMap['user'] ?? '',
        'password': _userMap['pass'] ?? '',
      });
      response = await request.send();
      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseString);
        setToken(jsonResponse['token']);
        // refresh User
        var user = await fetchProfile();
        if (user != null) {
          setUser(user);
        }
      } else if // connection refused or internet connection lost
          (response.statusCode == 401) {
        return;
      } else {
        setToken('');
      }
    });
  }

  void setUserMap(String user, String pass) {
    _userMap['user'] = user;
    _userMap['pass'] = pass;
    StartTimer();
  }

  void setUser(UserEntity newUser) {
    _user = newUser;
    newUser.roles?.forEach((element) {
      element.rutas?.forEach((ruta) {
        _rutas.add(ruta);
      });
      _roles.add(element);
    });
    notifyListeners();
  }

  void setToken(String newToken) {
    _token = newToken;
    notifyListeners();
  }

  void logout(BuildContext context) {
    setToken('');
    _timer?.cancel();
    _user = null;
    _rutas = [];
    _roles = [];
    _userMap['user'] = '';
    _userMap['pass'] = '';
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  Future<UserEntity?> fetchProfile() async {
    var request = ApiEndpoints.getHttpRequest(ApiEndpoints.GetProfile,
        headers: {'Authorization': 'Bearer $_token'});

    final response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();
      var profileData = jsonDecode(responseString);
      return UserEntity.fromJson(profileData);
    } else {
      throw Exception('Error al obtener el perfil');
    }
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
