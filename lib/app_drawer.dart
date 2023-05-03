import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Providers/GeneralProvider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Text(
              'Menú',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Perfil'),
            onTap: () {
              RouteNavigator(context, '/user/profile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Gestión de incidentes'),
            onTap: () {
              RouteNavigator(context, '/user/incidents');
            },
          ),
          if (isAuthorized(context, '/admin/organization'))
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Gestión de organizaciones'),
              onTap: () {
                RouteNavigator(context, '/admin/organization');
              },
            ),
          if (isAuthorized(context, '/admin/users'))
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Gestión de usuarios'),
              onTap: () {
                RouteNavigator(context, '/admin/users');
              },
            ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Cerrar sesión'),
            onTap: () {
              // Actualiza el token en el Auth provider y cierra sesión
              Provider.of<GeneralProvider>(context, listen: false)
                  .logout(context);
            },
          ),
        ],
      ),
    );
  }

  bool isAuthorized(BuildContext context, String route) {
    // Verifica si el usuario está autorizado para acceder a la ruta
    return Provider.of<GeneralProvider>(context, listen: false)
        .isAuthorized(route);
  }

  Future<void> RouteNavigator(BuildContext context, String route) async {
    // Verifica si el usuario está autorizado para acceder a la ruta
    bool isAuthorized = Provider.of<GeneralProvider>(context, listen: false)
        .isAuthorized(route);

    if (isAuthorized ||
        route == '/user/profile' ||
        route == '/auth' ||
        route == '/logout') {
      if (ModalRoute.of(context)!.settings.name != route) {
        // Navega a la pantalla del perfil
        Navigator.pushNamed(context, route);
      } else {
        // Cierra el drawer
        Navigator.pop(context);
      }
    } else {
      // Muestra un mensaje si el usuario no está autorizado
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No tienes permiso para acceder a esta pantalla.'),
        ),
      );
    }
  }
}
