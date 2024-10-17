import 'package:crm_app/contacts_table_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // Importar Google Fonts

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login CRM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const platform = MethodChannel('com.example.crm_app');

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _accessKeyController = TextEditingController();

  String _sessionName = '';
  String _token = '';
  String _loginError = ''; // Variable para almacenar el mensaje de error


  // Obtener el token desde el servidor
  Future<void> _getChallenge(String username) async {
    try {
      final String token = await platform.invokeMethod('getChallenge', {"username": username});
      setState(() {
        _token = token;
      });
      // ignore: avoid_print
      print('Received token: $token');
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to get challenge: ${e.message}');
    }
  }

  Future<void> _loginAndGetContacts(String username, String accessKey) async {
    try {
      final String sessionName = await platform.invokeMethod('login', {
        "username": username,
        "accessKey": accessKey,
      });

      setState(() {
        _sessionName = sessionName;
        _loginError = ''; // Limpia el mensaje de error en caso de éxito
      });

      final List<dynamic> contacts = await platform.invokeMethod('getContacts', {
        "sessionName": _sessionName,
      });

      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => ContactsTableScreen(contacts: contacts),
        ),
      );
    } on PlatformException catch (e) {
      setState(() {
        _loginError = 'Fallo el inicio de sesión: ${e.message}'; // Actualiza el mensaje de error
      });
    }
  }

  // Copiar el token al portapapeles
  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _token));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Token copiado al portapapeles')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 241, 241),  
      appBar: AppBar(       
        centerTitle: true, // Centrar el título
        backgroundColor: const Color.fromARGB(255, 246, 241, 241), 
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Texto de Login
              Text(
                'Login CRM',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 10), // Menos espacio debajo del título

              // Campo para ingresar el username
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Usuario',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0), // Bordes redondeados
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Campo para ingresar la accessKey
              TextField(
                controller: _accessKeyController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0), // Bordes redondeados
                  ),
                ),
                obscureText: false,
              ),
              const SizedBox(height: 20),

              // Botones uno al lado del otro
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent, // Color de fondo del botón
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // Bordes redondeados
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      elevation: 8
                    ),
                    onPressed: () {
                      String username = _usernameController.text;
                      _getChallenge(username);
                    },
                    child: Text('Obtener Token',
                     style: GoogleFonts.poppins(
                      color: Colors.white
                     ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Color de fondo del botón
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // Bordes redondeados
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      elevation: 8
                    ),
                    onPressed: () {
                      String username = _usernameController.text;
                      String accessKey = _accessKeyController.text;
                      _loginAndGetContacts(username, accessKey);
                    },
                    child: Text('Login', style: GoogleFonts.poppins(
                      color: Colors.black
                    )),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Mostrar el mensaje de error si existe
              _loginError.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _loginError,
                        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    )
                  : Container(),

              // Texto de Token con icono de copiar
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Token: $_token',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: _token.isNotEmpty ? _copyToClipboard : null,
                    tooltip: 'Copiar token',
                  ),
                ],
              ),

              // Texto de Session Name
              Text(
                'Session Name: $_sessionName',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
