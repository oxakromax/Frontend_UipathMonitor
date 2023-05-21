import 'package:UipathMonitor/classes/processes_entity.dart';
import 'package:UipathMonitor/pages/User/incidentsUser/incident_details_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IncidentDataSource extends DataTableSource {
  final List<ProcessesIncidentesProceso> _incidents;
  final BuildContext context;
  final ProcessesEntity process;
  final Function _func;

  IncidentDataSource(this.context, this.process, this._incidents, this._func);

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

  String _getIncidentTipoText(int tipo) {
    switch (tipo) {
      case 1:
        return 'Incidente';
      case 2:
        return 'Mejora';
      case 3:
        return 'Mantenimiento';
      case 4:
        return 'Otro';
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

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _incidents.length) return null!;
    final incident = _incidents[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('${incident.iD}')),
        DataCell(Row(
          children: [
            _buildIncidentStateIcon(incident.estado ?? 0),
            const SizedBox(width: 8),
            Text(_getIncidentStateText(incident.estado ?? 0)),
          ],
        )),
        DataCell(Text(_getIncidentTipoText(incident.tipo ?? 0))),
        DataCell(Text(_formatDate(incident.createdAt ?? ""))),
        DataCell(
          Container(
            width: 150, // set a maximum width for the cell
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                  child: Text(
                    incident.incidente ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        DataCell(Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IncidentDetailsScreen(
                    incident: incident,
                    ProcessClass: process,
                    onIncidentUpdated: () {
                      _func();
                    },
                  ),
                ),
              );
            },
            child: const Text('Ver detalles'),
          ),
        )),
      ],
    );
  }

  @override
  int get rowCount => _incidents.length; // número total de filas

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
