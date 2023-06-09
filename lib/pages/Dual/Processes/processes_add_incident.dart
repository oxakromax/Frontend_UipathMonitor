import 'package:UipathMonitor/Providers/ApiProvider.dart';
import 'package:UipathMonitor/classes/processes_entity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class ProcessesAddIncident extends StatefulWidget {
  final ProcessesEntity process;
  const ProcessesAddIncident({Key? key, required this.process})
      : super(key: key);

  @override
  State<ProcessesAddIncident> createState() => _ProcessesAddIncidentState();
}

class _ProcessesAddIncidentState extends State<ProcessesAddIncident> {
  var processName = '';
  var processAlias = '';
  var processId = 0;
  var typeofIncident = {
    "Incidente": 1,
    "Mejora": 2,
    "Mantenimiento": 3,
    "Otro": 4,
  };
  late ApiProvider apiProvider;
  String incidentDescription = '';
  String selectedTypeOfIncident = '';

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    processName = widget.process.nombre ?? '';
    processAlias = widget.process.alias ?? '';
    processId = widget.process.iD ?? 0;
    apiProvider = Provider.of<ApiProvider>(context, listen: false);
    selectedTypeOfIncident = typeofIncident.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Incident'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Type of Incident',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedTypeOfIncident,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedTypeOfIncident = newValue!;
                  });
                },
                items: typeofIncident.keys
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a type of incident';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text(
                'Description',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Enter a description',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onChanged: (value) {
                  incidentDescription = value;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ProcessesIncidentesProceso NewIncident =
                        ProcessesIncidentesProceso();
                    NewIncident.iD = 0;
                    NewIncident.procesoID = processId;
                    NewIncident.tipo = typeofIncident[selectedTypeOfIncident];
                    NewIncident.incidente = incidentDescription;
                    // Little dialog to wait
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Center(child: CircularProgressIndicator());
                        });
                    Future<Response> response =
                        apiProvider.addNewIncident(NewIncident);
                    response.then((value) {
                      Navigator.pop(context);
                      // Check the response, if it's ok, go back to the previous page, if not show an error with the body in a dialog
                      if (value.statusCode == 200) {
                        Navigator.pop(context);
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Error'),
                                content: Text(value.body),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Ok'),
                                  ),
                                ],
                              );
                            });
                      }
                    });
                  }
                },
                child: Text('Add Incident'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
