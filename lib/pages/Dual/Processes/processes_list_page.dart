import 'package:UipathMonitor/Providers/ApiProvider.dart';
import 'package:UipathMonitor/pages/Dual/Processes/processes_view_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProcessesListPage extends StatefulWidget {
  const ProcessesListPage({Key? key}) : super(key: key);
  @override
  _ProcessesListPageState createState() => _ProcessesListPageState();
}

class _ProcessesListPageState extends State<ProcessesListPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Procesos'),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Ayuda'),
                    content: Text(
                      'Si tienes el rol de administrador de procesos, se desplegarán todas las organizaciones en donde el usuario esté asignado y sus procesos. En cambio, si no, solo se mostrarán los procesos que se han asignado al usuario por un administrador.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Entendido'),
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
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
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
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error al cargar los datos'));
                    } else {
                      List<dynamic> processes = snapshot.data;

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

                          return ListTile(
                            title: Text(processName),
                            subtitle:
                                Text(folderName + ' - ' + organizationName),
                            trailing: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                // Navegar a la pantalla de creación/edición de organizaciones: ProcessesViewPage
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return ProcessesViewPage(
                                      processID: ProcessID,
                                    );
                                  },
                                ));
                              },
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
    );
  }
}
