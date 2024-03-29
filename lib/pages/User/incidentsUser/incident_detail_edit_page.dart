import 'dart:async';

import 'package:UipathMonitor/Constants/TicketsConst.dart';
import 'package:UipathMonitor/Providers/ApiProvider.dart';
import 'package:UipathMonitor/classes/processes_entity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../Providers/GeneralProvider.dart';

class IncidentDetailEditPage extends StatefulWidget {
  ProcessesIncidentesProceso incident;

  IncidentDetailEditPage({Key? key, required this.incident}) : super(key: key);

  @override
  _IncidentDetailEditPageState createState() => _IncidentDetailEditPageState();
}

class _IncidentDetailEditPageState extends State<IncidentDetailEditPage> {
  TextEditingController _detailsController = TextEditingController();
  String _Status = TicketsState.InProgress;
  late Connectivity _connectivity;
  Timer? _timer;
  bool _isConnected = true;

  final DateTime _startDate = DateTime.now().toUtc();
  DateTime _endDate = DateTime.now().toUtc();

  Map<String, dynamic> _TicketSettings = {};
  bool _isDiagnostic = false;
  String _type = "";

  @override
  void initState() {
    super.initState();
    _detailsController.text = "";
    _Status = TicketsState.InProgress;
    _connectivity = Connectivity();
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        _isConnected = false;
      } else {
        _isConnected = true;
      }
    });
    Provider.of<ApiProvider>(context, listen: false)
        .getTicketSettings(widget.incident.iD!)
        .then((value) => {
              setState(() {
                _TicketSettings = value;
                _isDiagnostic = _TicketSettings['needDiagnostic'];
                _type = _TicketSettings['type'];
              })
            });
    _timer = Timer.periodic(const Duration(hours: 4), (timer) {
      _endDate = DateTime.now().toUtc();
      if (_isConnected) {
        Provider.of<ApiProvider>(context, listen: false).PostIncidentDetails(
          context: context,
          incidentId: widget.incident.iD!,
          details: _detailsController.text,
          startDate: _startDate,
          endDate: _endDate,
          status: _Status,
          isDiagnostic: _isDiagnostic,
        );
      } else {
        var MapOfOptions = {
          'incidentID': widget.incident.iD,
          'details': _detailsController.text,
          'fechaInicio': DateFormat('yyyy-MM-dd HH:mm:ss').format(_startDate),
          'fechaFin': DateFormat('yyyy-MM-dd HH:mm:ss').format(_endDate),
          'estado': _Status,
          'IsDiagnostic': _isDiagnostic,
        };
        Provider.of<GeneralProvider>(context, listen: false)
            .saveLocalProgress(MapOfOptions);
      }
      // Alerta de que se acabó el tiempo y se ha guardado el progreso
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Se ha guardado el progreso, debido a que se ha desconectado de la red, se ha cerrado la sesión'),
        duration: Duration(seconds: 2),
      ));
      Provider.of<GeneralProvider>(context, listen: false).logout(context);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Ticket'),
      ),
      body: SingleChildScrollView(
        child: _buildIncidentDetailEdit(context),
      ),
    );
  }

  Stream<int> timeDifferenceStream(DateTime startDate) {
    return Stream.periodic(const Duration(seconds: 1), (count) {
      DateTime now = DateTime.now().toUtc();
      int difference = now.difference(startDate.toUtc()).inSeconds;
      return difference;
    });
  }

  Widget _buildIncidentDetailEdit(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Identificador de Ticket: ${widget.incident.iD}",
              style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 8),
          Text('Descripción: ${widget.incident.descripcion}',
              style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 8),
          Text(
              'Actividad actual: ${_isDiagnostic ? "Diagnóstico" : "Progreso"}',
              style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 8),
          Text('Tipo: $_type', style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          const Text("Tiempo transcurrido: ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          StreamBuilder<int>(
            stream: timeDifferenceStream(_startDate),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();
              int difference = snapshot.data!;
              int hours = (difference ~/ 3600);
              int minutes = ((difference % 3600) ~/ 60);
              int seconds = (difference % 60);

              String formattedHours = hours.toString().padLeft(2, '0');
              String formattedMinutes = minutes.toString().padLeft(2, '0');
              String formattedSeconds = seconds.toString().padLeft(2, '0');

              return Text(
                "$formattedHours:$formattedMinutes:$formattedSeconds",
                style: const TextStyle(fontSize: 20),
              );
            },
          ),
          const SizedBox(height: 16),
          const Text(
            'Detalles de la actividad',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _detailsController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Detalles',
            ),
            maxLines: null,
          ),
          if (!_isDiagnostic) const SizedBox(height: 20),
          if (!_isDiagnostic)
            const Text(
              'Estado del ticket',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          if (!_isDiagnostic) const SizedBox(height: 8),
          if (!_isDiagnostic)
            DropdownButton<String>(
              value: _Status,
              onChanged: (String? newValue) {
                setState(() {
                  _Status = newValue!;
                });
              },
              items: const <DropdownMenuItem<String>>[
                DropdownMenuItem<String>(
                  value: TicketsState.InProgress,
                  child: Text(TicketsState.InProgress),
                ),
                DropdownMenuItem<String>(
                  value: TicketsState.Completed,
                  child: Text(TicketsState.Completed),
                ),
              ],
            ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                final result = await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirmar cambios'),
                      content: const Text(
                          'Estos cambios son permanentes. ¿Desea continuar?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancelar'),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                        ),
                        TextButton(
                          child: const Text('Continuar'),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                        ),
                      ],
                    );
                  },
                );
                var updatedIncident;
                if (result == true) {
                  _endDate = DateTime.now().toUtc();
                  updatedIncident =
                      await Provider.of<ApiProvider>(context, listen: false)
                          .PostIncidentDetails(
                    context: context,
                    incidentId: widget.incident.iD!,
                    details: _detailsController.text,
                    startDate: _startDate,
                    endDate: _endDate,
                    status: _Status,
                    isDiagnostic: _isDiagnostic,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Se ha guardado el progreso'),
                    duration: Duration(seconds: 2),
                  ));
                }

                Navigator.pop(context, updatedIncident);
              },
              child: const Text('Guardar cambios'),
              style: ElevatedButton.styleFrom(
                // backgroundColor: Theme.of(context).primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
