class ProfileModel {
  final String name;
  final List<ProfileTodo> todos;

  ProfileModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        todos = ProfileTodo.fromList(json['todos']);
}

class ProfileTodo {
  final String title, content;

  ProfileTodo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        content = json['content'];

  static fromList(List<dynamic> list) {
    return list.map((e) => ProfileTodo.fromJson(e)).toList();
  }
}
