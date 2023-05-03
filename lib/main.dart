// ignore_for_file: use_build_context_synchronously

import 'package:UipathMonitor/pages/Admin/Organization/OrganizationListPage.dart';
import 'package:UipathMonitor/pages/Admin/Users/UsersListPage.dart';
import 'package:UipathMonitor/pages/ForgotPasswordPage.dart';
import 'package:UipathMonitor/pages/User/ProfilePage.dart';
import 'package:UipathMonitor/pages/User/incidentsUser/incident_management_page.dart';
import 'package:UipathMonitor/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Providers/ApiProvider.dart';
import 'Providers/GeneralProvider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) =>
                // GeneralProvider("https://golanguipathmonitortunnel.loca.lt")),
                GeneralProvider("http://127.0.0.1:8080")),
        // Utiliza ChangeNotifierProxyProvider para actualizar ApiProvider cuando GeneralProvider cambie
        ChangeNotifierProxyProvider<GeneralProvider, ApiProvider>(
          // create: (context) => ApiProvider("https://golanguipathmonitortunnel.loca.lt", ""),
          create: (context) => ApiProvider("http://127.0.0.1:8080", ""),
          update: (context, generalProvider, apiProvider) {
            apiProvider?.updateToken(generalProvider.token);
            return apiProvider!;
          },
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(key: Key('login')),
        '/user/profile': (context) => ProfilePage(),
        '/user/incidents': (context) => const IncidentManagementPage(),
        '/forgot': (context) => ForgotPasswordPage(),
        '/admin/organization': (context) => OrganizationListScreen(),
        '/admin/users': (context) => UsersListPage(),
      },
    );
  }
}
