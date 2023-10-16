import 'package:flutter/material.dart';
import 'package:task_flow/widgets/account_form.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text("Minha Conta",
              style: TextStyle(fontSize: 22, color: Colors.black)),
        ),
        body: const Column(
          children: [
            AccountForm(),
          ],
        ));
  }
}
