class Category{
  String name;

  Category(this.name);

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      json['strCategory'] ?? "",
    );
  }
}