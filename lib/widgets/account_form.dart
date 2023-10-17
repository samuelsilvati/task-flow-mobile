import 'package:flutter/material.dart';
import 'package:task_flow/models/account_model.dart';
import 'package:task_flow/repositories/account_repository.dart';
import 'package:task_flow/screens/login_page.dart';
import 'package:task_flow/widgets/error_dialog.dart';
import 'package:task_flow/widgets/flutter_toast.dart';

import '../repositories/store.dart';

class AccountForm extends StatefulWidget {
  const AccountForm({super.key});

  @override
  State<AccountForm> createState() => AccountFormState();
}

class AccountFormState extends State<AccountForm> {
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  AccountRepository accountRepository = AccountRepository();
  var _account = AccountModel.fromJson({});
  var loading = true;

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isObscureText = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      _account = await accountRepository.getAccount();

      nameController.text = _account.name;
    } catch (e) {
      if (!context.mounted) return;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ErrorDialog(content: "");
          });
      return;
    }
    setState(() {
      loading = false;
    });
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
      await accountRepository.update(
          AccountModel.update(nameController.text, passwordController.text));

      if (!context.mounted) return;

      var toast = FlutterToast();
      await Store.remove('jwt_token');
      await Store.remove('name');
      await Store.remove('sub');
      toast.success('Sua conta foi alterada. Faça login novamente!');

      if (!context.mounted) return;

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false);
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ErrorDialog(
                content: "Não foi possível alterar seus dados.");
          });
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _deleteAccount() async {
    setState(() {
      isLoading = true;
    });

    _formKey.currentState?.save();
    try {
      await accountRepository.delete();

      if (!context.mounted) return;

      var toast = FlutterToast();
      await Store.remove('jwt_token');
      await Store.remove('name');
      await Store.remove('sub');
      toast.success('Sua conta foi apagada permanentemente!');

      if (!context.mounted) return;

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false);
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ErrorDialog(
                content: "Não foi possível apagar sua conta! Tente novamente");
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
      child: loading
          ? const LinearProgressIndicator()
          : Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Edite seus dados",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text("Meu e-mail: ${_account.email}"),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  // height: 40,
                  child: TextFormField(
                    controller: nameController,
                    onSaved: (name) {
                      nameController.text = name!;
                    },
                    validator: (name) {
                      if (name!.trim().isEmpty) {
                        return 'O nome é obrigatório';
                      } else if (name.length < 3) {
                        return 'O nome precisa ter pelo menos 3 caracteres';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade700),
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade700),
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Nome",
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 10),
                        isDense: true),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  alignment: Alignment.centerLeft,
                  child: TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (password) =>
                        passwordController.text = password ?? '',
                    validator: (password) {
                      if (password!.isEmpty || password.length < 4) {
                        return 'A senha deve ter pelo menos 4 caracteres';
                      }
                      return null;
                    },
                    obscureText: isObscureText,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade700),
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade700),
                            // borderSide: BorderSide(color: Colors.grey.shade600),
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Senha",
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        isDense: true,
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              isObscureText = !isObscureText;
                            });
                          },
                          child: Icon(
                            isObscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                        )),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  alignment: Alignment.centerLeft,
                  child: TextFormField(
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (password) =>
                        passwordController.text = password ?? '',
                    validator: (password) {
                      if (password!.isEmpty || password.length < 4) {
                        return 'A senha deve ter pelo menos 4 caracteres';
                      } else if (password != passwordController.text) {
                        return 'As senhas devem iguais';
                      }
                      return null;
                    },
                    obscureText: isObscureText,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade700),
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade700),
                            // borderSide: BorderSide(color: Colors.grey.shade600),
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Repetir senha",
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        isDense: true,
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              isObscureText = !isObscureText;
                            });
                          },
                          child: Icon(
                            isObscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
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
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.amber)),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Salvar",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
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
                                      onPressed: () {
                                        _deleteAccount();
                                      },
                                      child: const Text('Excluir'))
                                ],
                              );
                            });
                      },
                      child: const Text("Apagar conta",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w900)),
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
