import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:moor_test/moor_database.dart';
import 'package:moor_test/new_task_input.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tasks'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: _buildTaskList(context)),
            const NewTaskInput(),
          ],
        ));
  }

  StreamBuilder<List<Task>> _buildTaskList(BuildContext context) {
    final database = Provider.of<MyDatabase>(context);
    return StreamBuilder(
      stream: database.watchAllTasks(),
      builder: (context, AsyncSnapshot<List<Task>> snapshot) {
        final tasks = snapshot.data ?? [];
        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (_, index) {
            final itemTask = tasks[index];
            return _buildListItem(itemTask, database);
          },
        );
      },
    );
  }

  Widget _buildListItem(Task itemTask, MyDatabase database) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
          label: 'Delete',
          backgroundColor: Colors.red,
          icon: Icons.delete,
          onPressed: (BuildContext context)=>database.deleteTask(itemTask),
        )  
        ],

      ),
      child: CheckboxListTile(
        title: Text(itemTask.name),
        subtitle: Text(itemTask.dueDate?.toString() ?? 'No date'),
        value: itemTask.completed,
        onChanged: (newValue) {
          database.updateTask(itemTask.copyWith(completed: newValue));
        },
      ),
    );
  }
}
  
