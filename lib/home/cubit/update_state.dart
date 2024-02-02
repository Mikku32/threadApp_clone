part of 'update_cubit.dart';

@immutable
sealed class UpdateState {}

final class UpdateInitial extends UpdateState {}

final class UpdateLoading extends UpdateState {}

final class UpdateSuccess extends UpdateState {
  final Thread threads;
  UpdateSuccess(this.threads);
}

final class UpdateError extends UpdateState {
  final String message;
  UpdateError({required this.message});
}
