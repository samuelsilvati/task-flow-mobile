import 'package:flutter/material.dart';

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
                        child: const Column(
                          children: [
                            Text(
                              'Termos de Uso e Privacidade',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                                "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."),
                          ],
                        ),
                      );
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
                        actionsAlignment: MainAxisAlignment.center,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        title: const Icon(
                          Icons.warning,
                          size: 32,
                          color: Colors.redAccent,
                        ),
                        content: const Wrap(
                          children: [
                            Text("Deseja realmente sair do aplicativo?"),
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Não')),
                          TextButton(
                              onPressed: () async {}, child: const Text('Sim'))
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
