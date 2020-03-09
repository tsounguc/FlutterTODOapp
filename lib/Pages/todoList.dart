import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertodoapp/Pages/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
          automaticallyImplyLeading: false,
          title: Text('List'),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: StreamBuilder(
              stream: Firestore.instance
                  .collection('users')
                  .document('${user.user.email}')
                  .collection('tasks')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return loading();
                }
                return Column(
                  children: <Widget>[
                    textFieldAndButton(),
                    listOfTodos(snapshot),
                  ],
                );
              }),
        ),
      ),
    );
  }

  //Displays circular progress indicator when
  Widget loading() {
    return Center(
      child: Column(
        children: <Widget>[
          CircularProgressIndicator(),
          Divider(
            height: 20,
          ),
          Text(
            'Loading. . .',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ],
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }

//--------------------Layout of todolist page-----------------------------------

  // returns the Textfield and add + button
  textFieldAndButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white70,
                hintText: 'Enter task here',
                suffixIcon: RaisedButton.icon(
                  color: Colors.white70,
                  onPressed: () {
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) => controller.clear());
                    if (controller.text.isNotEmpty) {
                      createTask(controller.text);
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
    );
  }

  listOfTodos(AsyncSnapshot snapshot) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Colors.black,
          ),
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) {
            return snapshot.data.documents[0]['name'] == null
                ? deleteTask(snapshot, index)
                : Dismissible(
                    key: Key('${snapshot.data.documents[index]}'),
                    background: Container(color: Colors.red),
                    onDismissed: (direction) {
                      deleteTask(snapshot, index);
                    },
                    child: Theme(
                      data: ThemeData(
                        unselectedWidgetColor: Colors.white,
                      ),
                      child: ListTile(
                        dense: false,
                        title: Text(
                          snapshot.data.documents[index]['name'],
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: SizedBox(
                          width: 75,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Checkbox(
                                  checkColor: Colors.green,
                                  activeColor: Colors.transparent,
                                  value: snapshot.data.documents[index]
                                      ['completed'],
                                  onChanged: (bool value) {
                                    updateTaskCompletion(
                                        snapshot,
                                        snapshot.data.documents[index]
                                            ['completed'],
                                        index);
                                  },
                                ),
                              ),
//                              Container(
//                                width: 25,
//                              ),
                              Expanded(
                                child: PopupMenuButton<String>(
                                  icon: Icon(
                                    Icons.more_vert,
                                    size: 30,
                                    color: Colors.white70,
                                  ),
                                  itemBuilder: (BuildContext context) =>
                                      <PopupMenuEntry<String>>[
                                    PopupMenuItem<String>(
                                      value: 'Edit',
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text('Edit'),
                                          ),
                                          Icon(Icons.edit),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem<String>(
                                      value: 'Delete',
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text('Delete'),
                                          ),
                                          Icon(Icons.delete),
                                        ],
                                      ),
                                    ),
                                  ],
                                  onSelected: (menuValue) {
                                    if (menuValue == 'Edit') {
                                      _displayDialog(context, snapshot, index);
                                    }
                                    if (menuValue == 'Delete') {
                                      deleteTask(snapshot, index);
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }

  void _displayDialog(
      BuildContext context, AsyncSnapshot snapshot, int index) async {
    TextEditingController textEditingController = TextEditingController();
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white70,
//            title: Text('Edit'),
            content: TextField(
              controller: textEditingController,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Submit'),
                onPressed: () {
                  updateTaskName(snapshot, textEditingController.text, index);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void createTask(String name) async {
    Firestore.instance.collection('users/${user.user.email}/tasks').add({
      'name': name,
      'completed': false,
    });
  }

  void updateTaskName(AsyncSnapshot snapshot, String name, int index) async {
    snapshot.data.documents[index].reference.updateData({
      'name': name,
    });
  }

  void updateTaskCompletion(
      AsyncSnapshot snapshot, bool completed, int index) async {
    snapshot.data.documents[index].reference.updateData({
      'completed': !completed,
    });
  }

  deleteTask(AsyncSnapshot snapshot, int index) async {
    Firestore.instance
        .collection('users/${user.user.email}/tasks')
        .document(snapshot.data.documents[index].documentID)
        .delete();
  }
}
