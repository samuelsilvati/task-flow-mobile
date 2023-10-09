import 'package:flutter/material.dart';
import 'package:task_flow/screens/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/img/background_image.png'),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter)),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Task",
                        style: TextStyle(
                            fontSize: 50,
                            color: Colors.black,
                            fontWeight: FontWeight.w600)),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Flow",
                        style: TextStyle(
                            fontSize: 50,
                            color: Colors.amber,
                            fontWeight: FontWeight.w900)),
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (bc) => const MyHomePage()));
                  },
                  child: const Text(
                    "home page",
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
