import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:UipathMonitor/models/organization.dart';

import '../../../Providers/ApiProvider.dart';

class OrganizationCreationOrEditPage extends StatefulWidget {
  bool isEditing = false;
  Map<String, dynamic>? org = {};

  OrganizationCreationOrEditPage(
      {super.key, required this.isEditing, required this.org});

  @override
  State<OrganizationCreationOrEditPage> createState() =>
      _OrganizationCreationOrEditPageState();
}

class _OrganizationCreationOrEditPageState
    extends State<OrganizationCreationOrEditPage> {
  var _checkboxOrgEdit = false;

  // Organization Controllers
  final _organizationNameController = TextEditingController();
  final _organizationUipathNameController = TextEditingController();
  final _organizationTenantNameController = TextEditingController();
  final _organizationAppIdController = TextEditingController();
  final _organizationAppSecretController = TextEditingController();
  final _organizationAppScopeController = TextEditingController();
  final _organizationAppUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEditing) {
      SetDefaultFieldsEditing();
    } else {
      _checkboxOrgEdit = true;
    }
  }

  void SetDefaultFieldsEditing() {
    _organizationNameController.clear();
    _organizationUipathNameController.clear();
    _organizationTenantNameController.clear();
    _organizationAppIdController.clear();
    _organizationAppSecretController.clear();
    _organizationAppScopeController.clear();
    _organizationAppUrlController.clear();
    _organizationNameController.text = widget.org?['Nombre'];
    _organizationUipathNameController.text = widget.org?['Uipathname'];
    _organizationTenantNameController.text = widget.org?['Tenantname'];
    _organizationAppScopeController.text = widget.org?['AppScope'];
    _organizationAppUrlController.text = widget.org?['BaseURL'];
  }

  @override
  Widget build(BuildContext context) {
    var apiProvider = Provider.of<ApiProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Organization${widget.isEditing ? ' Edit' : ' Creation'}'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Organization Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      TextField(
                        controller: _organizationNameController,
                      ),
                      if (widget.isEditing)
                        Row(
                          children: [
                            Checkbox(
                              value: _checkboxOrgEdit,
                              onChanged: (value) {
                                SetDefaultFieldsEditing();
                                setState(() {
                                  _checkboxOrgEdit = value!;
                                });
                              },
                            ),
                            const Text('Editar campos de API Uipath'),
                          ],
                        ),
                      if (_checkboxOrgEdit) _buildUipathFields(),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          Organization newOrg;
                          Organization organization = Organization(
                              id: widget.isEditing ? widget.org!['ID'] : null,
                              nombre: _organizationNameController.text,
                              uipathname:
                                  _organizationUipathNameController.text,
                              tenantname:
                                  _organizationTenantNameController.text,
                              appID: _organizationAppIdController.text != ""
                                  ? _organizationAppIdController.text
                                  : null,
                              appSecret:
                                  _organizationAppSecretController.text != ""
                                      ? _organizationAppSecretController.text
                                      : null,
                              appScope: _organizationAppScopeController.text,
                              baseURL: _organizationAppUrlController.text);
                          try {
                            if (widget.isEditing) {
                              newOrg = await apiProvider
                                  .updateOrganization(organization);
                            } else {
                              newOrg = await apiProvider
                                  .createOrganization(organization);
                            }
                            if (!context.mounted) return;
                            if (newOrg.nombre != null) {
                              Navigator.pop(context, true);
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Error'),
                                    content: Text(widget.isEditing
                                        ? 'Error al editar la organización'
                                        : 'Error al crear la organización' +
                                            " Por favor verifique los datos ingresados"),
                                    actions: [
                                      TextButton(
                                        child: const Text('Cerrar'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          } catch (e) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Row(
                                    children: const [
                                      Icon(Icons.error),
                                      SizedBox(width: 8),
                                      Text('Error'),
                                    ],
                                  ),
                                  content: Text(
                                      overflow: TextOverflow.ellipsis,
                                      'Error al realizar la operación:\n$e'),
                                  actions: [
                                    TextButton(
                                      child: const Text('Cerrar'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUipathFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text(
          'Organization Uipath Name',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        TextField(
          controller: _organizationUipathNameController,
        ),
        const SizedBox(height: 16),
        const Text(
          'Organization Tenant Name',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        TextField(
          controller: _organizationTenantNameController,
        ),
        const SizedBox(height: 16),
        const Text(
          'Organization App ID',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        TextField(
          controller: _organizationAppIdController,
        ),
        const SizedBox(height: 16),
        const Text(
          'Organization App Secret',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        TextField(
          controller: _organizationAppSecretController,
        ),
        const SizedBox(height: 16),
        const Text(
          'Organization App Scope',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        TextField(
          controller: _organizationAppScopeController,
        ),
        const SizedBox(height: 16),
        const Text(
          'Organization App URL',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        TextField(
          controller: _organizationAppUrlController,
        ),
      ],
    );
  }
}
