import 'package:UipathMonitor/Constants/TicketsConst.dart';
import 'package:UipathMonitor/Providers/ApiProvider.dart';
import 'package:UipathMonitor/Providers/GeneralProvider.dart';
import 'package:UipathMonitor/classes/processes_entity.dart';
import 'package:UipathMonitor/pages/Dual/Processes/processes_add_incident.dart';
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
  final _priorityEditController = TextEditingController();
  final _maxQueueEditController = TextEditingController();
  final _AliasEditController = TextEditingController();
  final _ScrollController = ScrollController();
  final _DataTableScrollController = ScrollController();

  var process = ProcessesEntity();

  var _ClientsNotAssigned = [];
  var _UsersNotAssigned = [];
  var _Editting = false;

  List<ProcessesIncidentesProceso> _filteredIncidents = [];

  List<ProcessesUsuarios> _selectedUsers = [];
  List<ProcessesClientes> _selectedClients = [];

  @override
  void initState() {
    super.initState();
    _processFuture = Provider.of<ApiProvider>(context, listen: false)
        .GetProcess(widget.processID);
  }

  void RefreshScaffold(BuildContext context) {
    // save scroll position
    final position = _ScrollController.position;

    setState(() {
      _processFuture = Provider.of<ApiProvider>(context, listen: false)
          .GetProcess(widget.processID);
    });

    try {
      // Try to return to last position
      Future.wait([
        _processFuture,
      ]).then((_) => {
            if (context.mounted)
              {
                // wait 200ms
                Future.delayed(const Duration(milliseconds: 200)).then((_) {
                  // restore scroll position
                  if (context.mounted) {
                    _ScrollController.position.moveTo(position.pixels);
                  }
                }),
              }
          });
    } catch (e, s) {
      print(s);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del proceso'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProcessesAddIncident(
                process: process,
              ),
            ),
          ).then((value) => RefreshScaffold(context));
        },
        child: const Icon(Icons.add),
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
            _AliasEditController.text = snapshot.data?.alias ?? '';
            _priorityEditController.text = '${snapshot.data?.prioridad ?? ''}';
            _maxQueueEditController.text =
                '${snapshot.data?.maxQueueTime ?? ''}';
            _filteredIncidents = snapshot.data?.incidentesProceso ?? [];
            if (_incidentSearchController.text.isNotEmpty) {
              // Filter the incidents based on the search input
              _filteredIncidents = _filteredIncidents.where((incident) {
                final search = _incidentSearchController.text;
                return incident.createdAt!.contains(search) ||
                    incident.iD!.toString().contains(search) ||
                    incident.descripcion!.contains(search);
              }).toList();
            }

            process = snapshot.data!;
            return _buildProcessDetails(context);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildProcessDetails(BuildContext context) {
    // ... (aquí irían las funciones que faltan para construir la interfaz gráfica, como _buildIncidentsSummary, _buildUserAssignment, _buildClientAssignment y _buildHelpMenu)
    var generalProvider = Provider.of<GeneralProvider>(context, listen: false);
    return SingleChildScrollView(
      controller: _ScrollController,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProcessInfo(context),
            if (process.incidentesProceso?.isNotEmpty ?? false)
              _buildIncidentsSummary(context),
            if (generalProvider.HasRole('processes_administration'))
              _buildUserAssignment(context),
            if (generalProvider.HasProcess(process.iD ?? 0) ||
                generalProvider.HasRole('processes_administration'))
              _buildClientAssignment(context),
            // _buildHelpMenu(),
          ],
        ),
      ),
    );
  }

  Widget _buildProcessInfo(BuildContext context) {
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
                  icon: _Editting
                      ? const Icon(Icons.save)
                      : const Icon(Icons.edit_outlined),
                  onPressed: () async {
                    _Editting = !_Editting;
                    if (!_Editting) {
                      process.warningTolerance =
                          int.tryParse(_warningEditController.text);
                      process.errorTolerance =
                          int.tryParse(_errorEditController.text);
                      process.fatalTolerance =
                          int.tryParse(_fatalEditController.text);
                      process.alias = _AliasEditController.text;
                      process.prioridad =
                          int.tryParse(_priorityEditController.text);
                      process.maxQueueTime =
                          int.tryParse(_maxQueueEditController.text);
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
            if (_Editting)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  const Text("Alias",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  // Box to edit the process alias
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: _AliasEditController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
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
            // Switch para activar/desactivar el monitoreo
            Row(
              children: [
                const Text(
                  'Monitoreo:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                Switch(
                  value: process.activeMonitoring ?? false,
                  onChanged: (value) async {
                    process.activeMonitoring = value;
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
                    setState(() {});
                  },
                ),
              ],
            ),

            // Warning Tolerance, Error Tolerance y Fatal Tolerance, con sus respectivos botones para editar, solo si _EditTolerance es true, sino se muestra el valor
            // La idea es que se muestre algo así como "Tolerancia de alertas"
            // y justo abajo una tabla con los valores de Warning Tolerance, Error Tolerance y Fatal Tolerance
            // que cuando se active el modo edición, se muestren los valores en un TextFormField
            // y ofrezca un boton para guardar los cambios
            const Text(
              'Tolerancia de alertas:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Show priority
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Prioridad: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                // si está en modo edición, mostrar el TextFormField, sino mostrar el valor
                if (_Editting)
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: TextFormField(
                      // max value: 10
                      controller: _priorityEditController,
                      enabled: _Editting,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      // onChanged: (value) {
                      //   setState(() {});
                      // },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        if (int.tryParse(value)! > 10) {
                          return 'Please enter a number between 0 and 10';
                        }
                        return null;
                      },
                    ),
                  )
                else
                  Text(
                    '${process.prioridad ?? 'No definida'}',
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                    // style: TextStyle(fontWeight: FontWeight.bold),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tiempo maximo de espera: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                // si está en modo edición, mostrar el TextFormField, sino mostrar el valor
                if (_Editting)
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: TextFormField(
                      // max value: 10
                      controller: _maxQueueEditController,
                      enabled: _Editting,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      // onChanged: (value) {
                      //   setState(() {});
                      // },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        if (int.tryParse(value)! > 120) {
                          return 'Please enter a number between 0 and 120';
                        }
                        return null;
                      },
                    ),
                  )
                else
                  Text(
                    '${process.maxQueueTime ?? 'No definida'}',
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                    // style: TextStyle(fontWeight: FontWeight.bold),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Tolerancias',
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.warning, color: Colors.yellow),
                          SizedBox(width: 8),
                          Text(
                            'Warning:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: _warningEditController,
                        enabled: _Editting,
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
                      const Row(
                        children: [
                          Icon(Icons.error, color: Colors.red),
                          SizedBox(width: 8),
                          Text(
                            'Error:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: _errorEditController,
                        enabled: _Editting,
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
                      const Row(
                        children: [
                          Icon(Icons.cancel, color: Colors.black),
                          SizedBox(width: 8),
                          Text(
                            'Fatal:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.fade,
                            softWrap: true,
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: _fatalEditController,
                        enabled: _Editting,
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

  Widget _buildIncidentsSummary(BuildContext context) {
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
                      hintText: 'Buscar por descripción o ID',
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
                checkboxHorizontalMargin: 0,
                controller: _DataTableScrollController,
                rowsPerPage: 5,
                columns: const [
                  DataColumn(label: Flexible(child: Text('ID'))),
                  DataColumn(label: Flexible(child: Text('Estado'))),
                  DataColumn(label: Flexible(child: Text('Tipo'))),
                  DataColumn(label: Flexible(child: Text('Fecha de creación'))),
                  DataColumn(label: Flexible(child: Text('Descripción'))),
                  DataColumn(label: Flexible(child: Text('Acciones'))),
                ],
                source: IncidentDataSource(context, process, _filteredIncidents,
                    () {
                  RefreshScaffold(context);
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
        return TicketsState.Started;
      case 2:
        return TicketsState.InProgress;
      case 3:
        return TicketsState.Completed;
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

  Widget _buildUserAssignment(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Usuarios asignados:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 70 *
                    (process.usuarios?.length != null &&
                                process.usuarios!.length < 5
                            ? process.usuarios?.length ?? 1
                            : 5)
                        .toDouble(),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    for (var user in process.usuarios ?? [])
                      CheckboxListTile(
                          title: Text('${user.nombre} ${user.apellido}'),
                          subtitle: Text(user.email),
                          value: _selectedUsers.contains(user),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value != null && value) {
                                _selectedUsers.add(user);
                              } else {
                                _selectedUsers.remove(user);
                              }
                            });
                          },
                          secondary: const Icon(Icons.person)),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () async {
                      var refresh = await _addUserDialog(context, process);
                      if (refresh) RefreshScaffold(context);
                    },
                    icon: const Icon(Icons.add_circle, color: Colors.green),
                    label: const Text('Agregar usuario'),
                  ),
                  TextButton.icon(
                    onPressed: () async {
                      var refresh = await _removeUserDialog(
                          context, process, _selectedUsers);
                      setState(() {
                        _selectedUsers.clear();
                      });
                      if (refresh) RefreshScaffold(context);
                    },
                    icon: const Icon(Icons.remove_circle_outline,
                        color: Colors.red),
                    label: const Text('Eliminar seleccionados'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClientAssignment(BuildContext context) {
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
            for (var client in process.clientes ?? [])
              CheckboxListTile(
                  title: Text('${client.nombre} ${client.apellido}'),
                  subtitle: Text(client.email),
                  value: _selectedClients.contains(client),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value != null && value) {
                        _selectedClients.add(client);
                      } else {
                        _selectedClients.remove(client);
                      }
                    });
                  },
                  secondary: const Icon(Icons.person)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () async {
                    // Refresh or not
                    if (await _addClientDialog(context, process))
                      RefreshScaffold(context);
                  },
                  icon: const Icon(Icons.add_circle, color: Colors.green),
                  label: const Text('Agregar cliente'),
                ),
                TextButton.icon(
                  onPressed: () async {
                    var refresh = await _removeClientDialog(
                        context, process, _selectedClients);
                    setState(() {
                      _selectedClients.clear();
                    });
                    if (refresh) RefreshScaffold(context);
                  },
                  icon: const Icon(Icons.remove_circle_outline,
                      color: Colors.red),
                  label: const Text('Eliminar seleccionados'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpMenu() {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
  Future<bool> _addUserDialog(
    BuildContext context,
    ProcessesEntity process,
  ) async {
    final List<ProcessesUsuarios>? users =
        await Provider.of<ApiProvider>(context, listen: false)
            .getUsersPossibleForProcess(process.iD);
    final List<ProcessesUsuarios> selectedUsers = <ProcessesUsuarios>[];

    if (!context.mounted) return false;

    var refresh = false;

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Agregar usuario',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          for (final ProcessesUsuarios user in users ?? [])
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4.0,
                              ),
                              child: CheckboxListTile(
                                title: Text(
                                  '${user.nombre} ${user.apellido}',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  '${user.email}',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
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
                                activeColor: Colors.blue,
                                checkColor: Colors.white,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: const Text('Cancelar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(width: 8.0),
                    ElevatedButton(
                      child: const Text('Agregar'),
                      onPressed: () async {
                        await Provider.of<ApiProvider>(context, listen: false)
                            .addUsersToProcess(process.iD, selectedUsers);
                        Navigator.of(context).pop();
                        refresh = true;
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
    return refresh;
  }

  Future<bool> _addClientDialog(
      BuildContext context, ProcessesEntity process) async {
    final List<ProcessesClientes>? clients =
        await Provider.of<ApiProvider>(context, listen: false)
            .getClientsPossibleForProcess(process.iD);
    final List<ProcessesClientes> selectedClients = <ProcessesClientes>[];
    var refresh = false;
    if (!context.mounted) return refresh;

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Agregar cliente',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          for (final ProcessesClientes client in clients ?? [])
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4.0,
                              ),
                              child: CheckboxListTile(
                                title: Text(
                                  '${client.nombre} ${client.apellido}',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  '${client.email}',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                                value: selectedClients.contains(client),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value != null && value) {
                                      selectedClients.add(client);
                                    } else {
                                      selectedClients.remove(client);
                                    }
                                  });
                                },
                                activeColor: Colors.blue,
                                checkColor: Colors.white,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: const Text('Cancelar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(width: 8.0),
                    ElevatedButton(
                      child: const Text('Agregar'),
                      onPressed: () async {
                        await Provider.of<ApiProvider>(context, listen: false)
                            .addClientsToProcess(process.iD, selectedClients);
                        Navigator.of(context).pop();
                        refresh = true;
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
    return refresh;
  }

  Future<bool> _removeUserDialog(BuildContext context, ProcessesEntity process,
      List<ProcessesUsuarios> users) async {
    String message;
    if (users.length == 1) {
      message =
          '¿Está seguro que desea eliminar a ${users[0].nombre} ${users[0].apellido} del proceso?';
    } else {
      message =
          '¿Está seguro que desea eliminar a ${users.length} usuarios del proceso?';
    }
    var refresh = false;
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar usuario'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
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
                for (final user in users) {
                  await Provider.of<ApiProvider>(context, listen: false)
                      .removeUserFromProcess(process.iD, user.iD);
                }
                if (!context.mounted) return;
                Navigator.of(context).pop();
                refresh = true;
              },
            ),
          ],
        );
      },
    );
    return refresh;
  }

  // Same as above, but for clients

  Future<bool> _removeClientDialog(BuildContext context,
      ProcessesEntity process, List<ProcessesClientes> client) async {
    String message;
    if (client.length == 1) {
      message =
          '¿Está seguro que desea eliminar a ${client[0].nombre} ${client[0].apellido} del proceso?';
    } else {
      message =
          '¿Está seguro que desea eliminar a ${client.length} clientes del proceso?';
    }
    var refresh = false;
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar cliente'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
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
                for (final client in client) {
                  await Provider.of<ApiProvider>(context, listen: false)
                      .removeClientFromProcess(process.iD, client.iD);
                }
                if (!context.mounted) return;
                Navigator.of(context).pop();
                refresh = true;
              },
            ),
          ],
        );
      },
    );
    return refresh;
  }
}
