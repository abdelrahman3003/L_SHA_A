class Department {
  final String name;
  final List<Subject> subjects;

  Department({required this.name, required this.subjects});

  // تحويل الـ DocumentSnapshot من Firestore إلى كائن Department
  factory Department.fromMap(Map<String, dynamic> map) {
    return Department(
      name: map['name'] ?? '',
      subjects: (map['subjects'] as List<dynamic>)
          .map((subject) => Subject.fromMap(subject))
          .toList(),
    );
  }

  // تحويل كائن Department إلى خريطة (Map) لتخزينه في Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'subjects': subjects.map((subject) => subject.toMap()).toList(),
    };
  }
}

class Subject {
  final String name;
  final String pdfUrl;

  Subject({required this.name, required this.pdfUrl});

  // تحويل البيانات القادمة من Firestore إلى كائن Subject
  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
      name: map['name'] ?? '',
      pdfUrl: map['pdfUrl'] ?? '',
    );
  }

  // تحويل كائن Subject إلى خريطة (Map) لتخزينه في Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'pdfUrl': pdfUrl,
    };
  }
}
