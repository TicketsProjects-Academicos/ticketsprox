import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Asientos extends StatefulWidget {
  const Asientos({Key? key}) : super(key: key);

  @override
  _AsientosState createState() => _AsientosState();
}

class _AsientosState extends State<Asientos> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  List<dynamic> eventos = [];
  List<dynamic> secciones = [];
  List<dynamic> ListSecciones = [];
  String OpcionEvent = '';
  String OpcionSeccion = '';
  int idseleccionadoevent = 0;
  int CantSeccion = 0;

  List<dynamic> SeccionBuscada = [];

  void FechOpcion(String? valor) {
    print('Valor recibido: $valor');

    setState(() {
      OpcionEvent = valor!;
      fetchDataAsiento(valor);

    });
  }

  Future<void> fetchDataAsiento(String valor) async {
    var urlSeccion =
        Uri.parse('http://www.ticketsproxapia.somee.com/api/Secciones');

    try {
      var SeccionResponse = await http.get(urlSeccion);
      if (SeccionResponse.statusCode == 200) {


        var dataseccion = jsonDecode(SeccionResponse.body);
        List<Map<String, dynamic>> filteredSeccion = [];
        ListSecciones = dataseccion;

        print('Actualizacion de evento: $valor');
        for (var seccion in dataseccion) {
          eventos.forEach((opcion) {
            if (opcion['nombreEvento'] == valor) {
              if (seccion['idEventos'] == opcion['idEventos']) {
                var filtereseccion = {
                  'idSecciones': seccion['idSecciones'],
                  'idEventos': seccion['idEventos'],
                  'nombreSeccion': seccion['nombreSeccion'],
                  'capacidad': seccion['capacidad']
                };
                filteredSeccion.add(filtereseccion);
                print('KLK FLUTTER FILTRAME LO QUE QIERO: $filteredSeccion');
              }
              return; 
            }
          });
        }

        setState(() {
          secciones = filteredSeccion;
          if (secciones.isNotEmpty) {
            OpcionSeccion = secciones[0]['nombreSeccion'];
          }
        });

        print('Secciones: $secciones');
      } else {
        print('Error: ${SeccionResponse.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchData() async {
    var urlEvento =
        Uri.parse('http://www.ticketsproxapia.somee.com/api/Eventos');

    try {
      var EventoResponse = await http.get(urlEvento);


      if (EventoResponse.statusCode == 200) {
        var dataEvento = json.decode(EventoResponse.body);
        List<Map<String, dynamic>> filteredEventos = [];

        for (var evento in dataEvento) {
          var filteredEvento = {
            'idEventos': evento['idEventos'],
            'nombreEvento': evento['nombreEvento'],
          };
          filteredEventos.add(filteredEvento);
        }
        setState(() {
          eventos = filteredEventos;
          if (eventos.isNotEmpty) {
            OpcionEvent = eventos[0]['nombreEvento'];
          }
        });
      } else {
        print('Error: ${EventoResponse.statusCode}');
      }


    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> AsientosPost(int idSecciones, String numero) async {
    var url = Uri.parse('http://www.ticketsproxapia.somee.com/api/Asientos');

    var data = {
      "id": 0,
      "idSecciones": idSecciones,
      "numero": numero,
      "reservado": false
    };

    print('Data: $data');
    var jsonData = jsonEncode(data);

    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonData,
      );

      if (response.statusCode == 200) {
        print('Evento creado con éxito');

        print('Error al crear el evento: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  List<String> generarAsientosAutomaticos(int id, int cap, seccionSe) {
    List<String> asientos = [];
    String NumA = '';

    for (int i = 1; i <= cap; i++) {
      if (seccionSe == "Vip") {
        asientos.add('V$i');
        NumA = 'V$i';
        AsientosPost(id, NumA);
      }
      if (seccionSe == "Preferencial") {
        asientos.add('P$i');
        NumA = 'P$i';
        AsientosPost(id, NumA);
      }

      if (seccionSe == "General") {
        asientos.add('GL$i');
        NumA = 'GL$i';
        AsientosPost(id, NumA);
      }

      if (seccionSe == "Grada") {
        asientos.add('G$i');
        NumA = 'G$i';
        AsientosPost(id, NumA);
      }

      if (seccionSe == "Gradas") {
        asientos.add('GA$i');
        NumA = 'GA$i';
        AsientosPost(id, NumA);
      }

      if (seccionSe == "Palcos") {
        asientos.add('PA$i');
        NumA = 'PA$i';
        AsientosPost(id, NumA);
      }
    }

    return asientos;
  }

  int idseccionselect = 0;
  int capacidadselect = 0;

  void GnerarAsiento() {

    secciones.forEach((opcion) {
      if (opcion['nombreSeccion'] == OpcionSeccion) {
        idseccionselect = opcion['idSecciones'];
        capacidadselect = opcion['capacidad'];
        print('Select $capacidadselect');
        print('Select id $idseccionselect');
        return; 
      }
    });

    List<String> asientos = generarAsientosAutomaticos(
        idseccionselect, capacidadselect, OpcionSeccion);
    print('Asientos Generados: $asientos');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Asientos Generado'),
          contentPadding: const EdgeInsets.all(20),
          content: const Text('Asientos Guardado'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  void change(String? value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asientos'),
      ),
      body: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Asientos',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          width: 400,
                          height: 50,
                          child: DropdownButtonFormField<String>(
                            value: eventos.isNotEmpty ? OpcionEvent : '',
                            items: eventos.map((opcion) {
                              return DropdownMenuItem<String>(
                                value: opcion['nombreEvento'],
                                child: Text(opcion['nombreEvento']),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                OpcionEvent = value!;
                                FechOpcion(value);
                                // fetchData();
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
                        Container(
                          width: 400,
                          height: 50,
                          child: DropdownButtonFormField<String>(
                            value: secciones.isNotEmpty ? OpcionSeccion : '',
                            items: secciones.map((opcionseccion) {
                              return DropdownMenuItem<String>(
                                value: opcionseccion['nombreSeccion'],
                                child: Text(opcionseccion['nombreSeccion']),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                OpcionSeccion = value!;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: 'Selecciona una opción',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 60,
                      child: ElevatedButton(
                        onPressed: GnerarAsiento,
                        child: const Text(
                          'Guardar',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

