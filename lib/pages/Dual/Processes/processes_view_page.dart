import 'package:UipathMonitor/Providers/ApiProvider.dart';
import 'package:UipathMonitor/classes/processes_entity.dart';
import 'package:UipathMonitor/pages/User/incidentsUser/incident_details_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'IncidentDataSource.dart';

class ProcessesViewPage extends StatefulWidget {
  final int processID;

  ProcessesViewPage({Key? key, required this.processID}) : super(key: key);

  @override
  _ProcessesViewPageState createState() => _ProcessesViewPageState();
}

class _ProcessesViewPageState extends State<ProcessesViewPage> {
  late Future<ProcessesEntity> _processFuture;
  final _incidentSearchController = TextEditingController();
  final _warningEditController = TextEditingController();
  final _errorEditController = TextEditingController();
  final _fatalEditController = TextEditingController();
  final _UserSearchController = TextEditingController();
  final _ClientSearchController = TextEditingController();

  var _ClientsNotAssigned = [];
  var _UsersNotAssigned = [];
  var _EditTolerance = false;

  List<ProcessesIncidentesProceso> _filteredIncidents = [];

  @override
  void initState() {
    super.initState();
    _processFuture = Provider.of<ApiProvider>(context, listen: false)
        .GetProcess(widget.processID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del proceso'),
      ),
      body: FutureBuilder<ProcessesEntity>(
        future: _processFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(
                  child: Text('Error al obtener la información del proceso'));
            }
            _warningEditController.text =
                '${snapshot.data?.warningTolerance ?? ''}';
            _errorEditController.text =
                '${snapshot.data?.errorTolerance ?? ''}';
            _fatalEditController.text =
                '${snapshot.data?.fatalTolerance ?? ''}';
            _filteredIncidents = snapshot.data?.incidentesProceso ?? [];
            if (_incidentSearchController.text.isNotEmpty) {
              // Filter the incidents based on the search input
              _filteredIncidents = _filteredIncidents.where((incident) {
                final search = _incidentSearchController.text;
                return incident.createdAt!.contains(search) ||
                    incident.iD!.toString().contains(search);
              }).toList();
            }

            return _buildProcessDetails(snapshot.data!, context);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildProcessDetails(ProcessesEntity process, BuildContext context) {
    // ... (aquí irían las funciones que faltan para construir la interfaz gráfica, como _buildIncidentsSummary, _buildUserAssignment, _buildClientAssignment y _buildHelpMenu)

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProcessInfo(process, context),
            if (process.incidentesProceso?.isNotEmpty ?? false)
              _buildIncidentsSummary(process, context),
            _buildUserAssignment(process, context),
            _buildClientAssignment(process, context),
            _buildHelpMenu(),
          ],
        ),
      ),
    );
  }

  Widget _buildProcessInfo(ProcessesEntity process, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Organización
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  // top padding
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    '${process.organizacion?.nombre ?? ''}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 8),
                // Botón para editar la organización
                IconButton(
                  icon: _EditTolerance
                      ? const Icon(Icons.save)
                      : const Icon(Icons.edit_outlined),
                  onPressed: () async {
                    _EditTolerance = !_EditTolerance;
                    if (!_EditTolerance) {
                      process.warningTolerance =
                          int.tryParse(_warningEditController.text);
                      process.errorTolerance =
                          int.tryParse(_errorEditController.text);
                      process.fatalTolerance =
                          int.tryParse(_fatalEditController.text);
                      try {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        );
                        await Provider.of<ApiProvider>(context, listen: false)
                            .UpdateProcess(process);
                        Navigator.pop(context); // Cerrar el diálogo de carga
                      } catch (error) {
                        Navigator.pop(context); // Cerrar el diálogo de carga
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Error'),
                            content: Text(
                                'Ha ocurrido un error al actualizar el proceso: $error'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                    setState(() {});
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Nombre:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Nombre del proceso
            Text(
              '${process.nombre ?? ''}${process.alias != "" ? ' (${process.alias})' : ''}',
              // style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // FolderName
            const Text(
              'Folder:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '${process.foldername ?? ''}',
              // style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Cantidad de incidentes
            const Text(
              'Incidentes:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '${process.incidentesProceso?.length ?? 0}',
              // style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Warning Tolerance, Error Tolerance y Fatal Tolerance, con sus respectivos botones para editar, solo si _EditTolerance es true, sino se muestra el valor
            // La idea es que se muestre algo así como "Tolerancia de alertas"
            // y justo abajo una tabla con los valores de Warning Tolerance, Error Tolerance y Fatal Tolerance
            // que cuando se active el modo edición, se muestren los valores en un TextFormField
            // y ofrezca un boton para guardar los cambios
            const Text(
              'Tolerancia de alertas:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.warning, color: Colors.yellow),
                          SizedBox(width: 8),
                          Text(
                            'Warning Tolerance:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: _warningEditController,
                        enabled: _EditTolerance,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.error, color: Colors.red),
                          SizedBox(width: 8),
                          Text(
                            'Error Tolerance:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: _errorEditController,
                        enabled: _EditTolerance,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.cancel, color: Colors.black),
                          SizedBox(width: 8),
                          Text(
                            'Fatal Tolerance:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: _fatalEditController,
                        enabled: _EditTolerance,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIncidentsSummary(ProcessesEntity process, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumen de incidentes:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    key: ValueKey(_incidentSearchController.text),
                    controller: _incidentSearchController,
                    decoration: const InputDecoration(
                      hintText: 'Buscar por nombre o ID',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: const Text('Buscar'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: PaginatedDataTable(
                // header: Text('Incidentes'),
                rowsPerPage: 5,
                columns: const [
                  DataColumn(label: Text('ID'), numeric: true),
                  DataColumn(label: Text('Estado')),
                  DataColumn(label: Text('Fecha de creación')),
                  DataColumn(label: Text('Descripción')),
                  DataColumn(label: Text('Acciones')),
                ],
                source: IncidentDataSource(context, process, _filteredIncidents,
                    () {
                  setState(() {});
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildIncidentStateIcon(int state) {
    switch (state) {
      case 1:
        return const Icon(Icons.play_arrow, color: Colors.blue);
      case 2:
        return const Icon(Icons.timelapse, color: Colors.orange);
      case 3:
        return const Icon(Icons.check_circle, color: Colors.green);
      default:
        return const Icon(Icons.error, color: Colors.red);
    }
  }

  String _getIncidentStateText(int state) {
    switch (state) {
      case 1:
        return 'Iniciado';
      case 2:
        return 'En progreso';
      case 3:
        return 'Completado';
      default:
        return 'Desconocido';
    }
  }

  String _formatDate(String date) {
    final parsedDate = DateTime.tryParse(date);
    if (parsedDate == null) {
      return '';
    }
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(parsedDate);
  }

  Widget _buildUserAssignment(ProcessesEntity process, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Usuarios asignados:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            for (final user in process.usuarios ?? [])
              ListTile(
                title: Text('${user.nombre} ${user.apellido}'),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle, color: Colors.red),
                  onPressed: () async {
                    await _removeUserDialog(context, process, user)
                        .then((value) => setState(() {}));
                  },
                ),
              ),
            TextButton.icon(
              onPressed: () async {
                await _addUserDialog(context, process).then((value) {
                  setState(() {});
                });
              },
              icon: const Icon(Icons.add_circle, color: Colors.green),
              label: const Text('Agregar usuario'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClientAssignment(ProcessesEntity process, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Clientes asignados:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            for (final client in process.clientes ?? [])
              ListTile(
                title: Text('${client.nombre} ${client.apellido}'),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle, color: Colors.red),
                  onPressed: () {
                    // Lógica para eliminar al cliente del proceso
                  },
                ),
              ),
            TextButton.icon(
              onPressed: () {
                // Lógica para mostrar un diálogo y agregar un cliente al proceso
              },
              icon: const Icon(Icons.add_circle, color: Colors.green),
              label: const Text('Agregar cliente'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpMenu() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Ayuda:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '1. En el Resumen de incidentes, puede tocar un incidente para ver detalles adicionales.\n'
              '2. En Usuarios asignados, puede eliminar a un usuario del proceso tocando el ícono de menos rojo, o agregar un nuevo usuario tocando "Agregar usuario".\n'
              '3. En Clientes asignados, puede eliminar a un cliente del proceso tocando el ícono de menos rojo, o agregar un nuevo cliente tocando "Agregar cliente".\n'
              '4. Utilice el menú de ayuda para obtener información adicional sobre cómo utilizar las funciones de la página de procesos.',
            ),
          ],
        ),
      ),
    );
  }

  // Add User Dialog, display a list of selectable users to add to the process, and add them when the user presses the "Add" button
  // the list of users is obtained from the API via GetUsersPossibleForProcess and it's returns list<ProcessesUsuarios>

  // start code
  Future<void> _addUserDialog(
      BuildContext context, ProcessesEntity process) async {
    final List<ProcessesUsuarios>? users =
        await Provider.of<ApiProvider>(context, listen: false)
            .getUsersPossibleForProcess(process.iD);
    final List<ProcessesUsuarios> selectedUsers = <ProcessesUsuarios>[];

    if (!context.mounted) return;

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agregar usuario'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    for (final ProcessesUsuarios user in users ?? [])
                      CheckboxListTile(
                        title: Text('${user.nombre} ${user.apellido}'),
                        value: selectedUsers.contains(user),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value != null && value) {
                              selectedUsers.add(user);
                            } else {
                              selectedUsers.remove(user);
                            }
                          });
                        },
                      ),
                  ],
                ),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Agregar'),
              onPressed: () async {
                await Provider.of<ApiProvider>(context, listen: false)
                    .addUsersToProcess(process.iD, selectedUsers)
                    .then((value) => setState(() {}));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _removeUserDialog(
      BuildContext context, ProcessesEntity process, user) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar usuario'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('¿Está seguro que desea eliminar a ${user.nombre} '
                    '${user.apellido} del proceso?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Eliminar'),
              onPressed: () async {
                await Provider.of<ApiProvider>(context, listen: false)
                    .removeUserFromProcess(process.iD, user.iD)
                    .then((value) => setState(() {}));
                if (!context.mounted) return;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
