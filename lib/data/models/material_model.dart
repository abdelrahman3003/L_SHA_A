class Book {
  final String id;
  final String title;
  final String author;
  final int copies;
  final int year;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.copies,
    required this.year,
  });

  // ✅ تحويل كائن إلى Map لإرساله إلى Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'copies': copies,
      'year': year,
    };
  }

  // ✅ تحويل Map إلى كائن Dart عند استرجاع البيانات
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      copies: json['copies'] ?? 0,
      year: json['year'] ?? 0,
    );
  }
}
