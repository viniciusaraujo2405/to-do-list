import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/TaskProvider.dart';

class EditTaskScreen extends StatefulWidget {
  final String taskId;
  final String currentTaskText;

  EditTaskScreen({required this.taskId, required this.currentTaskText});

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _taskController.text = widget.currentTaskText; 
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Tarefa'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: InputDecoration(labelText: 'Editar Tarefa'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_taskController.text.isNotEmpty) {
                  try {
                    await taskProvider.updateTask(
                      widget.taskId,
                      _taskController.text,
                    );
                    Navigator.pop(context); 
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Erro ao atualizar tarefa: $e')),
                    );
                  }
                }
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}