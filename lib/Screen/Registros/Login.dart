import 'package:flutter/material.dart';
import 'package:ticketsprox/Screen/Navigation_Screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: LoginPage(),
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 400,
            height: 50,
            child: TextFormField(
              controller: _usernameController,
              validator: (value) {
                if (value == null) {
                  return 'Please enter a valid Username';
                }
                return null;
              },
              key: const ValueKey('Username'),
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) {},
            ),
          ),
          SizedBox(height: 16.0),
          Container(
            width: 400,
            height: 50,
            child: TextFormField(
              controller: _passwordController,
              obscureText: true,
              validator: (value) {
                if (value == null) {
                  return 'Please enter a valid Password';
                }
                return null;
              },
              key: const ValueKey('Password'),
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) {},
            ),
          ),
          SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: () {
              String username = _usernameController.text;
              String password = _passwordController.text;

              if (username == 'admin' && password == 'password') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Error de inicio de sesión'),
                    content:
                        Text('Credenciales inválidas. Intenta nuevamente.'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Aceptar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              }
            },
            child: Text('Iniciar sesión'),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('¡Inicio de sesión exitoso!'),
      ),
    );
  }
}
