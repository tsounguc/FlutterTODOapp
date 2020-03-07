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
          child: StreamBuilder(
              stream: Firestore.instance
                  .collection('users')
                  .document('${user.user.email}')
                  .collection('tasks')
                  .snapshots(),
//              stream: getUsersTodoListSnapshots(context),
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

  void onTaskCreated(String name) {
    Firestore.instance.collection('users/${user.user.email}/tasks').add({
      'name': name,
      'completed': false,
    });
  }

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
                suffixIcon: RaisedButton.icon(
                  color: Colors.white70,
                  onPressed: () {
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) => controller.clear());
                    if (controller.text.isNotEmpty) {
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
                ? Firestore.instance
                    .collection('users/${user.user.email}/tasks')
                    .document(snapshot.data.documents[index].documentID)
                    .delete()
                : Dismissible(
                    key: Key('${snapshot.data.documents[index]}'),
                    background: Container(color: Colors.red),
                    onDismissed: (direction) {
                      Firestore.instance
                          .collection('users/${user.user.email}/tasks')
                          .document(snapshot.data.documents[index].documentID)
                          .delete();
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
                          width: 50,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Checkbox(
                                  checkColor: Colors.green,
                                  activeColor: Colors.transparent,
                                  value: snapshot.data.documents[index]
                                      ['completed'],
                                  onChanged: (bool value) {
                                    snapshot.data.documents[index].reference
                                        .updateData({
                                      'completed': !snapshot
                                          .data.documents[index]['completed'],
                                    });
                                  },
                                ),
                              ),
                              Container(),
                              Expanded(
                                child: IconButton(
                                    color: Colors.white,
                                    icon: Icon(Icons.more_vert),
                                    onPressed: () {}),
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
}
