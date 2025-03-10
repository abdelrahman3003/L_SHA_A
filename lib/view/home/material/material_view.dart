import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:l_sha_a/controller/material/material_cubit.dart';
import 'package:l_sha_a/core/app_colors.dart';
import 'package:l_sha_a/core/app_styles.dart';
import 'package:l_sha_a/view/home/material/widget/materail_Card.dart';

class MaterialView extends StatelessWidget {
  const MaterialView({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<MaterialCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "قائمة الكتب",
          style: AppStyles.font20WhiteMEdiam,
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(
          size: 24.sp,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              textAlign: TextAlign.right,
              onSubmitted: (value) {
                cubit.emitSearchBooksStates(value);
              },
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: "ابحث عن كتاب...",
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(child: BlocBuilder<MaterialCubit, MateriallState>(
              builder: (context, state) {
                if (state is MaterialGetbooksError) {
                  return Center(child: Text(state.errorMessage));
                }
                if (state is MaterialGetbooksLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is MaterialGetbooksSuccess) {
                  return ListView.builder(
                    itemCount: state.bookList.length,
                    itemBuilder: (context, index) {
                      final materialModel = state.bookList[index];
                      return MaterialCard(book: materialModel);
                    },
                  );
                }
                if (state is MaterialSearchbooksSuccess) {
                  return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      final materialModel = state.book;
                      return MaterialCard(book: materialModel);
                    },
                  );
                }
                if (state is MaterialSearchbooksError) {
                  return Center(child: Text(state.errorMessage));
                }
                return SizedBox();
              },
            )),
          ],
        ),
      ),
    );
  }
}
