import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../Providers/GeneralProvider.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _sendResetRequest() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
      var request = http.Request(
          'POST',
          Uri.parse(
              '${Provider.of<GeneralProvider>(context, listen: false).url}/forgot'));
      request.bodyFields = {
        'email': _emailController.text,
      };
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // Mostrar mensaje de éxito
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Se ha enviado un correo electrónico con instrucciones para recuperar la contraseña.'),
          ),
        );
        Navigator.of(context).pop();
      } else {
        // Mostrar mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Ha ocurrido un error al intentar enviar la solicitud de recuperación de contraseña.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200, // color de fondo del Scaffold
      appBar: AppBar(
        title: const Text('¿Contraseña olvidada?'),
        // backgroundColor: Colors.white, // color de fondo del appbar
        iconTheme: const IconThemeData(
          color: Colors.white, // color de los iconos del appbar
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Image(
                  image: AssetImage('assets/icons/forgotpassword.png'),
                  height: 200,
                  width: 200),
              const SizedBox(height: 16),
              const Text(
                '¿Olvidaste tu contraseña?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: const Text(
                  'Por favor ingresa tu Correo.\nUna nueva contraseña provisional será enviada a tu correo electronico.',
                  textAlign: TextAlign.center,
                ),
              ),
              // const SizedBox(height: 16),
              FormBuilder(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FormBuilderTextField(
                      name: 'email',
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Correo electrónico',
                        border: OutlineInputBorder(),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Ingrese su correo electrónico'),
                        FormBuilderValidators.email(
                            errorText: 'Ingrese un correo electrónico válido'),
                      ]),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _sendResetRequest,
                      icon: const Icon(Icons.send),
                      label: const Text('Enviar'),
                      style: buildButtonStyle(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ButtonStyle buildButtonStyle() {
    return ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all(Colors.blue), // color del botón
      // redondear los bordes del botón
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
