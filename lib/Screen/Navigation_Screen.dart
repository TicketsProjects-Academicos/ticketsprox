import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:ticketsprox/Screen/Home.dart';
import 'package:ticketsprox/Screen/Registros/Eventos.dart';
import 'package:ticketsprox/Screen/Consultas/Eventos_C.dart';
import 'package:ticketsprox/Screen/Registros/Asientos.dart';
import 'package:ticketsprox/Screen/Registros/Secciones.dart';

class NavigateScreen extends StatefulWidget {
  const NavigateScreen({super.key});

  @override
  State<NavigateScreen> createState() => _NavigateScreenState();
}

class _NavigateScreenState extends State<NavigateScreen> {
  int _currentidex = 0;
  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: const NavigationAppBar(
          leading: Center(
        child: FlutterLogo(
          size: 25,
        ),
      )),
      pane: NavigationPane(
        header: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: DefaultTextStyle(
            style: FluentTheme.of(context).typography.title!,
            child: const Text('Tickets Prox'),
          ),
        ),
        items: [
          PaneItem(
              icon: const Icon(Icons.home),
              title: const Text('Home'),
              body: const Center(
                child: Home(),
              )),
          PaneItem(
              icon: const Icon(FluentIcons.text_box),
              title: const Text('Eventos'),
              body: const Center(
                child: Eventos(),
              )),
          PaneItem(
              icon: const Icon(FluentIcons.text_box),
              title: const Text('Secciones'),
              body: const Center(
                child: Secciones(),
              )),
               PaneItem(
              icon: const Icon(FluentIcons.text_box),
              title: const Text('Asientos'),
              body: const Center(
                child: Asientos(),
              )),
        ],
        selected: _currentidex,
        displayMode: PaneDisplayMode.auto,
        onChanged: (i) {
          setState(() {
            _currentidex = i;
          });
        },
      ),
    );
  }
}
