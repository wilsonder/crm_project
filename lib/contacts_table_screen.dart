import 'package:flutter/material.dart';
import 'package:crm_app/main.dart'; // Importa la pantalla de login (LoginScreen)

class ContactsTableScreen extends StatelessWidget {
  final List<dynamic> contacts;

  const ContactsTableScreen({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de contactos'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0), // Espacio al lado derecho
            child: IconButton(
              icon: const Icon(Icons.logout), // Icono de cerrar sesión
              onPressed: () {
                // Redirige al usuario al LoginScreen
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> route) => false, // Esto elimina la pila de navegación
                );
              },
              tooltip: 'Cerrar sesión',
            ),
          ),
        ],
      ),
      body: Center( // Para centrar la tabla en la pantalla
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: contacts.isNotEmpty
              ? AnimatedOpacity(
                  opacity: 1.0,
                  duration: const Duration(seconds: 1),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white, 
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), 
                          blurRadius: 8,
                          offset: const Offset(0, 4), 
                        ),
                      ],
                    ),
                    child: SingleChildScrollView( 
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        headingRowColor: WidgetStateColor.resolveWith(
                          (states) => Colors.blueGrey, 
                        ),
                        dataRowColor: WidgetStateColor.resolveWith(
                          (states) => Colors.grey[50]!, 
                        ),
                        columnSpacing: 20,
                        columns: const [
                          DataColumn(
                            label: Text(
                              'ID',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Nombre',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Correo Electronico',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                        rows: contacts
                            .asMap()
                            .map((index, contact) => MapEntry(
                                  index,
                                  DataRow(
                                    color: WidgetStateProperty.resolveWith<Color>(
                                        (Set<WidgetState> states) {
                                      if (states.contains(WidgetState.selected)) {
                                        return const Color.fromARGB(255, 181, 214, 17);
                                      }
                                      if (index % 2 == 0) {
                                        return Colors.grey[200]!;
                                      }
                                      return Colors.white;
                                    }),
                                    cells: [
                                      DataCell(Text(contact['contact_no'] ?? '')),
                                      DataCell(Text('${contact['firstname'] ?? ''} ${contact['lastname'] ?? ''}')),
                                      DataCell(Text(contact['email'] ?? ''))
                                    ],
                                    selected: false,
                                  ),
                                ))
                            .values
                            .toList(),
                      ),
                    ),
                  ),
                )
              : const Center(child: Text('No contacts available')),
        ),
      ),
    );
  }
}
