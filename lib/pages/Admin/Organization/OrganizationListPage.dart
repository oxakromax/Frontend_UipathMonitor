import 'package:UipathMonitor/app_drawer.dart';
import 'package:UipathMonitor/pages/Admin/Organization/OrganizationCreationOrEditPage.dart';
import 'package:UipathMonitor/pages/Admin/Organization/OrganizationDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/ApiProvider.dart';
import '../../../classes/organization_entity.dart';

class OrganizationListScreen extends StatefulWidget {
  @override
  _OrganizationListScreenState createState() => _OrganizationListScreenState();
}

class _OrganizationListScreenState extends State<OrganizationListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var apiProvider = Provider.of<ApiProvider>(context, listen: false);

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Gestión de organizaciones'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar organización...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {});
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Organization>>(
              future: apiProvider.getOrganizations(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  var organizations = snapshot.data!;
                  if (_searchController.text.isNotEmpty) {
                    organizations = organizations
                        .where((org) => org.nombre!
                            .toLowerCase()
                            .contains(_searchController.text.toLowerCase()))
                        .toList();
                  }

                  return ListView.builder(
                    itemCount: organizations.length,
                    itemBuilder: (context, index) {
                      final org = organizations[index];
                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.business),
                          title: Text(org.nombre!),
                          subtitle: Text(org.uipathname!),
                          onTap: () {
                            // Navegar a la pantalla de creación/edición de organizaciones
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    OrganizationDetailsPage(id: org.id!),
                              ),
                            ).then((value) => {setState(() {})});
                          },
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              await apiProvider.deleteOrganization(org.id!);
                              setState(() {});
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar a la pantalla de creación/edición de organizaciones
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrganizationCreationOrEditPage(
                isEditing: false,
                org: null,
              ),
            ),
          ).then((value) => {setState(() {})});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
