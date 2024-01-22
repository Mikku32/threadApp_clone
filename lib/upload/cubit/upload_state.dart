part of 'upload_cubit.dart';

@immutable
sealed class UploadState {}

final class UploadInitial extends UploadState {}

final class UploadLoading extends UploadState {}

final class UploadSuccess extends UploadState {
  final Create create;
  UploadSuccess(this.create);
}

final class UploadError extends UploadState {
  final String message;
  UploadError({required this.message});
}
