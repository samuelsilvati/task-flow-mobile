import 'package:flutter/material.dart';
import 'package:task_flow/screens/signup_page.dart';
import 'package:task_flow/widgets/error_dialog.dart';
import 'package:task_flow/api/auth_api.dart';
import 'package:task_flow/screens/home_page.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => AuthFormState();
}

class AuthFormState extends State<AuthForm> {
  final authUser = AuthUser();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isObscureText = true;

  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    return emailRegex.hasMatch(email);
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    _formKey.currentState?.save();
    try {
      final response =
          await authUser.signIn(_authData['email']!, _authData['password']!);

      if (!context.mounted) return;

      if (response == 200) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MyHomePage()));
      } else {
        setState(() {
          isLoading = false;
        });
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const ErrorDialog(content: "E-mail ou senha incorretos!");
            });
        return;
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ErrorDialog(content: "E-mail ou senha incorretos!");
          });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            // height: 40,
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              onSaved: (email) {
                _authData['email'] = email ?? '';
              },
              validator: (email) {
                if (email!.trim().isEmpty) {
                  return 'E-mail obrigatório';
                } else if (isValidEmail(email) == false) {
                  return 'Email inválido';
                }
                return null;
              },
              style: TextStyle(color: Colors.grey.shade700),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade700),
                      borderRadius: BorderRadius.circular(10)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade700),
                      borderRadius: BorderRadius.circular(10)),
                  labelText: "E-mail",
                  labelStyle:
                      TextStyle(color: Colors.grey.shade600, fontSize: 16),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                  isDense: true),
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            alignment: Alignment.centerLeft,
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              onSaved: (password) => _authData['password'] = password ?? '',
              validator: (password) {
                if (password!.isEmpty || password.length < 4) {
                  return 'A senha deve ter pelo menos 4 caracteres';
                }
                return null;
              },
              obscureText: isObscureText,
              style: TextStyle(color: Colors.grey.shade700),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade700),
                      borderRadius: BorderRadius.circular(10)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade700),
                      // borderSide: BorderSide(color: Colors.grey.shade600),
                      borderRadius: BorderRadius.circular(10)),
                  labelText: "Senha",
                  labelStyle:
                      TextStyle(color: Colors.grey.shade600, fontSize: 16),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  isDense: true,
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        isObscureText = !isObscureText;
                      });
                    },
                    child: Icon(
                      isObscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                  )),
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          if (isLoading)
            const CircularProgressIndicator()
          else
            Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                alignment: Alignment.center,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.amber)),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                )),
          const SizedBox(
            height: 30,
          ),
          Column(
            children: [
              InkWell(
                onTap: () async {},
                child: const Text("Esqueci minha senha",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w900)),
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Ainda não tem conta?",
                      style: TextStyle(fontSize: 14, color: Colors.black)),
                  const SizedBox(
                    width: 2,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupPage()));
                    },
                    child: const Text("Cadastre-se",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w900)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
