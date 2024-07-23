import 'package:demo_app/models/todo.dart';
import 'package:demo_app/pages/components/custome_app_bar.dart';
import 'package:demo_app/pages/todo/success_alert.dart';
import 'package:demo_app/pages/todo/todo_page.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddNewTodo extends StatefulWidget {
  const AddNewTodo({super.key});

  @override
  State<StatefulWidget> createState() {
    return _stateAddNewTodo();
  }
}

// ignore: camel_case_types
class _stateAddNewTodo extends State<AddNewTodo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? task;
  String? description;

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
      title: "Add New Todo",
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
      var todo = Todo(
        id: DateTime.now().microsecondsSinceEpoch,
        title: task!,
        description: description!,
      );
      await Todo.insert(todo);
    }
  }

  void _showAlert() {
    showCustomAlert(
      context: context,
      type: AlertType.success,
      title: "A new todo was added",
      description: "",
      buttonText: "Ok",
      routeBuilder: (context) => const TodoPage(),
    );
  }
}
