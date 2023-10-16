import 'package:flutter/material.dart';
import 'package:task_flow/widgets/signup_form.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

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
          child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
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
                SizedBox(
                  height: 60,
                ),
                SignupForm(),
              ]),
        ),
      ),
    );
  }
}
