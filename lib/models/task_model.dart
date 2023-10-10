import 'package:intl/intl.dart';

class TaskModel {
  int id = 0;
  String name = '';
  String description = '';
  String createdAt = '';
  String updatedAt = '';
  bool isChecked = false;
  int categoryId = 0;
  String userId = '';

  TaskModel(List list, this.id, this.name, this.description, this.createdAt,
      this.updatedAt, this.isChecked, this.categoryId, this.userId);

  TaskModel.create(this.description, this.isChecked);

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isChecked = json['isChecked'];
    categoryId = json['categoryId'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['isChecked'] = isChecked;
    data['categoryId'] = categoryId;
    data['userId'] = userId;
    return data;
  }

  Map<String, dynamic> toJsonList() {
    DateTime now = DateTime.now();
    String formattedDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(now);

    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = "Nome da Tarefa"; // Adjust the api
    data['description'] = description;
    data['createdAt'] = formattedDate; // Adjust the api
    data['updatedAt'] = formattedDate; // Adjust the api
    data['isChecked'] = isChecked;
    data['categoryId'] = 1; // Adjust the api
    return data;
  }

  static List<TaskModel> fromJsonList(List<dynamic> jsonList) {
    List<TaskModel> tasks = [];
    for (var jsonTask in jsonList) {
      tasks.add(TaskModel.fromJson(jsonTask));
    }
    return tasks;
  }
}
