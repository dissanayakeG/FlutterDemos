import 'package:demo_app/models/todo.dart';
import 'package:demo_app/pages/components/custome_app_bar.dart';
import 'package:demo_app/pages/todo/add_new_todo.dart';
import 'package:demo_app/pages/todo/success_alert.dart';
import 'package:demo_app/pages/todo/update_todo.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TodoState();
  }
}

class _TodoState extends State<TodoPage> {
  late Future<List<Todo>> _todoList;
  @override
  void initState() {
    super.initState();
    _getAllTodos();
  }

  void _getAllTodos() {
    setState(() {
      _todoList = Todo.getAllTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: "Todo List",
        ),
        body: FutureBuilder(
          future: _todoList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text("Couldn't load the data"),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "No data available",
                    style: TextStyle(fontSize: 25.0),
                  ),
                ),
              );
            }

            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var todo = snapshot.data![index];
                  return Container(
                    margin: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    child: ListTile(
                      // tileColor: Colors.green[100],
                      leading: const Icon(
                        Icons.task,
                        color: Colors.amber,
                        size: 40.0,
                      ),
                      title: Text(
                        todo.title,
                        style: const TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        todo.description,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: IconButton(
                        color: Colors.red,
                        iconSize: 40.0,
                        onPressed: () {
                          _deleteTodo(todo);
                          _showAlert();
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateTodo(todo: todo),
                          ),
                        );
                        _getAllTodos();
                      },
                    ),
                  );
                });
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddNewTodo(),
              ),
            );
            _getAllTodos();
          },
          child: const Icon(Icons.add),
        ));
  }

  void _deleteTodo(todo) async {
    await Todo.delete(todo.id);
    _getAllTodos();
  }

  void _showAlert() {
    showCustomAlert(
      context: context,
      type: AlertType.success,
      title: "The todo was deleted",
      description: "",
      buttonText: "Ok",
      routeBuilder: (context) => const TodoPage(),
    );
  }
}
