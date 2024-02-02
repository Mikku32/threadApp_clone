import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:form_app/Common/utils/api_client.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'delete_state.dart';

class DeleteCubit extends Cubit<DeleteState> {
  DeleteCubit() : super(DeleteInitial());

  void deleteThread(int id) async {
    emit(DeleteLoading());

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      await dioClient.delete(
        '/threads/$id/',
        options: Options(headers: {'Authorization': 'Token $token'}),
      );
      emit(DeleteSuccess());
    } catch (e) {
      emit(DeleteError(message: e.toString()));
    }
  }
}
