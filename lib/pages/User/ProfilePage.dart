import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../Providers/GeneralProvider.dart';
import '../../app_drawer.dart';
import '../../classes/user_entity.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<UserEntity?> futureProfile;

  Future<UserEntity?> fetchProfile() async {
    final response = await http.get(
      Uri.parse(
          '${Provider.of<GeneralProvider>(context, listen: false).url}/user/profile'),
      headers: {
        'Authorization':
            'Bearer ${Provider.of<GeneralProvider>(context, listen: false).token}'
      },
    );

    if (response.statusCode == 200) {
      var profileData = jsonDecode(response.body);
      return UserEntity.fromJson(profileData);
    } else {
      throw Exception('Error al obtener el perfil');
    }
  }

  @override
  void initState() {
    super.initState();
    futureProfile = fetchProfile();
    futureProfile.then((value) => {
          if (value == null)
            {Navigator.pushReplacementNamed(context, "/login")}
          else
            {
              Provider.of<GeneralProvider>(context, listen: false)
                  .setUser(value)
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Perfil')),
        drawer: AppDrawer(),
        body: Consumer<GeneralProvider>(
          builder: (context, provider, child) {
            return FutureBuilder<UserEntity?>(
              future: futureProfile,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  UserEntity profile = snapshot.data!;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditProfilePage(profile: profile),
                                ),
                              ).then((_) {
                                // Refresca el perfil cuando se regresa de la pantalla de edición
                                setState(() {});
                              });
                            },
                            child: ListTile(
                              title:
                                  Text('${profile.nombre} ${profile.apellido}'),
                              subtitle: Text(profile.email ?? ''),
                              leading: CircleAvatar(
                                child: Text(
                                  profile.nombre?[0].toUpperCase() ?? '',
                                  style: const TextStyle(fontSize: 22.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              trailing: const Icon(Icons.edit),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ExpansionTile(
                            initiallyExpanded: true,
                            title: const Text(
                              'Roles',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            children: [
                              for (UserRoles role in profile.roles ?? [])
                                ListTile(
                                  title: Text(role.nombre ?? 'ERROR'),
                                  leading: const Icon(Icons.check_circle,
                                      color: Colors.green),
                                ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ExpansionTile(
                              title: const Text(
                                "Procesos",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              children: [
                                for (UserOrganizaciones org
                                    in profile.organizaciones ?? [])
                                  ExpansionTile(
                                    title: Text(org.nombre ?? 'ERROR',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    children: [
                                      for (UserOrganizacionesProcesos proc
                                          in org.procesos ?? [])
                                        ListTile(
                                          title: Text(proc.nombre ?? 'ERROR'),
                                          leading: const Icon(
                                              Icons.check_circle,
                                              color: Colors.green),
                                        ),
                                    ],
                                  )
                              ]),
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            );
          },
        ));
  }
}
