import 'package:get/get.dart';

import '../helper/db_helper.dart';
import '../model/task_model.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  void loadTasks() async {
    List<Task> taskList = await _dbHelper.getTasks();
    tasks.assignAll(
        taskList); // The tasks are already sorted in descending order
  }

  void addTask(String title) async {
    Task newTask = Task(title: title);
    await _dbHelper.insertTask(newTask);
    loadTasks(); // Reload after adding new task
  }

  void updateTask(int id, String newTitle) async {
    Task updatedTask = Task(id: id, title: newTitle);
    await _dbHelper.updateTask(updatedTask);
    loadTasks(); // Reload after updating the task
  }

  void deleteTask(int id) async {
    await _dbHelper.deleteTask(id);
    loadTasks(); // Reload after deletion
  }
}
