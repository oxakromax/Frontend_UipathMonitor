import 'package:UipathMonitor/pages/Client/ticket_form_page.dart';
import 'package:UipathMonitor/pages/first_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Providers/ApiProvider.dart';
import 'Providers/GeneralProvider.dart';
import 'pages/Admin/Organization/OrganizationListPage.dart';
import 'pages/Admin/Users/UsersListPage.dart';
import 'pages/Dual/Processes/processes_list_page.dart';
import 'pages/ForgotPasswordPage.dart';
import 'pages/User/ProfilePage.dart';
import 'pages/User/incidentsUser/incident_management_page.dart';
import 'pages/login_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GeneralProvider("http://localhost:8080"),
        ),
        ChangeNotifierProxyProvider<GeneralProvider, ApiProvider>(
          create: (context) => ApiProvider("http://localhost:8080", ""),
          update: (context, generalProvider, apiProvider) {
            apiProvider?.updateToken(generalProvider.token);
            return apiProvider!;
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var generalProvider = Provider.of<GeneralProvider>(context);
    return MaterialApp(
      initialRoute: '/',
      routes: {
        "/": (context) => const FirstMenuPage(),
        "/client": (context) => const TicketFormPage(),
        '/login': (context) => const LoginPage(key: Key('login')),
        '/user/profile': (context) => generalProvider.token == ""
            ? const LoginPage(key: Key('login'))
            : ProfilePage(),
        '/user/incidents': (context) => const IncidentManagementPage(),
        '/forgot': (context) => ForgotPasswordPage(),
        '/admin/organization': (context) => OrganizationListScreen(),
        '/admin/users': (context) => const UsersListPage(),
        '/user/processes': (context) => const ProcessesListPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/user/profile') {
          return MaterialPageRoute(
            builder: (context) => ProfilePage(),
            fullscreenDialog: true,
          );
        }
        return null;
      },
    );
  }
}
