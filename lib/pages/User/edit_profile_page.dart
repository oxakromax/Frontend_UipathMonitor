// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../Providers/GeneralProvider.dart';
import '../../classes/user_entity.dart';
import '../../main.dart';

class EditProfilePage extends StatefulWidget {
  final UserEntity profile;

  EditProfilePage({required this.profile});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  // password
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();
  bool changePassword = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.profile.nombre!;
    _lastNameController.text = widget.profile.apellido!;
    _emailController.text = widget.profile.email!;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    // Crea una solicitud PUT con los campos del formulario
    http.MultipartRequest request = http.MultipartRequest(
      'PUT',
      Uri.parse(
          '${Provider.of<GeneralProvider>(context, listen: false).url}/user/profile'),
    );

    // Agrega los campos del formulario según los valores de los controladores
    request.fields['name'] = _nameController.text;
    request.fields['lastName'] = _lastNameController.text;
    request.fields['email'] = _emailController.text;

    // Si se proporciona una nueva contraseña, actualiza el campo 'password'
    if (_passwordController.text.isNotEmpty) {
      request.fields['password'] = _passwordController.text;
    }

    // Agrega el encabezado de autorización
    request.headers['Authorization'] =
        'Bearer ${Provider.of<GeneralProvider>(context, listen: false).token}';

    // Envía la solicitud
    http.StreamedResponse response = await request.send();

    // Verifica el estado de la respuesta
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Perfil actualizado'),
        ),
      );
      widget.profile.nombre = _nameController.text;
      widget.profile.apellido = _lastNameController.text;
      widget.profile.email = _emailController.text;
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al actualizar el perfil'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar perfil'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
              validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Apellido'),
              validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
            ),
            TextFormField(
              controller: _emailController,
              decoration:
                  const InputDecoration(labelText: 'Correo electrónico'),
              validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
            ),
            ListTile(
              leading: Checkbox(
                value: changePassword,
                onChanged: (value) {
                  setState(() {
                    changePassword = value!;
                  });
                },
              ),
              title: const Text('Cambiar contraseña'),
            ),
            if (changePassword)
              TextFormField(
                controller: _passwordController,
                decoration:
                    const InputDecoration(labelText: 'Nueva contraseña'),
                obscureText: true,
                validator: (value) =>
                    value!.isEmpty && changePassword ? 'Campo requerido' : null,
              ),
            if (changePassword)
              TextFormField(
                controller: _passwordConfirmationController,
                decoration:
                    const InputDecoration(labelText: 'Confirmar contraseña'),
                obscureText: true,
                validator: (value) {
                  if (changePassword) {
                    if (value!.isEmpty) {
                      return 'Campo requerido';
                    } else if (value != _passwordController.text) {
                      return 'Las contraseñas no coinciden';
                    }
                  }
                  return null;
                },
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _updateProfile();
                  }
                },
                child: const Text('Guardar cambios'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
