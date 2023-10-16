import 'package:flutter/material.dart';
import 'package:task_flow/screens/login_page.dart';
import 'package:task_flow/widgets/error_dialog.dart';
import 'package:task_flow/api/auth_api.dart';
import 'package:task_flow/screens/home_page.dart';

import '../repositories/store.dart';

class AccountForm extends StatefulWidget {
  const AccountForm({super.key});

  @override
  State<AccountForm> createState() => AccountFormState();
}

class AccountFormState extends State<AccountForm> {
  final authUser = AuthUser();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isObscureText = true;

  final Map<String, String> _authData = {
    'name': '',
    'password': '',
  };

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
          await authUser.signIn(_authData['name']!, _authData['password']!);

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
          const Text(
            "Edite seus dados",
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text("Meu e-mail: email@gmail.com"),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            // height: 40,
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              onSaved: (name) {
                _authData['name'] = name ?? '';
              },
              validator: (name) {
                if (name!.trim().isEmpty) {
                  return 'O nome é obrigatório';
                } else if (name.length < 3) {
                  return 'O nome precisa ter pelo menos 3 caracteres';
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
                  labelText: "Nome",
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
                  labelText: "Repetir senha",
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
                        "Salvar",
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
                onTap: () async {
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
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Essa ação não pode ser desfeita.",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              Text(
                                "Tem certeza que deseja excluir sua conta?",
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancelar')),
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
                                child: const Text('Excluir'))
                          ],
                        );
                      });
                },
                child: const Text("Apagar conta",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w900)),
              ),
              const SizedBox(
                height: 14,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
