class Task {
  //Properties
  String _name;
  bool _completed;

  //Constructor
  Task(this._name, this._completed);

  //Setters and getters
  //name
  String get name => _name;
  set name(String value) {
    _name = value;
  }

  //completed
  bool get completed => _completed;

  set completed(bool value) {
    _completed = value;
  }
}
