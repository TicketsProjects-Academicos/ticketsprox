import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class Eventos extends StatefulWidget {
  const Eventos({super.key});

  @override
  State<Eventos> createState() => _EventosState();
}

class _EventosState extends State<Eventos> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController datacontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    datacontroller.text = "";
  }

  DateTime Fechas = DateTime.now();
  DateTime fechaEvento = DateTime.now();
  Future<void> enviarEvento() async {
    var url = Uri.parse('http://www.ticketsproxapia.somee.com/api/Eventos');

    String fechaFormateada =
        DateFormat('yyyy-MM-dd').format(fechaEvento);

    print("Fechas tomada de Input: ${datacontroller.text}");

    var data = {
      "id": 0,
      "nombreEvento": nombreEvento,
      "descripcion": Descripcion,
      "image": Image,
      "lugarEvento": LugarEvento,
      "tipoEvento": OpcionSelect,
      "capacidadTotal": Capacidad,
      "fechaEvento": datacontroller.text,
      "hora": Hora,
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

      if (response.statusCode == 201) {
        print('Evento creado con éxito');

       
      }else {
         print('Error al crear el evento: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  String nombreEvento = '';
  String LugarEvento = '';
  List<String> TipoEvento = [
    'Selecciona una opción',
    'Artes y Teatro',
    'Concierto',
    'Conferencia',
    'Educativo'
  ];

  String OpcionSelect = 'Selecciona una opción';

  int Capacidad = 0;
  String fecha = '';
  String Hora = '';
  String seccion = '';
  double precioPorTicket = 0.0;
  int cantidadPorSeccion = 0;
  String Image = '';
  String Descripcion = '';

  void SaveEvento() {
    bool _isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_isValid) {
      _formkey.currentState!.save();

      enviarEvento();
      _formkey.currentState!.reset();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Evento'),
            contentPadding: const EdgeInsets.all(20),
            content: const Text('Evento Guardado'),
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
        title: const Text('Event Form'),
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
              key: _formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Datos del evento",
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
                        child: TextFormField(
                          validator: (value) {
                            if (value == null) {
                              return 'Please enter a valid Nombre de Evento';
                            }
                            return null;
                          },
                          key: const ValueKey('nombreEvento'),
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            labelText: 'Nombre Evento',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (value) {
                            nombreEvento = value as String;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 400,
                        height: 50,
                        child: TextFormField(
                          key: const ValueKey('LugarEvento'),
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            labelText: 'Lugar Evento',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (value) {
                            LugarEvento = value as String;
                          },
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
                        width: 600,
                        height: 50,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null) {
                              return 'Please enter a valid Image';
                            }
                            return null;
                          },
                          key: const ValueKey('Image'),
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            labelText: 'Image',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (value) {
                            Image = value as String;
                          },
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
                        width: 600,
                        height: 50,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null) {
                              return 'Please enter a valid Descripcion';
                            }
                            return null;
                          },
                          key: const ValueKey('Descripcion'),
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            labelText: 'Descripcion',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (value) {
                            Descripcion = value as String;
                          },
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
                        width: 400,
                        height: 50,
                        child: DropdownButtonFormField<String>(
                          value: OpcionSelect,
                          items: TipoEvento.map((String opcion) {
                            return DropdownMenuItem<String>(
                              value: opcion,
                              child: Text(opcion),
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
                      Container(
                        width: 400,
                        height: 50,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid Capacidad';
                            }
                            return null;
                          },
                          key: const ValueKey('Capacidad'),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              labelText: 'Capacidad',
                              border: OutlineInputBorder()),
                          onSaved: (newValue) {
                            Capacidad = int.parse(newValue!);
                          },
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
                          width: 400,
                          height: 50,
                          child: TextFormField(
                            controller: datacontroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid Fecha';
                              }
                              return null;
                            },
                            key: const ValueKey('Fecha'),
                            keyboardType: TextInputType.datetime,
                            decoration: const InputDecoration(
                              labelText: 'Fecha',
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );
                              if (pickedDate != null) {
                                print(pickedDate);
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(formattedDate);

                                setState(() {
                                  datacontroller.text = formattedDate;
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                            onSaved: (newValue) {
                              fecha = newValue as String;
                            },
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 400,
                        height: 50,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null) {
                              return 'Please enter a valid Hora';
                            }

                            return null;
                          },
                          key: const ValueKey('Hora'),
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              labelText: 'Hora', border: OutlineInputBorder()),
                          onSaved: (newValue) {
                            Hora = newValue as String;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: SaveEvento,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Submit Evento',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
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
