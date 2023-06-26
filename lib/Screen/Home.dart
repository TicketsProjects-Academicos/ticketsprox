import 'package:fluent_ui/fluent_ui.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return  ScaffoldPage(
      header: const PageHeader(
        title: Text('Home Tickets Prox'),
      ),
      content: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Image.asset(
              'assets/tickets.png', 
              width: 200,
              height: 200,
            ),
           const  SizedBox(height: 20,),
           const Text(
              'Bienveido a nuestra app de tickets',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}