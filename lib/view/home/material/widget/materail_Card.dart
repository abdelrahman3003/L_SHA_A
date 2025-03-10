import 'package:flutter/material.dart';
import 'package:l_sha_a/data/models/material_model.dart';

class MaterialCard extends StatelessWidget {
  const MaterialCard({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: ListTile(
          title: Align(
            alignment: Alignment.centerRight,
            child: Text(
              book.title,
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),
          subtitle: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "المؤلف: ${book.author} - السنة: ${book.year}",
              textAlign: TextAlign.right,
            ),
          ),
          leading: Text("نسخ: ${book.copies}"),
        ),
      ),
    );
  }
}
