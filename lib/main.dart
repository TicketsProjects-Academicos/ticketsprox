import 'package:fluent_ui/fluent_ui.dart';
import 'package:ticketsprox/Screen/Navigation_Screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const FluentApp(
      debugShowCheckedModeBanner: false,
      title: 'Ticket Prox',
      home: NavigateScreen(),
    );
  }
}
