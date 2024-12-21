import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class Task {
  String name;
  bool isCompleted;
  String priority;

  Task({required this.name, this.isCompleted = false, this.priority = 'Low'});
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Task> _tasks = [];
  final TextEditingController _controller = TextEditingController();
  String _selectedPriority = 'Low';

  // Form validation
  bool _isValid() {
    return _controller.text.isNotEmpty;
  }

  void _addTask() {
    if (_isValid()) {
      setState(() {
        _tasks.add(Task(name: _controller.text, priority: _selectedPriority));
      });
      _controller.clear();
    }
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _clearAllTasks() {
    setState(() {
      _tasks.clear();
    });
  }

  void _toggleCompletion(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter your task',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _addTask(),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: _selectedPriority,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPriority = newValue!;
                });
              },
              items: ['Low', 'Medium', 'High']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addTask,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text('Add Task'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return _TaskCard(
                    task: _tasks[index],
                    onDelete: () => _deleteTask(index),
                    onToggleCompletion: () => _toggleCompletion(index),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _clearAllTasks,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('Clear All'),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Task Card Widget
class _TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onToggleCompletion;

  _TaskCard({
    required this.task,
    required this.onDelete,
    required this.onToggleCompletion,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: IconButton(
          icon: Icon(
            task.isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
            color: task.isCompleted ? Colors.green : null,
          ),
          onPressed: onToggleCompletion,
        ),
        title: Text(
          task.name,
          style: TextStyle(
            decoration:
                task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text('Priority: ${task.priority}'),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
