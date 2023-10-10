import 'package:task_flow/models/task_model.dart';
import 'package:task_flow/repositories/tasks/dio.dart';

class TasksRepository {
  final _customDio = CustomDio();

  TasksRepository();

  Future<List<TaskModel>> getTasks(bool done) async {
    try {
      var url = '/tasks';
      if (done) {
        url = '/tasks/isCheckedFalse';
      }
      var result = await _customDio.dio.get(url);

      return TaskModel.fromJsonList(result.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> create(TaskModel task) async {
    try {
      await _customDio.dio.post("/new-task", data: task.toJsonList());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> update(TaskModel task) async {
    try {
      await _customDio.dio.put("/task/${task.id}", data: task.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    try {
      await _customDio.dio.delete("/task/$id");
    } catch (e) {
      rethrow;
    }
  }
}
