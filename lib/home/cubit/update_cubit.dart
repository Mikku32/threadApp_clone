import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:form_app/Common/utils/api_client.dart';
import 'package:form_app/home/models/thread.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'update_state.dart';

class UpdateCubit extends Cubit<UpdateState> {
  UpdateCubit() : super(UpdateInitial());

  void updateThread(
    String content,
    int id,
  ) async {
    emit(UpdateLoading());

    try {
      final threads = await dioClient.patch(
        '/threads/$id/',
        data: {
          'content': content,
        },
      );
      emit(
        UpdateSuccess(
          Thread.fromJson(threads.data),
        ),
      );
    } catch (e) {
      emit(UpdateError(message: e.toString()));
    }
  }
}
