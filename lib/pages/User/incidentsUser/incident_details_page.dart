import 'package:UipathMonitor/Constants/TicketsConst.dart';
import 'package:UipathMonitor/Providers/ApiProvider.dart';
import 'package:UipathMonitor/classes/processes_entity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/GeneralProvider.dart';
import 'incident_detail_edit_page.dart';

class IncidentDetailsScreen extends StatefulWidget {
  ProcessesIncidentesProceso incident;
  ProcessesEntity ProcessClass;
  final Function? onIncidentUpdated;

  IncidentDetailsScreen(
      {required this.incident,
      this.onIncidentUpdated,
      required this.ProcessClass});

  @override
  _IncidentDetailsScreenState createState() => _IncidentDetailsScreenState();
}

class _IncidentDetailsScreenState extends State<IncidentDetailsScreen> {
  final mapExpanded =
      <bool>[]; // Lista de booleanos para saber si un elemento está expandido

  Map<String, int> TipoIncidente = {
    TicketsType.Incident: 1,
    TicketsType.Improvement: 2,
    TicketsType.Maintenance: 3,
    TicketsType.Other: 4,
  };

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.incident.detalles!.length; i++) {
      mapExpanded.add(false);
    }
    if (mapExpanded.isNotEmpty) mapExpanded[0] = true;
    Provider.of<ApiProvider>(context, listen: false)
        .getTicketsType()
        .then((value) => {
              setState(() {
                TipoIncidente = value;
              })
            });
  }

  String _getIncidentTipoText(int tipo) {
    for (var item in TipoIncidente.entries) {
      if (item.value == tipo) {
        return item.key;
      }
    }
    return 'Desconocido';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Incidente'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return _buildIncidentDetails(context, constraints);
        },
      ),
      floatingActionButton: widget.incident.estado != "Finalizado" &&
              Provider.of<GeneralProvider>(context, listen: false)
                  .isAuthorized('/user/incidents/details')
          ? FloatingActionButton(
              onPressed: () async {
                // Navega a la pantalla de edición y espera el resultado
                final updatedIncident = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        IncidentDetailEditPage(incident: widget.incident),
                  ),
                );

                // Si el resultado no es nulo, actualiza el incidente
                if (updatedIncident != null) {
                  setState(() {
                    widget.incident = updatedIncident;
                  });

                  // Llama a la función onIncidentUpdated si está presente
                  if (widget.onIncidentUpdated != null) {
                    widget.onIncidentUpdated!();
                  }
                }
              },
              child: const Icon(Icons.edit),
            )
          : null,
    );
  }

  Widget _buildIncidentDetails(
      BuildContext context, BoxConstraints constraints) {
    // Formateador de duración amigable
    String formatDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String twoDigitHours = twoDigits(duration.inHours);
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      return "${twoDigitHours}h ${twoDigitMinutes}m";
    }

    Duration totalDuration = const Duration();
    for (var detail in widget.incident.detalles!) {
      DateTime startDate = DateTime.parse(detail.fechaInicio ?? '');
      DateTime endDate = DateTime.parse(detail.fechaFin ?? '');
      totalDuration += endDate.difference(startDate);
    }

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        Card(
          color: widget.incident.estado == TicketsState.Started
              ? Colors.red[100]
              : (widget.incident.estado == TicketsState.InProgress)
                  ? Colors.blue[100]
                  : Colors.green[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Información General',
                    style: Theme.of(context).textTheme.headline6),
              ),
              ListTile(
                title: const Text('Numero identificador'),
                subtitle: Text('${widget.incident.iD}'),
              ),
              ListTile(
                title: const Text('Descripción'),
                subtitle: Text('${widget.incident.descripcion}'),
              ),
              ListTile(
                title: const Text('Tipo'),
                subtitle: Text(_getIncidentTipoText(widget.incident.tipo ?? 0)),
              ),
              ListTile(
                title: const Text('Estado'),
                subtitle: Text(widget.incident.estado ?? "Desconocido"),
              ),
              ListTile(
                title: const Text('Tiempo Total'),
                subtitle: Text(formatDuration(totalDuration)),
              ),
            ],
          ),
        ),
        Card(
          // Contactos
          color: Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Encargado(s)',
                    style: Theme.of(context).textTheme.headline6),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.ProcessClass.usuarios!.length,
                itemBuilder: (BuildContext context, int index) {
                  var contact = widget.ProcessClass.usuarios![index];
                  return ListTile(
                    title: Text(contact.nombre ?? ''),
                    subtitle: Text(contact.email ?? ''),
                  );
                },
              ),
            ],
          ),
        ),
        Card(
          color: Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Cliente(s)', // Clientes
                    style: Theme.of(context).textTheme.headline6),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.ProcessClass.clientes!.length,
                itemBuilder: (BuildContext context, int index) {
                  var contact = widget.ProcessClass.clientes![index];
                  return ListTile(
                    title: Text("Nombre: ${contact.nombre}"),
                    subtitle: Text("Email: ${contact.email}"),
                  );
                },
              ),
            ],
          ),
        ),
        Card(
          color: Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Detalles del Incidente',
                    style: Theme.of(context).textTheme.headline6),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.incident.detalles!.length,
                itemBuilder: (BuildContext context, int index) {
                  var detail = widget.incident.detalles![index];
                  DateTime startDate = DateTime.parse(detail.fechaInicio ?? '');
                  DateTime endDate = DateTime.parse(detail.fechaFin ?? '');
                  Duration duration = endDate.difference(startDate);
                  return ExpansionTile(
                    title: Row(
                      children: [
                        const Icon(Icons.tag),
                        const SizedBox(width: 8),
                        Text(
                            '${widget.incident.detalles!.indexOf(detail) + 1} ${detail.isDiagnostic == true ? '(Diagnostico)' : widget.incident.detalles!.indexOf(detail) == 0 ? '(Inicio)' : widget.incident.detalles!.indexOf(detail) != 0 && widget.incident.detalles!.indexOf(detail) != widget.incident.detalles!.length - 1 ? '(Proceso)' : widget.incident.estado == "Finalizado" ? '(Fin)' : '(Proceso)'}'),
                        const Spacer(),
                        const Icon(Icons.timer),
                        const SizedBox(width: 4),
                        Text(formatDuration(duration)),
                      ],
                    ),
                    subtitle: Text(
                        'Fecha: ${DateTime.parse(detail.fechaInicio ?? '').toLocal().toString().substring(0, 16)}'),
                    children: <Widget>[
                      ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Descripción:',
                                style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: 8),
                            Text(
                              detail.detalle ?? '',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                        subtitle: Text(
                            'Fecha de Inicio: ${DateTime.parse(detail.fechaInicio ?? '').toLocal().toString().substring(0, 16)}\nFecha de Fin: ${DateTime.parse(detail.fechaFin ?? '').toLocal().toString().substring(0, 16)}'),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
