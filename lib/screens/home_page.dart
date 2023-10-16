import 'package:flutter/material.dart';
import 'package:task_flow/models/task_model.dart';
import 'package:task_flow/repositories/store.dart';
import 'package:task_flow/repositories/tasks/tasks_repository.dart';
import 'package:task_flow/widgets/custom_drawer.dart';
import 'package:task_flow/widgets/error_dialog.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var descriptionController = TextEditingController();
  var descriptionEditController = TextEditingController();
  TasksRepository tasksRepository = TasksRepository();
  var descricaoController = TextEditingController();
  var _tasks = TaskModel.fromJsonList([]);

  String userName = 'Usuário';
  var loading = true;
  var loadingEditing = false;
  bool notCompleted = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _getTasks() async {
    try {
      _tasks = await tasksRepository.getTasks(notCompleted);
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
      loadingEditing = false;
    });
  }

  void _loadData() async {
    final bool setCompleted = await Store.getBool('notCompleted');
    final String savedName = await Store.getString('name');

    setState(() {
      userName = savedName;
      notCompleted = setCompleted;
    });
    _getTasks();
  }

  Future<void> _createTask(String task) async {
    loadingEditing = true;
    try {
      await tasksRepository.create(TaskModel.create(task, false));
      if (!context.mounted) return;
      Navigator.pop(context);
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
      loadingEditing = false;
    });
    _getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Task Flow",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black)),
      ),
      drawer: CustomDrawer(userName: userName),
      body: loading
          ? const LinearProgressIndicator()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  Card(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Listar apenas não concluídas",
                            style: TextStyle(fontSize: 18),
                          ),
                          Switch(
                              value: notCompleted,
                              onChanged: (bool value) async {
                                notCompleted = value;
                                await Store.saveBool('notCompleted', value);
                                _getTasks();
                              })
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (BuildContext bc, int index) {
                        var task = _tasks[index];
                        return Dismissible(
                          onDismissed:
                              (DismissDirection dismissDirection) async {
                            loadingEditing = true;
                            await tasksRepository.delete(task.id.toString());
                            _getTasks();
                          },
                          key: Key(task.id.toString()),
                          child: Card(
                            color: task.isChecked
                                ? const Color.fromARGB(255, 234, 234, 234)
                                : const Color.fromARGB(255, 255, 243, 5),
                            child: InkWell(
                              onLongPress: () {
                                descriptionEditController.text =
                                    task.description;
                                showDialog(
                                    context: context,
                                    builder: (BuildContext bc) {
                                      return AlertDialog(
                                        title: const Text("Editar tarefa"),
                                        content: TextField(
                                          controller: descriptionEditController,
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Cancelar')),
                                          TextButton(
                                              onPressed: () async {
                                                loadingEditing = true;
                                                task.description =
                                                    descriptionEditController
                                                        .text;
                                                await tasksRepository
                                                    .update(task);
                                                if (!context.mounted) {
                                                  return;
                                                }
                                                Navigator.pop(context);
                                                _getTasks();
                                                setState(() {});
                                              },
                                              child: const Text("Salvar"))
                                        ],
                                      );
                                    });
                              },
                              child: ListTile(
                                title: Text(
                                  task.description,
                                  style: task.isChecked
                                      ? const TextStyle(
                                          color: Color.fromARGB(
                                              255, 176, 176, 176),
                                          decoration:
                                              TextDecoration.lineThrough)
                                      : const TextStyle(color: Colors.black),
                                ),
                                trailing: Checkbox(
                                  value: task.isChecked,
                                  side: BorderSide(
                                      color: Colors.grey.shade600, width: 2),
                                  activeColor: Colors.grey.shade500,
                                  onChanged: (bool? value) async {
                                    task.isChecked = value ?? false;
                                    await tasksRepository.update(task);
                                    _getTasks();
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  if (loadingEditing)
                    const Center(
                      child: LinearProgressIndicator(),
                    ),
                ],
              ),
            ),
      floatingActionButton: !loading
          ? FloatingActionButton(
              onPressed: () {
                descriptionController.text = "";
                showDialog(
                    context: context,
                    builder: (BuildContext bc) {
                      return AlertDialog(
                        title: const Text("Adicionar tarefa"),
                        content: TextField(
                          controller: descriptionController,
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancelar')),
                          TextButton(
                              onPressed: () {
                                _createTask(descriptionController.text);
                              },
                              child: const Text("Salvar"))
                        ],
                      );
                    });
              },
              tooltip: 'Add task',
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            )
          : null,
    );
  }
}
