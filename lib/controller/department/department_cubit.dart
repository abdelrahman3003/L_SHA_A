import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:l_sha_a/data/repo/department_data.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

part 'department_state.dart';

class DepartmentCubit extends Cubit<DepartmentState> {
  DepartmentCubit() : super(DepartmentInitial());
  DepartmentData departmentData = DepartmentData();

  Future<void> launchPdf(String pdfUrl) async {
    final Uri url = Uri.parse(pdfUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      log("-------------fail");

      throw 'لا يمكن فتح الرابط: ';
    } else {
      log("-------------success");
    }
  }
}
