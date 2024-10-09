import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/task_controller.dart';
import '../model/task_model.dart';

class TaskPage extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());
  final TextEditingController textController = TextEditingController();

  TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sqflite TaskManage'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      decoration: const InputDecoration(
                        hintText: 'Enter task title',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Check if the input is empty before adding a task
                      if (textController.text.isEmpty) {
                        // Show snackbar if no text is entered
                        Get.snackbar(
                          'Error',
                          'Please add some task', // Message to display
                          snackPosition:
                              SnackPosition.BOTTOM, // Position of the snackbar
                          backgroundColor: Colors
                              .red, // Optional: change background color to red
                          colorText:
                              Colors.white, // Optional: change text color
                        );
                      } else {
                        // Add task if input is not empty
                        taskController.addTask(textController.text);
                        textController
                            .clear(); // Clear the text field after adding
                      }
                    },
                    child: const Text('Add Task'),
                  )
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: taskController.tasks.length,
                  itemBuilder: (context, index) {
                    final task = taskController.tasks[index];
                    return ListTile(
                      title: Text(task.title), // Displaying the task title
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              _showEditDialog(context, task);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _showDeleteConfirmationDialog(context, task);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  // Method to show the edit dialog
  void _showEditDialog(BuildContext context, Task task) {
    TextEditingController editController =
        TextEditingController(text: task.title);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(hintText: 'Enter new task title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (editController.text.isNotEmpty) {
                  taskController.updateTask(task.id!, editController.text);
                }
                Get.back();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  // Method to show the delete confirmation dialog
  void _showDeleteConfirmationDialog(BuildContext ctx, Task task) {
    showDialog(
      context: ctx,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Task'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Close the dialog without deleting
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                taskController.deleteTask(task.id!); // Delete the task
                Get.back(); // Close the dialog after deleting
              },
              child: const Text(
                'Yes',
                style:
                    TextStyle(color: Colors.red), // Highlight the 'Yes' button
              ),
            ),
          ],
        );
      },
    );
  }
}
