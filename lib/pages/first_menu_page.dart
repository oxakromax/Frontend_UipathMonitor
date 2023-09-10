import 'package:flutter/material.dart';

class FirstMenuPage extends StatelessWidget {
  const FirstMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú principal'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¿Cuál es su rol?',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 30),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (constraints.maxHeight > constraints.maxWidth) {
                  // Pantalla más alta que ancha
                  return buildUserOptionsColumn(context);
                } else {
                  // Pantalla más ancha que alta
                  return buildUserOptionsRow(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUserOptionsColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildUserOption(
          context,
          Icons.admin_panel_settings,
          'Usuario',
          '/login',
        ),
        SizedBox(height: 20),
        buildUserOption(
          context,
          Icons.person,
          'Cliente',
          '/client',
        ),
      ],
    );
  }

  Widget buildUserOptionsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildUserOption(
          context,
          Icons.admin_panel_settings,
          'Administradores',
          '/login',
        ),
        buildUserOption(
          context,
          Icons.person,
          'Usuarios',
          '/client',
        ),
      ],
    );
  }

  Widget buildUserOption(
    BuildContext context,
    IconData icon,
    String title,
    String route,
  ) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
