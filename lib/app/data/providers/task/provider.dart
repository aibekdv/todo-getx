import 'dart:convert';

import 'package:get/get.dart';
import 'package:tasks_app/app/core/utils/keys.dart';
import 'package:tasks_app/app/data/models/task.dart';
import 'package:tasks_app/app/data/services/storage/services.dart';

class TaskProvider {
  final _storageSevice = Get.find<StorageSevice>();

  List<Task> readTasks() {
    var tasks = <Task>[];
    jsonDecode(_storageSevice.read(taskKey).toString()).forEach(
      (e) => tasks.add(Task.fromJson(e)),
    );
    return tasks;
  }

  void writeTasks(List<Task> tasks) {
    _storageSevice.write(taskKey, jsonEncode(tasks));
  }
}
