import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:l_sha_a/core/constatnt.dart';
import 'package:l_sha_a/core/function.dart';
import 'package:l_sha_a/data/models/material_model.dart';

class MaterialCard extends StatelessWidget {
  const MaterialCard({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  Widget build(BuildContext context) {
    log("Book ID: ${book.id}");
    log("mater ID: ${Constatnt.cuurentMaterial}");
    return GestureDetector(
      onTap: () {
        if (Constatnt.cuurentMaterial == "اقتصاد كلي" && book.id == "10_MAC") {
          openUrl(
              "https://drive.google.com/file/d/1MswQ9fkHHuXwYxHITMkN_ts7-KT_d8tF/view?usp=drive_link");
        }
        if (Constatnt.cuurentMaterial == "اقتثاد جزئي" &&
            book.id == "19_ME_2000") {
          openUrl(
              "https://drive.google.com/file/d/1YIrQdgYmKq5d6HxLGj5iuZh_9-F9a2D6/view?usp=drive_link");
        } else if (Constatnt.cuurentMaterial == "الاحصاء" &&
            book.id == "10_S 310_م.م 2009") {
          openUrl(
              "https://drive.google.com/file/d/1PuvOz0be5ffh6b3ZqBcsdvJl6-W5jjoi/view?usp=drive_link");
        } else if (Constatnt.cuurentMaterial == "التسويق" &&
            book.id == "15_M 658,8_D.G") {
          openUrl(
              "https://drive.google.com/file/d/11UV01H__7IoFN0uPlDDRHboUvaUlOLz9/view?usp=drive_link");
        } else if (Constatnt.cuurentMaterial == "السلوك التنظيمي" &&
            book.id == "350_AS_2020") {
          openUrl(
              "https://drive.google.com/file/d/1MvCqNFRyoGskf9uOVlQfgQzLep7bnoP9/view?usp=drive_link");
        } else if (Constatnt.cuurentMaterial == "ادارة الموارد البشرية" &&
            book.id == "15_H.R.M 350_P.R 2019 1") {
          openUrl(
              "https://drive.google.com/file/d/1PuvOz0be5ffh6b3ZqBcsdvJl6-W5jjoi/view?usp=drive_link");
        }
      },
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
