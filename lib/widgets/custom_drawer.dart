import 'package:flutter/material.dart';
import 'package:task_flow/repositories/store.dart';
import 'package:task_flow/screens/login_page.dart';
import 'package:task_flow/widgets/privacity_policy.dart';

class CustomDrawer extends StatelessWidget {
  final String userName;
  const CustomDrawer({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white70,
                    child: Icon(
                      Icons.person_outline,
                      size: 50,
                      color: Colors.amber.shade200,
                    )),
                accountName: Text(
                  userName,
                  style: const TextStyle(color: Colors.black),
                ),
                accountEmail: const Text(
                  'email@email.com',
                  style: TextStyle(color: Colors.black),
                )),
            InkWell(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  width: double.infinity,
                  child: const Row(
                    children: [
                      Icon(Icons.settings_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Perfil"),
                    ],
                  )),
              onTap: () async {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            InkWell(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  width: double.infinity,
                  child: const Row(
                    children: [
                      Icon(Icons.info_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Termos de uso e privacidade"),
                    ],
                  )),
              onTap: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    context: context,
                    builder: (BuildContext bc) {
                      return Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 18),
                          child: const PrivacyPolicy());
                    });
              },
            ),
            const Divider(),
            InkWell(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  width: double.infinity,
                  child: const Row(
                    children: [
                      Icon(Icons.logout_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Sair"),
                    ],
                  )),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext bc) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        title: const Icon(
                          Icons.warning,
                          size: 36,
                          color: Colors.redAccent,
                        ),
                        content: const Wrap(
                          children: [
                            Center(
                                child: Text(
                                    "Deseja realmente sair do aplicativo?")),
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Não')),
                          TextButton(
                              onPressed: () async {
                                await Store.remove('jwt_token');
                                await Store.remove('name');
                                await Store.remove('sub');

                                if (!context.mounted) return;

                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()),
                                    (route) => false);
                              },
                              child: const Text('Sim'))
                        ],
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
