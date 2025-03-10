import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:l_sha_a/core/constatnt.dart';
import 'package:l_sha_a/data/models/material_model.dart';
import 'package:meta/meta.dart';

part 'material_state.dart';

class MaterialCubit extends Cubit<MateriallState> {
  MaterialCubit() : super(MaterialInitial()) {
    emitgetBooksStates();
  }

  List<Book>? allBooks;
  int? bookSearchIndex;

  Future<void> getBooksForSubject(
      {required String departmentId, required String materialId}) async {
    try {
      CollectionReference booksCollection = FirebaseFirestore.instance
          .collection('departments')
          .doc(departmentId)
          .collection('materials')
          .doc(materialId)
          .collection('books');
      QuerySnapshot booksSnapshot = await booksCollection.get();
      allBooks = booksSnapshot.docs
          .map((bookDoc) =>
              Book.fromJson(bookDoc.data() as Map<String, dynamic>))
          .toList();

      log("✅ تم جلب ${allBooks?.length} كتاب بنجاح لمادة: $materialId");
    } catch (e) {
      log("❌ حدث خطأ أثناء جلب الكتب للمادة: $e");
    }
  }

  searchBookById(String bookId) {
    bookSearchIndex = allBooks!.indexWhere((book) => book.id == bookId);
  }

  emitgetBooksStates() async {
    emit(MaterialGetbooksLoading());
    await getBooksForSubject(
        departmentId: Constatnt.cuurentDepartment!,
        materialId: Constatnt.cuurentMaterial!);
    if (allBooks == null) {
      emit(MaterialGetbooksError(errorMessage: "هنالك حطا في جلب الكتب"));
    } else {
      emit(MaterialGetbooksSuccess(bookList: allBooks!));
    }
  }

  emitSearchBooksStates(String bookId) async {
    emit(MaterialSearchbooksLoading());
    await searchBookById(bookId);

    if (bookSearchIndex == null) {
      emit(MaterialSearchbooksError(errorMessage: "لا يوجد كتاب "));
    } else {
      emit(MaterialSearchbooksSuccess(book: allBooks![bookSearchIndex!]));
    }
  }
}
