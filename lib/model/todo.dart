class Todo {
  late int _id;
  String? _content;

  Todo.fromData(this._id, this._content);

  get id => this._id;

  set id(value) => this._id = value;

  get content => this._content;

  set content(value) => this._content = value;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
    };
  }
}
