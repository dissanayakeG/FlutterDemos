import 'package:demo_app/models/todo.dart';
import 'package:demo_app/pages/components/custome_app_bar.dart';
import 'package:demo_app/pages/todo/success_alert.dart';
import 'package:demo_app/pages/todo/todo_page.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UpdateTodo extends StatefulWidget {
  const UpdateTodo({super.key, required this.todo});

  final Todo todo;

  @override
  State<StatefulWidget> createState() {
    return _stateUpdateTodo();
  }
}

// ignore: camel_case_types
class _stateUpdateTodo extends State<UpdateTodo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? task;
  String? description;

  @override
  void initState() {
    super.initState();
    task = widget.todo.title;
    description = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _buildForm(),
      floatingActionButton: _floatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  PreferredSizeWidget _appBar() {
    return const CustomAppBar(
      title: "Update Todo",
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              initialValue: task,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a value";
                }
                return null;
              },
              onSaved: (newValue) {
                setState(() {
                  task = newValue;
                });
              },
              decoration: const InputDecoration(hintText: "Title"),
            ),
            TextFormField(
              initialValue: description,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a value";
                }
                return null;
              },
              onSaved: (newValue) {
                setState(() {
                  description = newValue;
                });
              },
              decoration: const InputDecoration(hintText: "Description"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _floatingButton() {
    return FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            _formKey.currentState?.save();
            _saveTodo();
            _showAlert();
          }
        },
        child: const Icon(Icons.add));
  }

  Future<void> _saveTodo() async {
    if (task != null && description != null) {
      var updatedTodo = Todo(
        id: widget.todo.id,
        title: task!,
        description: description!,
      );
      await Todo.update(updatedTodo);
    }
  }

  void _showAlert() {
    showCustomAlert(
      context: context,
      type: AlertType.success,
      title: "The todo was updated",
      description: "",
      buttonText: "Ok",
      routeBuilder: (context) => const TodoPage(),
    );
  }
}
