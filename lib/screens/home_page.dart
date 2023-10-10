import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_flow/widgets/custom_drawer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String userName = 'Usuário';

  @override
  void initState() {
    super.initState();
    loadUserName();
  }

  void loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedName = prefs.getString('name');

    if (savedName != null) {
      setState(() {
        userName = savedName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Task Flow",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
      ),
      drawer: CustomDrawer(userName: userName),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              userName,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
