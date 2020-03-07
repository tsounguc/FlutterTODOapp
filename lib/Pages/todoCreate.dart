import 'package:flutter/material.dart';

class TodoCreate extends StatefulWidget {
  @override
  _TodoCreateState createState() => _TodoCreateState();
}

class _TodoCreateState extends State<TodoCreate> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
//    return Dialog(
//      child: Center(
//        child: TextFormField(
//          autofocus: true,
//        ),
//      ),
//    );
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
          title: Text('Task'
//              '${user.user.email}',
              ),
          centerTitle: true,
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              autofocus: true,
              validator: (input) {
                if (input.isEmpty) {
                  return 'Please type a valid email';
                }
                return null;
              },
//              onSaved: (input) => _email = input,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white70,
//                border: OutlineInputBorder(
//                  borderRadius: BorderRadius.circular(30.0),
//                ),
//                labelText: 'Email',
//                prefixIcon: Icon(Icons.email),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
