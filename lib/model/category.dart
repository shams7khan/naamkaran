
class Example {
    String? id;
    String? catName;

    Example({this.id, this.catName});

    Example.fromJson(Map<String, dynamic> json) {
        this.id = json["id"];
        this.catName = json["cat_name"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data["id"] = this.id;
        data["cat_name"] = this.catName;
        return data;
    }
}