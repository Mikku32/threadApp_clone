import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:form_app/Common/utils/api_client.dart';
import 'package:form_app/home/models/thread.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'update_state.dart';

class UpdateCubit extends Cubit<UpdateState> {
  UpdateCubit() : super(UpdateInitial());

  void updateThread(
    String content,
    int id,
  ) async {
    emit(UpdateLoading());

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final threads = await dioClient.patch(
        '/threads/$id/',
        options: Options(headers: {'Authorization': 'Token $token'}),
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
