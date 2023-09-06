import 'dart:convert';

import 'package:UipathMonitor/Constants/ApiEndpoints.dart';
import 'package:UipathMonitor/Constants/TicketsConst.dart';
import 'package:UipathMonitor/classes/processes_entity.dart';
import 'package:UipathMonitor/pages/User/incidentsUser/incident_details_page.dart';
import 'package:flutter/material.dart';
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
  late Future<IncidentsEntity> futureTickets;

  @override
  void initState() {
    super.initState();
    futureTickets = _fetchTickets();
  }

  void updateIncidents() {
    setState(() {
      futureTickets = _fetchTickets();
    });
  }

  Future<IncidentsEntity> _fetchTickets() async {
    var request = ApiEndpoints.getHttpRequest(
      ApiEndpoints.GetUserTickets,
      headers: {
        'Authorization':
            'Bearer ${Provider.of<GeneralProvider>(context, listen: false).token}'
      },
    );

    final response = await request.send();

    if (response.statusCode == 200) {
      var body = await response.stream.bytesToString();
      return IncidentsEntity.fromJson(jsonDecode(body));
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
          title: const Text('Gestión de tickets'),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Pendientes"),
              Tab(text: TicketsState.Completed),
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
            futureTickets.then((value) => {
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
          future: futureTickets,
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
            for (var i in incident.incidentesProceso?.toList() ?? [])
              ListTile(
                  title: Row(
                    children: [
                      const Icon(
                        Icons.tag,
                      ),
                      Expanded(
                          child: Text(
                        "${i.iD} ${i.descripcion ?? ""} (${i.estado})",
                        overflow: TextOverflow.ellipsis,
                      )),
                      // Priority Icon
                      if (i.prioridad != null &&
                          i.estado != TicketsState.Completed)
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: // Priority is from 1 to 10, 10 highest priority
                                i.prioridad! <= 3
                                    ? Colors.green
                                    : i.prioridad! <= 6
                                        ? Colors.orange
                                        : Colors.red,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.priority_high_rounded,
                                color: Colors.white,
                              ),
                              Text(
                                i.prioridad.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 5)
                            ],
                          ),
                        ),
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
