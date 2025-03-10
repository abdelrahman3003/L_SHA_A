part of 'material_cubit.dart';

@immutable
sealed class MateriallState {}

final class MaterialInitial extends MateriallState {}

final class MaterialGetbooksLoading extends MateriallState {}

final class MaterialGetbooksSuccess extends MateriallState {
  final List<Book> bookList;

  MaterialGetbooksSuccess({required this.bookList});
}

final class MaterialGetbooksError extends MateriallState {
  final String errorMessage;

  MaterialGetbooksError({required this.errorMessage});
}

final class MaterialSearchbooksLoading extends MateriallState {}

final class MaterialSearchbooksSuccess extends MateriallState {
  final Book book;

  MaterialSearchbooksSuccess({required this.book});
}

final class MaterialSearchbooksError extends MateriallState {
  final String errorMessage;

  MaterialSearchbooksError({required this.errorMessage});
}
