
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    futureProfile =
        Provider.of<GeneralProvider>(context, listen: false).fetchProfile();
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
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
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
                              // Refresh the profile when returning from the edit screen
                              setState(() {});
                            });
                          },
                          child: ListTile(
                            title: Text(
                              '${profile.nombre} ${profile.apellido}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            subtitle: Text(
                              profile.email ?? '',
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            leading: CircleAvatar(
                              child: Text(
                                profile.nombre?[0].toUpperCase() ?? '',
                                style: const TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
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
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          children: [
                            for (UserRoles role in profile.roles ?? [])
                              ListTile(
                                title: Text(
                                  role.nombre ?? 'ERROR',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                leading: const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ExpansionTile(
                          title: const Text(
                            "Procesos",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          children: [
                            for (UserOrganizaciones org
                                in profile.organizaciones ?? [])
                              ExpansionTile(
                                title: Text(
                                  org.nombre ?? 'ERROR',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                children: [
                                  for (UserOrganizacionesProcesos proc
                                      in org.procesos ?? [])
                                    ListTile(
                                      title: Text(
                                        proc.nombre ?? 'ERROR',
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      leading: const Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      ),
                                    ),
                                ],
                              )
                          ],
                        ),
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
      ),
    );
  }
}
