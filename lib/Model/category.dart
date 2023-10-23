class Categories {
  final String id;
  final String categoryName;

  const Categories({
    required this.id,
    required this.categoryName,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['id'],
      categoryName: json['categoryName'],
    );
  }
}