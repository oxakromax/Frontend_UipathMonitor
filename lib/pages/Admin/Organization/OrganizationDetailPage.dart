import 'package:UipathMonitor/Providers/GeneralProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:UipathMonitor/pages/Admin/Organization/OrganizationCreationOrEditPage.dart';

import '../../../Providers/ApiProvider.dart';

class OrganizationDetailsPage extends StatefulWidget {
  final int id;

  const OrganizationDetailsPage({super.key, required this.id});

  @override
  State<OrganizationDetailsPage> createState() =>
      _OrganizationDetailsPageState();
}

class _OrganizationDetailsPageState extends State<OrganizationDetailsPage> {
  ValueNotifier<Map<String, dynamic>> organizationNotifier =
  ValueNotifier<Map<String, dynamic>>({}); // <==

  void loadData() async {
    var apiProvider = Provider.of<ApiProvider>(context, listen: false);
    final data = await apiProvider.getOrganization(widget.id);
    organizationNotifier.value = data;
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    var apiProvider = Provider.of<ApiProvider>(context, listen: false);
    var _userFinderController = TextEditingController();
    var _userFinder = '';
    var _clientFinderController = TextEditingController();
    var _clientFinder = '';
    var _processFinderController = TextEditingController();
    var _processFinder = '';
    var _nameController = TextEditingController();
    var _lastNameController = TextEditingController();
    var _emailController = TextEditingController();

    return Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Download data button
            if (Provider.of<GeneralProvider>(context, listen: false)
                    .HasRole("downloader") ==
                true)
              FloatingActionButton(
                heroTag: 'downloadData',
                tooltip: 'Descargar Info.',
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.download_rounded),
                    Text("Descargar Info.",
                        style: TextStyle(fontSize: 10),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
                onPressed: () async {
                  var result =
                      await apiProvider.downloadOrganizationFile(widget.id);
                  if (result != null) {
                    // se obtiene el Path del archivo en Result, se debe mostrar en pantalla como una ventana emergente que indique donde se guardo el archivo
                    if (!context.mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        // Data downloaded in result
                        content: Text("Data downloaded in $result"),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  } else {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Error downloading data'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
              ),
            const SizedBox(width: 10),
            FloatingActionButton(
              heroTag: 'editOrg',
              tooltip: 'Editar Organización',
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.edit),
                  Text("Editar Organización",
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
              onPressed: () async {
                var updated = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrganizationCreationOrEditPage(
                          isEditing: true, org: organizationNotifier.value)),
                );
                if (updated != null) {
                  organizationNotifier.value = {};
                  setState(() {});
                  loadData();
                }
              },
            ),
            const SizedBox(width: 10),
            SizedBox(
              child: FloatingActionButton(
                  heroTag: 'addClient',
                  tooltip: 'Agregar Cliente',
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    textDirection: TextDirection.ltr,
                    children: [
                      Icon(Icons.person_add),
                      Text("Agregar Cliente",
                          style: TextStyle(fontSize: 10),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                  onPressed: () => {
                    // little widget to add a client
                    AddClientDialog(context, _nameController,
                        _lastNameController, _emailController, apiProvider)
                  }),
            ),
            const SizedBox(width: 10),
            SizedBox(
              child: FloatingActionButton(
                  heroTag: 'addUser',
                  tooltip: 'Agregar Usuario',
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    textDirection: TextDirection.ltr,
                    children: [
                      Icon(Icons.person_add_alt_1_sharp),
                      Text("Agregar Usuario",
                          style: TextStyle(fontSize: 10),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                  onPressed: () async {
                    var Users = await apiProvider.GetUsers(
                        relational_condition: "NotInOrg",
                        relational_query:
                        organizationNotifier.value['ID'].toString());
                    if (Users == null) {
                      return;
                    }
                    if (!context.mounted) {
                      return;
                    }
                    await AddUserDialog(context, _userFinderController,
                        _userFinder, Users, apiProvider);
                  }),
            ),
            const SizedBox(width: 10),
            FloatingActionButton(
              heroTag: 'deleteOrganization',
              tooltip: 'Eliminar Organización',
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.delete),
                  Text('Eliminar Organización',
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
              onPressed: () async {
                // Show a dialog to the user to confirm deletion
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Confirmar'),
                    content: const Text(
                        'Estas seguro de eliminar? Recuerda que esta accion es irreversible'),
                    actions: [
                      TextButton(
                        child: const Text('Cancelar'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      TextButton(
                        child: const Text('Eliminar'),
                        onPressed: () async {
                          await apiProvider.deleteOrganization(widget.id);
                          if (!context.mounted) return;
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        appBar: AppBar(
          title: const Text('Detalles de la Organización'),
          actions: [
            // Hint button
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () async {
                // Show a dialog to the user to confirm deletion
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Informacion'),
                    content: RichText(
                      textAlign: TextAlign.justify,
                      text: const TextSpan(
                        style: TextStyle(
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis),
                        children: [
                          TextSpan(
                              text:
                                  '''Esta pantalla muestra información sobre la organización seleccionada.\n\n'''),
                          TextSpan(
                              text: '''Sobre los usuarios y clientes:\n''',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text:
                                  '''Recuerda que si eliminas a un usuario o cliente de la organización, lo eliminarás de todos los procesos asociados a la misma. En el caso del cliente, este será eliminado de manera permanente.
Por otra parte, en esta pantalla podrás agregar clientes, pero los usuarios son agregados para posteriormente ser asignados por proceso a la organización, por lo tanto solo estarás otorgando el derecho a ser asignado a un proceso dentro de la organización y no al proceso en si.\n\n'''),
                          TextSpan(
                              text: '''Sobre los procesos:\n''',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text:
                                  '''Los procesos son inmutables, es decir, no se pueden eliminar, solo asignarles un "Alias" para identificarlos. ya que estos son automaticamente obtenidos desde el Orchestrator de UiPath.'''),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Cerrar'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        body: ValueListenableBuilder<Map<String, dynamic>>(
          valueListenable: organizationNotifier,
          builder: (context, snapshot, child) {
            if (snapshot.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return SingleChildScrollView(
                padding: const EdgeInsets.only(
                    top: 10, left: 10, right: 10, bottom: 100),
                child: Column(
                  children: [
                    Card(
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text('Nombre'),
                            subtitle: Text(snapshot['Nombre']),
                          ),
                          ListTile(
                            title: const Text('Cloud URL'),
                            subtitle: Text(snapshot['BaseURL'] +
                                snapshot['Uipathname'] +
                                "/" +
                                snapshot['Tenantname']),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        children: [
                          ExpansionTile(
                              title: const Text('Usuarios'),
                              leading: const Icon(
                                Icons.person,
                                color: Colors.blue,
                              ),
                              children: [
                                // Search bar
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _userFinderController,
                                    decoration: const InputDecoration(
                                      labelText: 'Buscar',
                                      prefixIcon: Icon(Icons.search),
                                    ),
                                    onChanged: (value) {
                                      _userFinder = value;
                                      RefreshNotifier();
                                    },
                                  ),
                                ),
                                for (var usuario in _userFinder != ""
                                    ? snapshot['Usuarios'].where((element) =>
                                element['Nombre']
                                    .toLowerCase()
                                    .contains(_userFinder) ||
                                    element['Apellido']
                                        .toLowerCase()
                                        .contains(_userFinder) ||
                                    element['Email']
                                        .toLowerCase()
                                        .contains(_userFinder))
                                    : snapshot['Usuarios'])
                                  ListTile(
                                    title: Text(usuario['Nombre'] +
                                        " " +
                                        usuario['Apellido']),
                                    subtitle: Text(usuario['Email']),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () async {
                                        // Show a dialog to the user to confirm deletion
                                        await showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text('Confirmar'),
                                            content: const Text(
                                                'Estas seguro de eliminar? Recuerda que esta accion es irreversible'),
                                            actions: [
                                              TextButton(
                                                child: const Text('Cancelar'),
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                              ),
                                              TextButton(
                                                child: const Text('Eliminar'),
                                                onPressed: () async {
                                                  await apiProvider
                                                      .UpdateOrganizationUser(
                                                      widget.id,
                                                      deleteUsers: [
                                                        usuario['ID']
                                                      ]);
                                                  if (!context.mounted) return;
                                                  Navigator.of(context).pop();
                                                  loadData();
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )
                              ]),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        children: [
                          ExpansionTile(
                              title: const Text('Clientes'),
                              leading: const Icon(
                                Icons.person,
                                color: Colors.blue,
                              ),
                              children: [
                                // Search bar
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _clientFinderController,
                                    decoration: const InputDecoration(
                                      labelText: 'Buscar',
                                      prefixIcon: Icon(Icons.search),
                                    ),
                                    onChanged: (value) {
                                      _clientFinder = value;
                                      RefreshNotifier();
                                    },
                                  ),
                                ),
                                for (var cliente in _clientFinder != ""
                                    ? snapshot['Clientes'].where((element) =>
                                element['Nombre']
                                    .toLowerCase()
                                    .contains(
                                    _clientFinder.toLowerCase()) ||
                                    element['Apellido']
                                        .toLowerCase()
                                        .contains(
                                        _clientFinder.toLowerCase()) ||
                                    element['Email'].toLowerCase().contains(
                                        _clientFinder.toLowerCase()))
                                    : snapshot['Clientes'])
                                  ListTile(
                                    title: Text(cliente['Nombre'] +
                                        " " +
                                        cliente['Apellido']),
                                    subtitle: Text(cliente['Email']),
                                    trailing: Row(
                                      // 2 IconsButtons, for editing and deleting
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        EditClientButton(cliente, context,
                                            apiProvider, snapshot),
                                        IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () async {
                                            // Show a dialog to the user to confirm deletion
                                            await showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text('Confirmar'),
                                                content: const Text(
                                                    'Estas seguro de eliminar? Recuerda que esta accion es irreversible'),
                                                actions: [
                                                  TextButton(
                                                    child:
                                                    const Text('Cancelar'),
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                  ),
                                                  TextButton(
                                                    child:
                                                    const Text('Eliminar'),
                                                    onPressed: () async {
                                                      try {
                                                        await apiProvider
                                                            .deleteOrganizationClient(
                                                            cliente);
                                                        loadData();
                                                        if (!context.mounted)
                                                          return;
                                                        Navigator.of(context)
                                                            .pop();
                                                      } catch (e) {
                                                        // show msgbox with error
                                                        await showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              AlertDialog(
                                                                title: const Text(
                                                                    'Error'),
                                                                content: Text(
                                                                    e.toString()),
                                                                actions: [
                                                                  TextButton(
                                                                    child: const Text(
                                                                        'Cerrar'),
                                                                    onPressed: () =>
                                                                        Navigator.of(
                                                                            context)
                                                                            .pop(),
                                                                  ),
                                                                ],
                                                              ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                              ]),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        children: [
                          ExpansionTile(
                              title: const Text('Procesos'),
                              leading: const Icon(
                                Icons.work,
                                color: Colors.blue,
                              ),
                              initiallyExpanded: true,
                              children: [
                                // Search bar
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _processFinderController,
                                    decoration: const InputDecoration(
                                      labelText: 'Buscar',
                                      prefixIcon: Icon(Icons.search),
                                    ),
                                    onChanged: (value) {
                                      _processFinder = value;
                                      RefreshNotifier();
                                    },
                                  ),
                                ),
                                for (var proceso in _processFinder != ""
                                    ? snapshot['Procesos'].where((element) =>
                                element['Nombre']
                                    .toLowerCase()
                                    .contains(
                                    _processFinder.toLowerCase()) ||
                                    element['Foldername']
                                        .toLowerCase()
                                        .contains(
                                        _processFinder.toLowerCase()) ||
                                    element['Alias'].toLowerCase().contains(
                                        _processFinder.toLowerCase()))
                                    : snapshot['Procesos'])
                                  ListTile(
                                      title: Text(proceso['Alias'] != ""
                                          ? proceso['Alias']
                                          : proceso['Nombre']),
                                      subtitle: Text(
                                          "${"Folder ID: ${proceso['Folderid']} (" + proceso['Foldername']})"),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () async {
                                          // Show a dialog to the user to confirm deletion
                                          TextEditingController _controller =
                                          TextEditingController(
                                              text: proceso['Alias']);
                                          await showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text('Editar'),
                                              content: TextField(
                                                controller: _controller,
                                                decoration:
                                                const InputDecoration(
                                                  hintText: 'Alias',
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: const Text('Cancelar'),
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                ),
                                                TextButton(
                                                  child: const Text('Editar'),
                                                  onPressed: () async {
                                                    await apiProvider
                                                        .updateOrganizationProcess(
                                                        proceso['ID'],
                                                        _controller.text);
                                                    if (!context.mounted)
                                                      return;
                                                    loadData();
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      )),
                              ]),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ));
  }

  IconButton EditClientButton(cliente, BuildContext context,
      ApiProvider apiProvider, Map<String, dynamic> snapshot) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () async {
        // Show a dialog to the user to confirm deletion
        TextEditingController _NameController =
        TextEditingController(text: cliente['Nombre']);
        TextEditingController _LastNameController =
        TextEditingController(text: cliente['Apellido']);
        TextEditingController _EmailController =
        TextEditingController(text: cliente['Email']);
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Editar'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _NameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                  ),
                ),
                TextField(
                  controller: _LastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Apellido',
                  ),
                ),
                TextField(
                  controller: _EmailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                child: const Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                  child: const Text('Guardar'),
                  onPressed: () async {
                    var sucess =
                    await apiProvider.CreateOrUpdateOrganizationClient({
                      'ID': cliente['ID'],
                      'Nombre': _NameController.text,
                      'Apellido': _LastNameController.text,
                      'Email': _EmailController.text,
                      'OrganizacionID': snapshot['ID']
                    });
                    if (!context.mounted) {
                      return;
                    }
                    if (!sucess) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'Error al editar cliente, por favor verifica que el correo no este en uso'),
                      ));
                      return;
                    } else {
                      Navigator.of(context).pop();
                      loadData();
                    }
                  })
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> AddClientDialog(BuildContext context,
      TextEditingController _nameController,
      TextEditingController _lastNameController,
      TextEditingController _emailController,
      ApiProvider apiProvider) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Agregar Cliente'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
              ),
            ),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Apellido',
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Agregar'),
            onPressed: () async {
              await apiProvider.CreateOrUpdateOrganizationClient({
                'Nombre': _nameController.text,
                'Apellido': _lastNameController.text,
                'Email': _emailController.text,
                'OrganizacionID': widget.id,
              });
              if (!context.mounted) return;
              Navigator.of(context).pop();
              loadData();
            },
          ),
        ],
      ),
    );
  }

  void RefreshNotifier() {
    var oldValue = organizationNotifier.value;
    organizationNotifier.value = ({});
    organizationNotifier.value = oldValue;
  }

  Future AddUserDialog(BuildContext context,
      TextEditingController userFinderController,
      String userFinder,
      List<dynamic> value,
      ApiProvider apiProvider) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Agregar Usuario'),
        scrollable: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: SizedBox(
          width: 800,
          height: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: userFinderController,
                decoration: const InputDecoration(
                  labelText: 'Buscar',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  userFinder = value;
                  RefreshNotifier();
                },
              ),
              for (var user in userFinder != ""
                  ? value.where((element) =>
              element['Nombre']
                  .toLowerCase()
                  .contains(userFinder.toLowerCase()) ||
                  element['Apellido']
                      .toLowerCase()
                      .contains(userFinder.toLowerCase()) ||
                  element['Email']
                      .toLowerCase()
                      .contains(userFinder.toLowerCase()))
                  : value)
                ListTile(
                    title: Text(user['Nombre'] + " " + user['Apellido']),
                    subtitle: Text(user['Email']),
                    trailing: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () async {
                        await apiProvider.UpdateOrganizationUser(widget.id,
                            newUsers: [user['ID']]);
                        if (!context.mounted) return;
                        Navigator.of(context).pop();
                        loadData();
                      },
                    )),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
