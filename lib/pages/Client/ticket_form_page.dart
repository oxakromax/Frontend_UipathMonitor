import 'package:UipathMonitor/Providers/ApiProvider.dart';
import 'package:UipathMonitor/pages/User/incidentsUser/incident_details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TicketFormPage extends StatefulWidget {
  const TicketFormPage({Key? key}) : super(key: key);

  @override
  _TicketFormPageState createState() => _TicketFormPageState();
}

class _TicketFormPageState extends State<TicketFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _ticketId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscador de tickets'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Ingrese su información de contacto y el ID del ticket para continuar',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su emai';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Ticket ID',
                    prefixIcon: Icon(Icons.confirmation_num),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el ID del ticket';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _ticketId = value!;
                  },
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      var apiProvider =
                          Provider.of<ApiProvider>(context, listen: false);
                      var FutureTicket =
                          apiProvider.GetClientTicket(_ticketId, _email);
                      // show Loading dialog
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Cargando'),
                          content: const LinearProgressIndicator(),
                        ),
                      );
                      FutureTicket.then((value) {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IncidentDetailsScreen(
                              incident: value.incidentesProceso![0],
                              ProcessClass: value,
                            ),
                          ),
                        );
                      }).onError((error, stackTrace) {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Error'),
                            content: const Text(
                              "No se ha encontrado el incidente, o bien no pertenece al usuario ingresado",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // Color del botón
                    onPrimary: Colors.white, // Color del texto del botón
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 2.0, // Profundidad del botón
                  ),
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
