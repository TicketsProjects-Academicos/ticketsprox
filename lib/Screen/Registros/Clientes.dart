
import 'package:flutter/material.dart';

class ClientesEventos extends StatefulWidget {
  const ClientesEventos({super.key});

  @override
  State<ClientesEventos> createState() => _ClientesEventosState();
}

class _ClientesEventosState extends State<ClientesEventos> {
  final _formkey = GlobalKey<FormState>();
  String userName = '';
  String userApellido = '';
  String Identificacion = '';
  String userTelefono = '';
  String userEmail = '';
  String password = '';

  final TextEditingController phoneNumberController =
      TextEditingController(text: '+1');

  void _trySubmit() {
    bool _isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_isValid) {
      _formkey.currentState!.save();
    }

    print(userName);
    print(userApellido);
    print(userTelefono);
    print(userEmail);
    print(Identificacion);
    print(password);
  }


  bool isNumeric(String? num) {
    if (num == null) {
      return false;
    }

    return double.tryParse(num) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Forms'),
      ),
      body: Center(
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          margin: const EdgeInsets.all(30),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Name
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.length > 51) {
                        return 'Please enter a valid Name';
                      }
                      return null;
                    },
                    key: const ValueKey('userName'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) {
                      userName = value as String;
                    },
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  //Apellido
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.length > 51) {
                        return 'Please enter a valid Apellido';
                      }
                      return null;
                    },
                    key: const ValueKey('userApellido'),
                    decoration: const InputDecoration(
                      labelText: 'Apellido',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) {
                      userApellido = value as String;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //Telefono
                  TextFormField(
                    controller: phoneNumberController,
                    enabled: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid Telefono';
                      }
                      final phoneNumber = value.substring(2);
                      if (phoneNumber.length != 10) {
                        return 'Please enter a 10-digit Telefono';
                      }

                      if (!isNumeric(value)) {
                        return 'Please enter a numeric Telefono';
                      }

                      return null;
                    },
                    key: const ValueKey('userTelefono'),
                    decoration: const InputDecoration(
                      labelText: 'Telefono',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) {
                      userTelefono = value as String;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //Email
                  TextFormField(
                    validator: (value) {
                      if (value == null || !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    key: const ValueKey('Email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) {
                      userEmail = value as String;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid Identificacion';
                      }

                      if (value.length != 11) {
                        return 'Please enter a 11-digit Identificacion';
                      }

                      if (!isNumeric(value)) {
                        return 'Please enter a numeric Identificacion';
                      }

                      return null;
                    },
                    key: const ValueKey('Identificacion'),
                    decoration: const InputDecoration(
                      labelText: 'Identificacion',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) {
                      Identificacion = value as String;
                    },
                  ),

                 
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: _trySubmit,
                    child: const Text('Submit Form'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
