class TodoModel {
  String? id;
  String? title;
  String? description;
  String? deadline;
  String? image;
  String? createdAt;

  TodoModel({
    this.id,
    this.title,
    this.description,
    this.deadline,
    this.image,
    this.createdAt,
  });

  TodoModel.fromJson(Map<String, dynamic> json) {
    id = json["ID"].toString();
    title = json["TITLE"].toString();
    description = json["DESCRIPTION"].toString();
    createdAt = json["CREATEDAT"].toString();
    deadline = json["DEADLINE"].toString();
    image = json["IMAGE"].toString();
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data["ID"] = id.toString();
    data["TITLE"] = title.toString();
    data["DESCRIPTION"] = description.toString();
    data["CREATEDAT"] = createdAt.toString();
    data["DEADLINE"] = deadline.toString();
    data["IMAGE"] = image.toString();
    return data;
  }
}
