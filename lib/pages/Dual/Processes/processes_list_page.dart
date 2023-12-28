import 'package:UipathMonitor/Providers/ApiProvider.dart';
import 'package:UipathMonitor/Providers/GeneralProvider.dart';
import 'package:UipathMonitor/pages/Dual/Processes/processes_view_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app_drawer.dart';

class ProcessesListPage extends StatefulWidget {
  const ProcessesListPage({Key? key}) : super(key: key);

  @override
  _ProcessesListPageState createState() => _ProcessesListPageState();
}

class _ProcessesListPageState extends State<ProcessesListPage> {
  TextEditingController _searchController = TextEditingController();
  late List<bool> _isSelectedList;
  late List<dynamic> processes = [];

  @override
  void initState() {
    super.initState();
    _isSelectedList = []; // Inicializa la lista de selección
  }

  bool get _isAnyItemSelected => _isSelectedList.any((element) => element);

  @override
  Widget build(BuildContext context) {
    var apiProvider = Provider.of<ApiProvider>(context, listen: false);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Procesos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Ayuda'),
                    content: const Text(
                      'Si tienes el rol de administrador de procesos, se desplegarán todas las organizaciones en donde el usuario esté asignado y sus procesos. En cambio, si no, solo se mostrarán los procesos que se han asignado al usuario por un administrador.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Entendido'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onEditingComplete: () {
                setState(() {});
              },
              decoration: const InputDecoration(
                labelText: 'Buscar',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Consumer<ApiProvider>(
              builder: (context, apiProvider, child) {
                return FutureBuilder<dynamic>(
                  future: apiProvider.GetProcesses(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting &&
                        processes.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: Text('Error al cargar los datos'));
                    } else {
                      processes = snapshot.data;
                      if (_searchController.text.isNotEmpty) {
                        processes = processes.where((process) {
                          String searchTerm =
                              _searchController.text.toLowerCase();
                          String processName = (process['Alias'].isEmpty
                                  ? process['Nombre']
                                  : process['Alias'])
                              .toLowerCase();
                          return processName.contains(searchTerm);
                        }).toList();
                      }

                      processes
                          .sort((a, b) => a['Nombre'].compareTo(b['Nombre']));

                      return ListView.builder(
                        itemCount: processes.length,
                        itemBuilder: (context, index) {
                          final process = processes[index];
                          final processName = process['Alias'].isEmpty
                              ? process['Nombre']
                              : process['Alias'];
                          final folderName = process['Foldername'];
                          final organizationName =
                              process['Organizacion']['Nombre'];
                          final ProcessID = process['ID'];

                          if (_isSelectedList.length <= index) {
                            _isSelectedList.add(false);
                          }

                          return GestureDetector(
                            onTap: () {
                              if (_isAnyItemSelected) {
                                setState(() {
                                  _isSelectedList[index] =
                                      !_isSelectedList[index];
                                });
                              } else {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return ProcessesViewPage(
                                      processID: ProcessID,
                                    );
                                  },
                                )).then((value) {
                                  setState(() {
                                    _isSelectedList[index] = false;
                                  });
                                });
                              }
                            },
                            onLongPress: () {
                              setState(() {
                                _isSelectedList[index] = true;
                              });
                            },
                            child: Card(
                              color: _isSelectedList[index]
                                  ? Colors.blue.withOpacity(0.5)
                                  : null,
                              elevation: 5,
                              child: ListTile(
                                title: Text(processName),
                                subtitle:
                                    Text(folderName + ' - ' + organizationName),
                                trailing: _isAnyItemSelected
                                    ? null
                                    : Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.edit),
                                            onPressed: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return ProcessesViewPage(
                                                    processID: ProcessID,
                                                  );
                                                },
                                              )).then((value) {
                                                setState(() {
                                                  _isSelectedList[index] =
                                                      false;
                                                });
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: _isAnyItemSelected &&
              Provider.of<GeneralProvider>(context, listen: false)
                      .HasRole("downloader") ==
                  true
          ? FloatingActionButton(
              onPressed: () async {
                // Get ids of selected processes separated by commas without the last comma
                String selectedProcesses = '';
                for (int i = 0; i < _isSelectedList.length; i++) {
                  if (_isSelectedList[i]) {
                    selectedProcesses += processes[i]['ID'].toString() + ',';
                  }
                }
                selectedProcesses = selectedProcesses.substring(
                    0, selectedProcesses.length - 1);
                var result =
                    await apiProvider.downloadProcessesFile(selectedProcesses);
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
              },
              child: const Icon(Icons.download),
              tooltip: "Descargar",
            )
          : null,
    );
  }
}
