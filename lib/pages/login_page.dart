// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Providers/GeneralProvider.dart';
import 'ForgotPasswordPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _focusNode = FocusNode(); // Agrega un controlador de enfoque
  bool obscureText = true;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

  void _loadCredentials() {
    Future<SharedPreferences> value = SharedPreferences.getInstance();
    value.then((prefs) {
      setState(() {
        _usuarioController.text = prefs.getString('email') ?? '';
        _passwordController.text = prefs.getString('password') ?? '';
        _rememberMe =
            prefs.containsKey('email') && prefs.containsKey('password');
      });
    });
  }

  Future<void> _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
      var request = http.Request(
          'POST',
          Uri.parse(
              '${Provider.of<GeneralProvider>(context, listen: false).url}/auth'));
      request.bodyFields = {
        'email': _usuarioController.text,
        'password': _passwordController.text,
      };
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(await response.stream.bytesToString());
        var token = jsonResponse['token'];
        Provider.of<GeneralProvider>(context, listen: false).setToken(token);
        if (_rememberMe) {
          prefs.setString('email', _usuarioController.text);
          prefs.setString('password', _passwordController.text);
        } else {
          prefs.remove('email');
          prefs.remove('password');
        }
        Provider.of<GeneralProvider>(context, listen: false)
            .setUserMap(_usuarioController.text, _passwordController.text);
        Navigator.pushReplacementNamed(context, "/user/profile");
      } else {
        prefs.remove('password');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Theme(
              data: Theme.of(context).copyWith(
                // Personalizar el tema de la alerta
                dialogBackgroundColor: Colors.white,
                // color de fondo de la alerta
                textTheme: Theme.of(context).textTheme.copyWith(
                      // Estilos de texto
                      titleLarge: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      titleMedium: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      labelLarge: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                // Personalizar los botones
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    // color de fondo del botón
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ),
              child: AlertDialog(
                title: const Text('Error'),
                content: const Text('Usuario o contraseña incorrectos'),
                actions: [
                  TextButton(
                    child: const Text('Cerrar'),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      final currentRoute =
                          ModalRoute.of(context)?.settings?.name;
                      if (currentRoute != '/login') {
                        await Navigator.pushReplacementNamed(context, "/login");
                      }
                    },
                  ),
                ],
              ),
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Iniciar sesión'),
        ),
        backgroundColor: Colors.white,
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RawKeyboardListener(
              focusNode: _focusNode,
              onKey: (keyEvent) {
                if (keyEvent is RawKeyDownEvent &&
                    keyEvent.logicalKey == LogicalKeyboardKey.enter) {
                  _login(context);
                }
              },
              child: FormBuilder(
                key: _formKey,
                child: SingleChildScrollView(
                  // Agrega un SingleChildScrollView aquí
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(image: AssetImage("assets/FinisLogo.png")),
                      const SizedBox(height: 16),
                      FormBuilderTextField(
                        name: 'Email',
                        // initialValue: "admin@admin.cl",
                        controller: _usuarioController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.email(
                              errorText:
                                  'Ingrese un correo electrónico válido'),
                          FormBuilderValidators.minLength(5,
                              errorText:
                                  'Ingrese un correo electrónico válido'),
                        ]),
                      ),
                      const SizedBox(height: 16),
                      FormBuilderTextField(
                        name: 'Contraseña',
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                          ),
                        ),
                        obscureText: obscureText,
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          width: 200,
                          height: 50,
                          child: CheckboxListTile(
                            title: const Text('Recuérdame'),
                            value: _rememberMe,
                            onChanged: (bool? value) {
                              setState(() {
                                _rememberMe = value!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.trailing,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {
                          _login(context);
                        },
                        child: const Text('Iniciar sesión'),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          // Mostrar el widget de recuperación de contraseña
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ForgotPasswordPage();
                            },
                          );
                        },
                        child: const Text('¿Contraseña olvidada?'),
                      ),
                    ],
                  ),
                ),
              )),
        )));
  }
}
