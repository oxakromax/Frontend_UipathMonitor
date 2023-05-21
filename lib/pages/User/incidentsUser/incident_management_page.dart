import 'dart:convert';

import 'package:UipathMonitor/classes/processes_entity.dart';
import 'package:UipathMonitor/pages/User/incidentsUser/incident_details_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../Providers/GeneralProvider.dart';
import '../../../app_drawer.dart';
import '../../../classes/incidents_entity.dart';

class IncidentManagementPage extends StatefulWidget {
  const IncidentManagementPage({Key? key}) : super(key: key);

  @override
  _IncidentManagementPageState createState() => _IncidentManagementPageState();
}

class _IncidentManagementPageState extends State<IncidentManagementPage> {
  late Future<IncidentsEntity> futureIncidents;

  @override
  void initState() {
    super.initState();
    futureIncidents = _fetchIncidents();
  }

  void updateIncidents() {
    setState(() {
      futureIncidents = _fetchIncidents();
    });
  }

  Future<IncidentsEntity> _fetchIncidents() async {
    final response = await http.get(
      Uri.parse(
          '${Provider.of<GeneralProvider>(context, listen: false).url}/user/incidents'),
      headers: {
        'Authorization':
            'Bearer ${Provider.of<GeneralProvider>(context, listen: false).token}'
      },
    );

    if (response.statusCode == 200) {
      return IncidentsEntity.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al cargar los incidentes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: const Text('Gestión de Incidentes'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'En curso'),
              Tab(text: 'Finalizados'),
            ],
          ),
        ),
        floatingActionButton: // Refresh button
            FloatingActionButton(
          onPressed: () async {
            // Dialog to wait
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AlertDialog(
                    content: SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                });
            // Update incidents
            updateIncidents();
            futureIncidents.then((value) => {
                  // Close dialog
                  Navigator.pop(context),
                  // Show snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Incidentes actualizados'),
                    ),
                  )
                });
          },
          child: const Icon(Icons.refresh),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: FutureBuilder<IncidentsEntity>(
          future: futureIncidents,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              IncidentsEntity incidents = snapshot.data!;
              return TabBarView(
                children: [
                  _buildIncidentList(incidents.ongoing, false),
                  _buildIncidentList(incidents.finished, true),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildIncidentList(
      List<ProcessesEntity>? incidentList, bool isFinished) {
    if (incidentList == null || incidentList.isEmpty) {
      return const Center(child: Text('No hay incidentes'));
    }

    return ListView.builder(
      itemCount: incidentList.length,
      itemBuilder: (context, index) {
        // Asume que los elementos en finished y ongoing tienen propiedades comunes (nombre, descripción, etc.)
        // Reemplaza las propiedades correspondientes según tu estructura de datos
        final incident = incidentList[index];
        return ExpansionTile(
          title: Row(
            children: [
              if (isFinished)
                const Icon(Icons.check_circle, color: Colors.green)
              else
                const Icon(Icons.error, color: Colors.red),
              const SizedBox(width: 10),
              Expanded(
                  child: Text(
                // if alias is empty, use name, else use alias with name in parenthesis. dont show the parentesis if alias is empty
                '${incident.alias?.isNotEmpty == true ? incident.alias : incident.nombre}${incident.alias?.isNotEmpty == true ? ' (${incident.nombre})' : ''}',

                overflow: TextOverflow.ellipsis,
              ))
            ],
          ),
          subtitle: Row(children: [
            const Icon(Icons.business, color: Colors.grey),
            const SizedBox(width: 10),
            Expanded(
                child: Text(
              '${incident.organizacion?.nombre}/'
              '${incident.foldername}',
              style: const TextStyle(
                color: Colors.grey,
              ),
              overflow: TextOverflow.ellipsis,
            ))
          ]),
          children: [
            for (var i in incident.incidentesProceso?.reversed.toList() ?? [])
              ListTile(
                  title: Row(
                    children: [
                      const Icon(
                        Icons.tag,
                      ),
                      Expanded(
                          child: Text(
                        "${i.iD} ${i.incidente ?? ""} (${i.estado == 1 ? "Iniciado" : i.estado == 2 ? "En proceso" : i.estado == 3 ? "Finalizado" : "Error"})",
                        overflow: TextOverflow.ellipsis,
                      )),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      const Icon(
                        Icons.date_range,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                          child: Text(
                        DateTime.parse(
                                i.detalles[0]?.fechaInicio ?? i.createdAt ?? "")
                            .toLocal()
                            .toString()
                            .substring(0, 19),
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      )),
                    ],
                  ),
                  trailing: Icon(
                    isFinished ? Icons.notes : Icons.edit_note,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IncidentDetailsScreen(
                          incident: i,
                          onIncidentUpdated: updateIncidents,
                          ProcessClass: incident,
                        ),
                      ),
                    );
                  })
          ],
        );
      },
    );
  }
}
