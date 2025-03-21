import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:l_sha_a/core/constatnt.dart';
import 'package:l_sha_a/data/models/material_data.dart';
import 'package:l_sha_a/data/models/material_model.dart';
import 'package:meta/meta.dart';

part 'department_state.dart';

class DepartmentCubit extends Cubit<DepartmentState> {
  DepartmentCubit() : super(DepartmentInitial()) {
    emitGetMaterialStates();
    // deleteCollection("departments");
    // String materialName = MaterialData.materials1[0].keys.first;
    // List<Book> materialBooks = MaterialData.materials1[0][materialName]!;
    // addSubjectWithBooks(
    //     departmentId: "نظم المعلومات",
    //     materialName: materialName,
    //     bookList: materialBooks);
    //   addDepartments(MaterialData.materials1);
  }

  List<String>? materials;
  addDepartments(List<Map<String, List<Book>>> materials) {
    for (var i = 0; i < materials.length; i++) {
      String materialName = MaterialData.materials1[i].keys.first;
      List<Book> materialBooks = MaterialData.materials1[i][materialName]!;
      addSubjectWithBooks(
          departmentId: "الادارة والماحسبة",
          materialName: materialName,
          bookList: materialBooks);
    }
  }

  Future<void> deleteCollection(String collectionPath) async {
    var collection = FirebaseFirestore.instance.collection(collectionPath);
    var snapshots = await collection.get();

    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }

    print("✅ تم حذف جميع البيانات من المجموعة: $collectionPath");
  }

// استخدام الدالة
  void main() async {
    await deleteCollection(
        "اسم_المجموعة"); // غيّر "اسم_المجموعة" إلى اسم الكولكشن
  }

  getMaterialsInDepartment(String departmentId) async {
    try {
      CollectionReference materialsRef = FirebaseFirestore.instance
          .collection('departments')
          .doc(departmentId)
          .collection('materials');

      QuerySnapshot materialsSnapshot = await materialsRef.get();

      materials = [];
      for (var materialDoc in materialsSnapshot.docs) {
        materials!.add(materialDoc.id);
      }

      log("✅ تم جلب ${materials!.length} مواد من القسم ($departmentId) بنجاح!");
      return materials;
    } catch (e) {
      log("❌ حدث خطأ أثناء جلب المواد من القسم ($departmentId): $e");
      return [];
    }
  }

  Future<void> addSubjectWithBooks({
    required String departmentId,
    required String materialName,
    required List<Book> bookList,
  }) async {
    try {
      DocumentReference departmentDoc = FirebaseFirestore.instance
          .collection('departments')
          .doc(departmentId);

      // 🔹 التحقق مما إذا كان القسم موجودًا، وإنشاؤه إذا لم يكن موجودًا
      DocumentSnapshot departmentSnapshot = await departmentDoc.get();
      if (!departmentSnapshot.exists) {
        await departmentDoc.set({"name": departmentId});
        log("✅ تم إنشاء القسم ($departmentId) بنجاح!");
      }

      DocumentReference materialDoc =
          departmentDoc.collection('materials').doc(materialName);

      // 🔹 إنشاء المادة فقط إذا لم تكن موجودة
      await materialDoc.set({"name": materialName}, SetOptions(merge: true));

      // 🔹 إضافة الكتب داخل المادة
      for (var book in bookList) {
        if (book.id.isEmpty) {
          log("⚠️ الكتاب بدون ID! لم يتم إضافته.");
          continue;
        }
        await materialDoc.collection('books').doc(book.id).set(book.toJson());
      }

      log("✅ تمت إضافة المادة ($materialName) والكتب بنجاح في القسم ($departmentId)!");
    } catch (e) {
      log("❌ حدث خطأ أثناء الإضافة: $e");
    }
  }

  emitGetMaterialStates() async {
    emit(DepartmentGetMaterialLoading());
    await getMaterialsInDepartment(Constatnt.cuurentDepartment!);
    if (materials == null) {
      emit(DepartmentGetMaterialError(
          errorMessage: "حدث خطأ أثناء جلب المستندات من القسم "));
    } else {
      emit(DepartmentGetMaterialSuccess(materials: materials!));
    }
  }
}
