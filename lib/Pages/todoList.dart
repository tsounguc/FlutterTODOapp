import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertodoapp/Pages/task.dart';
import 'package:fluttertodoapp/Pages/todoCreate.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key key, @required this.user}) : super(key: key);
  final AuthResult user;
  @override
  _TodoListState createState() => _TodoListState(this.user);
}

class _TodoListState extends State<TodoList> {
  _TodoListState(this.user);
  AuthResult user;
  String _todoNameInput = '';
  bool onToggle;
  TextEditingController controller = TextEditingController();

  //Creating a list of task with some dummy values for now
  List<Task> tasks = [
//    Task('Check email', false),
//    Task('Laundry', false),
//    Task('Workout', false),
//    Task('Go Grocery shopping', false),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/Mountains.jpg'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
          title: Text('List'
//              '${user.user.email}',
              ),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
//                        validator: (input) {
//                          if (input.isEmpty) {
//                            return 'Please enter a task';
//                          }
//                          return null;
//                        },
                        controller: controller,
//                        onSaved: (input) => _todoNameInput = input,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white70,
                          suffixIcon: RaisedButton.icon(
                            color: Colors.white70,
                            onPressed: () {
                              WidgetsBinding.instance.addPostFrameCallback(
                                  (_) => controller.clear());
                              if (controller.text.isNotEmpty) {
                                print(controller.text);
                                onTaskCreated(controller.text);
                              }
                            },
                            icon: Icon(Icons.add),
                            label: Text(''),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return Theme(
                      data: ThemeData(
                        unselectedWidgetColor: Colors.white,
                      ),
                      child: CheckboxListTile(
                        dense: false,
                        checkColor: Colors.green,
                        activeColor: Colors.transparent,
                        title: Text(
                          tasks[index].name,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        value: tasks[index].completed,
                        onChanged: (bool value) {
                          setState(() {
                            tasks[index].completed = value;
                          });

                          print(tasks[index].completed);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTaskCreated(String name) {
    setState(() {
      tasks.add(Task(name, false));
    });
  }
}
