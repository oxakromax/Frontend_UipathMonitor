import 'package:UipathMonitor/Providers/ApiProvider.dart';
import 'package:UipathMonitor/Providers/GeneralProvider.dart';
import 'package:UipathMonitor/app_drawer.dart';
import 'package:UipathMonitor/classes/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'EditUserRolesDialogContent.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({super.key});

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  final _searchController = TextEditingController();
  final _selectedUsers = <UserEntity>[];

  @override
  Widget build(BuildContext context) {
    var _ApiProvider = Provider.of<ApiProvider>(context, listen: false);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Usuarios'),
        centerTitle: true,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_selectedUsers.isNotEmpty)
            FloatingActionButton(
              tooltip: 'Eliminar usuarios seleccionados',
              onPressed: () {
                // Implementa aquí el diálogo de eliminación de usuarios.
                // Por ejemplo, puedes llamar a la función deleteUserDialog (que aún no has creado) de la siguiente manera:
                deleteUserDialog(context, _selectedUsers);
              },
              child: const Icon(Icons.delete),
            ),
          const SizedBox(
            width: 10,
          ),
          if (_selectedUsers.isNotEmpty &&
              Provider.of<GeneralProvider>(context, listen: false)
                      .HasRole("downloader") ==
                  true)
            // Download button+
            FloatingActionButton(
              tooltip: 'Descargar usuarios seleccionados',
              onPressed: () {
                downloadUsers(context, _selectedUsers);
              },
              child: const Icon(Icons.download),
            ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            tooltip: 'Agregar usuario',
            onPressed: () {
              addUserDialog(context);
            },
            child: const Icon(Icons.person_add),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Buscar',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
              child: FutureBuilder(
                future: _searchController.text.isNotEmpty ?? false
                ? _ApiProvider.GetUsers(
                    query:
                        "Nombre like '%${_searchController.text}%' or Email like '%${_searchController.text}%' or Apellido like '%${_searchController.text}%'")
                : _ApiProvider.GetUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return userTile(snapshot, index);
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
        ],
      ),
    );
  }

  Widget userTile(AsyncSnapshot<dynamic> snapshot, int index) {
    UserEntity user = UserEntity.fromJson(snapshot.data[index]);
    final isSelected = _selectedUsers.any(
        (element) => element.iD == user.iD); // check if the user is selected
    if (Provider.of<GeneralProvider>(context, listen: false).user?.iD ==
        user.iD) {
      return const SizedBox();
    }
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.all(8),
        leading: Checkbox(
          value: isSelected,
          onChanged: (value) {
            setState(() {
              if (value ?? false) {
                _selectedUsers.add(user);
              } else {
                _selectedUsers.removeWhere((element) => element.iD == user.iD);
              }
            });
          },
        ),
        title: Text('${user.nombre} ${user.apellido}'),
        subtitle: Text(user.email ?? ''),
        trailing: // Edit button
            Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Edit Roles button
            IconButton(
              tooltip: 'Editar roles',
              onPressed: () {
                // Implementa aquí el diálogo de edición de roles del usuario.
                // Por ejemplo, puedes llamar a la función editUserRolesDialog (que aún no has creado) de la siguiente manera:
                editUserRolesDialog(context, user);
              },
              icon: const Icon(Icons.settings),
            ),
            // Edit user button
            IconButton(
              onPressed: () {
                editUserDialog(context, user);
              },
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
      ),
    );
  }

  Future addUserDialog(BuildContext context) {
    // Just nombre, apellido and email are required
    TextEditingController _nombreController = TextEditingController();
    TextEditingController _apellidoController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    // add a little text label to every field
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Agregar usuario'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _apellidoController,
                decoration: const InputDecoration(
                  labelText: 'Apellido',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // set the values to a map
                var json = {
                  "Nombre": _nombreController.text,
                  "Apellido": _apellidoController.text,
                  "Email": _emailController.text,
                };

                // Check if there is a empty field
                if (json.values.any((element) => element.isEmpty)) {
                  // if there is a empty field, open a new alert dialog
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Todos los campos son requeridos'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Ok'),
                          ),
                        ],
                      );
                    },
                  );
                  return;
                }
                // show a loading dialog
                showDialog(
                  context: context,
                  builder: (context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
                // call the addUser function from the ApiProvider
                Provider.of<ApiProvider>(context, listen: false)
                    .addUser(json)
                    .then((value) {
                  Navigator.pop(context); // close the loading dialog
                  // if the user was added successfully, close the dialog
                  Navigator.pop(context);
                  // Show a snackbar to notify the user
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Usuario agregado'),
                    ),
                  );
                  setState(() {
                    // refresh the list
                  });
                }).catchError((e) {
                  Navigator.pop(context); // close the loading dialog
                  // Close the dialog if there was an error and open new alert dialog
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: Text(e.toString()),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Ok'),
                          ),
                        ],
                      );
                    },
                  );
                });
              },
              child: const Text('Agregar'),
            ),
          ],
        );
      },
    );
  }

  Future deleteUserDialog(BuildContext context, List<UserEntity> users) async {
    // call the deleteUser function from the ApiProvider
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar usuario'),
          content: Text(users.length == 1
              ? '¿Está seguro que desea eliminar a ${users[0].nombre}?'
              : '¿Está seguro que desea eliminar a ${users.length} usuarios?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                var error = false;
                users.forEach((element) {
                  if (error) return;
                  Provider.of<ApiProvider>(context, listen: false)
                      .deleteUser(element.iD)
                      .catchError((e) {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) {
                        error = true;
                        return AlertDialog(
                          title: const Text('Error'),
                          content: Text(e.toString()),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Ok'),
                            ),
                          ],
                        );
                      },
                    );
                  });
                });
                if (!error) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(users.length == 1
                          ? 'Usuario eliminado'
                          : 'Usuarios eliminados'),
                    ),
                  );
                  setState(() {
                    // refresh the list
                  });
                }
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  Future editUserDialog(BuildContext context, UserEntity user) async {
    // Just nombre, apellido and email are required
    TextEditingController _nombreController =
        TextEditingController(text: user.nombre);
    TextEditingController _apellidoController =
        TextEditingController(text: user.apellido);
    TextEditingController _emailController =
        TextEditingController(text: user.email);
    // add a little text label to every field
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar usuario'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _apellidoController,
                decoration: const InputDecoration(
                  labelText: 'Apellido',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // set the values to a map
                var json = {
                  "ID": user.iD,
                  "Nombre": _nombreController.text,
                  "Apellido": _apellidoController.text,
                  "Email": _emailController.text,
                };

                // Check if there is a empty field
                if (json.values.any((element) => element == '')) {
                  // if there is a empty field, open a new alert dialog
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Todos los campos son requeridos'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Ok'),
                          ),
                        ],
                      );
                    },
                  );
                  return;
                } else {
                  // asign the values to the user
                  user.nombre = _nombreController.text;
                  user.apellido = _apellidoController.text;
                  user.email = _emailController.text;
                }
                // call the editUser function from the ApiProvider
                Provider.of<ApiProvider>(context, listen: false)
                    .editUser(user)
                    .then((value) {
                  // if the user was edited successfully, close the dialog
                  Navigator.pop(context);
                  // Show a snackbar to notify the user
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Usuario editado'),
                    ),
                  );
                  setState(() {
                    // refresh the list
                  });
                }).catchError((e) {
                  // Close the dialog if there was an error and open new alert dialog
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: Text(e.toString()),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Ok'),
                          ),
                        ],
                      );
                    },
                  );
                });
              },
              child: const Text('Editar'),
            ),
          ],
        );
      },
    );
  }

  Future editUserRolesDialog(BuildContext context, UserEntity user) async {
    var err = false;
    var AllRoles = await Provider.of<ApiProvider>(context, listen: false)
        .GetAllUserRoles()
        .catchError(
      (e) {
        err = true;
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(e.toString()),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok'),
                ),
              ],
            );
          },
        );
      },
    );
    if (err) return;
    // Display a dialog with a list of roles, the user can select one or more roles
    // if the user has a role, it will be selected by default
    // It uses UserRoles class, with the following fields:
    //  int? iD;
    //  String? nombre;
    //  String? description;
    var SelectedRoles = <UserRoles>[];
    AllRoles.forEach((element) {
      if (user.roles!.any((role) => role.iD == element.iD)) {
        SelectedRoles.add(element);
      }
    });
    // finally it add the roles selected to the user, and send a Update request like the editUserDialog
    // content: SizedBox
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar roles'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: EditUserRolesDialogContent(
              allRoles: AllRoles, selectedRoles: SelectedRoles),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                user.roles = SelectedRoles;
                Provider.of<ApiProvider>(context, listen: false)
                    .editUser(user)
                    .then((value) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Roles editados'),
                    ),
                  );
                  setState(() {
                    // refresh the list
                  });
                }).catchError((e) {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: Text(e.toString()),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Ok'),
                          ),
                        ],
                      );
                    },
                  );
                });
              },
              child: const Text('Editar'),
            ),
          ],
        );
      },
    );
  }

  downloadUsers(BuildContext context, List<UserEntity> selectedUsers) async {
    // Get ids of selected users separated by commas without the last comma
    String selectedUsersIds = '';
    for (int i = 0; i < selectedUsers.length; i++) {
      selectedUsersIds += selectedUsers[i].iD.toString() + ',';
    }
    selectedUsersIds =
        selectedUsersIds.substring(0, selectedUsersIds.length - 1);
    var result = await Provider.of<ApiProvider>(context, listen: false)
        .downloadUsersFile(selectedUsersIds);
    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Archivo descargado en $result'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al descargar el archivo'),
        ),
      );
    }
  }
}
