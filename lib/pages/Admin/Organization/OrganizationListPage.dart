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
  @override
  Widget build(BuildContext context) {
    var apiProvider = Provider.of<ApiProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Organizations'),
      ),
      body: FutureBuilder<List<Organization>>(
        future: apiProvider.getOrganizations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final organizations = snapshot.data!;
            return ListView.builder(
              itemCount: organizations.length,
              itemBuilder: (context, index) {
                final org = organizations[index];
                return ListTile(
                  title: Text(org.nombre!),
                  subtitle: Text(org.uipathname!),
                  onTap: () {
                    // Navegar a la pantalla de creación/edición de organizaciones
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OrganizationDetailsPage(id: org.id!),
                        )).then((value) => {setState(() {})});
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await apiProvider.deleteOrganization(org.id!);
                      setState(() {});
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar a la pantalla de creación/edición de organizaciones
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    OrganizationCreationOrEditPage(isEditing: false, org: null),
              )).then((value) => {setState(() {})});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
