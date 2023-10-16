import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:task_flow/screens/login_page.dart';
import 'package:task_flow/widgets/error_dialog.dart';
import 'package:task_flow/api/auth_api.dart';
import 'package:task_flow/widgets/flutter_toast.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => ForgotPasswordFormState();
}

class ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final authUser = AuthUser();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  String userMail = '';

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
      final response = await authUser.forgotPassword(userMail);

      if (!context.mounted) return;

      if (response == 200) {
        var toast = FlutterToast();
        toast.success(
            'Instruções enviadas! Verifique seu e-mail para obter instruções de redefinição da sua senha');
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
                  content: "Não foi possível enviar o e-mail!");
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
                        "O email utilizado não está cadastrado no sistema.");
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
            margin: const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
            child: const Text(
              "Digite o e-mail associado à sua conta abaixo e enviaremos instruções de redefinição de senha.",
              style: TextStyle(color: Colors.black),
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            // height: 40,
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              onSaved: (email) {
                userMail = email ?? '';
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
                        "Enviar",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                )),
          const SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            child: const Text("Voltar para a tela de login",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w900)),
          ),
        ],
      ),
    );
  }
}
