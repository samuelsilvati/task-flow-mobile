import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:task_flow/screens/login_page.dart';
import 'package:task_flow/widgets/error_dialog.dart';
import 'package:task_flow/api/auth_api.dart';
import 'package:task_flow/widgets/flutter_toast.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => SignupFormState();
}

class SignupFormState extends State<SignupForm> {
  final authUser = AuthUser();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isObscureText = true;

  final Map<String, String> _authData = {
    'name': '',
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
      final response = await authUser.signUp(
          _authData['name']!, _authData['email']!, _authData['password']!);

      if (!context.mounted) return;

      if (response == 201) {
        var toast = FlutterToast();
        toast.success('Conta criada! Faça login para continuar.');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      } else {
        setState(() {
          isLoading = false;
        });
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const ErrorDialog(
                  content: "Não foi possível criar sua conta!");
            });
        return;
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 409) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const ErrorDialog(
                    content:
                        "O email utilizado já está cadastrado no sistema.");
              });
        }
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const ErrorDialog(
                  content: "Não foi possível criar sua conta!");
            });
      }
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
                        "Criar conta",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                )),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Já tem conta?",
                  style: TextStyle(fontSize: 14, color: Colors.black)),
              const SizedBox(
                width: 2,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                child: const Text("Faça o login",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w900)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
