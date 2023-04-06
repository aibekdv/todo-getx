import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_app/app/data/models/task.dart';
import 'package:tasks_app/app/data/services/storage/repository.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});

  final formKey = GlobalKey<FormState>();
  final editCtrl = TextEditingController();
  final cheapIdx = 0.obs;
  final deleting = false.obs;
  final tasks = <Task>[].obs;
  final task = Rx<Task?>(null);

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeCheapIdx(int value) {
    cheapIdx.value = value;
  }

  void changeDeleteing(bool val) {
    deleting.value = val;
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  void changeTask(Task? select) {
    task.value = select;
  }

  updateTask(Task task, String title) {
    var todos = task.todos ?? [];
    if (conainteTodo(todos, title)) return false;
    var todo = {'title': title, 'done': false};
    todos.add(todo);
    var newTask = task.copyWith(todos: todos);
    int oldIdx = tasks.indexOf(task);
    tasks[oldIdx] = newTask;
    tasks.refresh();
    return true;
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  bool conainteTodo(List todos, title) {
    return todos.any((element) => element['title'] == title);
  }
}
