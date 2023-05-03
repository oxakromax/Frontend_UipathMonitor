import 'package:flutter/material.dart';

import '../../../classes/user_entity.dart';

class EditUserRolesDialogContent extends StatefulWidget {
  final List<UserRoles> allRoles;
  final List<UserRoles> selectedRoles;

  EditUserRolesDialogContent({required this.allRoles, required this.selectedRoles});

  @override
  _EditUserRolesDialogContentState createState() => _EditUserRolesDialogContentState();
}

class _EditUserRolesDialogContentState extends State<EditUserRolesDialogContent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.8,
      child: ListView.builder(
        itemCount: widget.allRoles.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(widget.allRoles[index].nombre!),
            subtitle: Text(widget.allRoles[index].description!),
            value: widget.selectedRoles.any((element) => element.iD == widget.allRoles[index].iD),
            onChanged: (value) {
              if (value!) {
                widget.selectedRoles.add(widget.allRoles[index]);
              } else {
                widget.selectedRoles.removeWhere((element) => element.iD == widget.allRoles[index].iD);
              }
              setState(() {});
            },
          );
        },
      ),
    );
  }
}
