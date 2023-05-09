import 'dart:async';
import 'dart:convert';

import 'package:UipathMonitor/classes/user_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GeneralProvider with ChangeNotifier {
  String _token = '';
  List<UserRolesRutas> _rutas = [];
  UserEntity? _user;
  final String _url;

  GeneralProvider(this._url);

  // little map to store pass and user
  Map<String, String> _userMap = {
    'user': '',
    'pass': '',
  };

  // Timer to check if the user is logged in
  Timer? _timer;

  String get token => _token;

  String get url => _url;

  UserEntity? get user => _user;

  bool isAuthorized(String ruta) {
    return _rutas.any((element) => element.route == ruta);
  }

  void StartTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      // Check first to "/pingAuth" if the user is logged in, if response is 200 is logged, if is 401 is not logged
      // if not logged, try to login, if login is success, set the token, if not cancel the timer
      if (_token == "") {
        timer.cancel();
        return;
      }
      var request = http.Request('GET', Uri.parse("$_url/pingAuth"));
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      };
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        return;
      }
      headers = {'Content-Type': 'application/x-www-form-urlencoded'};
      // Route Auth
      request = http.Request('POST', Uri.parse("$_url/auth"));
      request.bodyFields = {
        'email': _userMap['user'] ?? '',
        'password': _userMap['pass'] ?? '',
      };
      request.headers.addAll(headers);
      response = await request.send();
      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseString);
        setToken(jsonResponse['token']);
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
