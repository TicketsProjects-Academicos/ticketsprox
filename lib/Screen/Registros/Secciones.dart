import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class Secciones extends StatefulWidget {
  const Secciones({super.key});

  @override
  State<Secciones> createState() => _SeccionesState();
}

class _SeccionesState extends State<Secciones> {
  final _formKey = GlobalKey<FormState>();

  List<dynamic> eventos = [];

 @override
  void initState() {
    super.initState();
    fetchData();
  }

    Future<void> fetchData() async {
    var url = Uri.parse('http://www.ticketsproxapia.somee.com/api/Eventos');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List<Map<String, dynamic>> filteredEventos = [];

        for (var evento in data) {
          var filteredEvento = {
            'idEventos': evento['idEventos'],
            'nombreEvento': evento['nombreEvento'],
          };
          filteredEventos.add(filteredEvento);
        }

        setState(() {
          eventos = filteredEventos;
          if (eventos.isNotEmpty) {
            OpcionSelect = eventos[0]['nombreEvento'];
          }
        });

        print('Eventos: $eventos');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> SeccionesPost() async {
    var url = Uri.parse('http://www.ticketsproxapia.somee.com/api/Secciones');
    


    secciones.forEach((datos) async {
      var data = {
        "idSecciones": 0,
        'idEventos': datos['idEventos'],
        'nombreSeccion': datos['nombreSeccion'],
        'capacidad': datos['capacidad'],
        'precio': datos['precio']
      };
      print('Data asignado: $data');
      var jsonData = jsonEncode(data);

      try {
        var response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonData,
        );
        if (response.statusCode == 201) {
          print('Evento creado con éxito');
          _formKey.currentState!.reset();
        } else {
          print('Error al crear el evento: ${response.statusCode}');
        }
      } catch (e) {
        print('Error: $e');
      }
    });
  }

 String OpcionSelect = '';
  int selectedIdEventos = 0;

  String nombreSeccion = '';
  double precioPorTicket = 0.0;
  int cantidadPorSeccion = 0;

  void eliminarFila(int index) {
    setState(() {
      if (index >= 0 && index < secciones.length) {
        secciones.removeAt(index);
      }
    });
  }

   List<Map<String, dynamic>> secciones = [];
  int IdEvent = 0;
  void _AggsubmitD() {
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();

      eventos.forEach((opcion) {
        if (opcion['nombreEvento'] == OpcionSelect) {
          IdEvent = opcion['idEventos'];
          return;
        }
      });

      setState(() {
        secciones.add({
          'idEventos': IdEvent,
          'nombreSeccion': nombreSeccion,
          'capacidad': cantidadPorSeccion,
          'precio': precioPorTicket,
        });
      });
      print('Secciones: $secciones');
    }
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seccion Form'),
      ),
      body: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        margin: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Datos del Seccion Evento",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                      width: 400,
                      height: 50,
                      child: DropdownButtonFormField<String>(
                        value: eventos.isNotEmpty ? OpcionSelect : '',
                        items: eventos.map((opcion) {
                          return DropdownMenuItem<String>(
                            value: opcion['nombreEvento'],
                            child: Text(opcion['nombreEvento']),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            OpcionSelect = value!;
                          });
                        },
                        decoration: const InputDecoration(
                            labelText: 'Selecciona una opción',
                            border: OutlineInputBorder()),
                      ),
                    ),
                      const SizedBox(
                        width: 20,
                      ),
                    
                    
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                         Container(
                          width: 200,
                          height: 50,
                          child: TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Sección',
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa la sección';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              nombreSeccion = value!;
                            },
                          ),
                        ),

                         const SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 200,
                          height: 50,
                          child: TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Precio por ticket',
                                border: OutlineInputBorder()),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa el precio por ticket';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Por favor, ingresa un valor numérico válido';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              precioPorTicket = double.parse(value!);
                            },
                          ),
                        ),

                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 200,
                          height: 50,
                          child: TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Cantidad por sección',
                                border: OutlineInputBorder()),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa la cantidad por sección';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Por favor, ingresa un valor numérico válido';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              cantidadPorSeccion = int.parse(value!);
                            },
                          ),
                        ),

                            const SizedBox(
                          width: 20,
                        ),
                        Container(
                          height: 60,
                          child: ElevatedButton(
                            onPressed: _AggsubmitD,
                            child: const Text(
                              'Agregar',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                         const SizedBox(width: 20),
                        Container(
                          height: 60,
                          child: ElevatedButton(
                            onPressed: SeccionesPost,
                            child: const Text(
                              'Guardar',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                         width: 800,
                      height: 80,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Table(
                          border: TableBorder.all(),
                          defaultColumnWidth: const FixedColumnWidth(120.0),
                          children: [
                            const TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Seccion',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Precio',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Capacidad',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Eliminar',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                            ...secciones.asMap().entries.map((entry) {
                              final index = entry.key;
                              final seccionT = entry.value;
                              return TableRow(
                                children: [
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(seccionT['nombreSeccion']),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          Text(seccionT['precio'].toString()),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          seccionT['capacidad'].toString()),
                                    ),
                                  ),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: IconButton(
                                      onPressed: () {
                                        eliminarFila(index);
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                  ))
                                ],
                              );
                            }).toList(),
                          ],
                        ),
                      )
                       )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  
                 
                 
                 const  SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const SizedBox(
                    height: 500,
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
