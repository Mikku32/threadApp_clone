import 'package:bloc/bloc.dart';
import 'package:form_app/Common/utils/api_client.dart';
import 'package:meta/meta.dart';

part 'delete_state.dart';

class DeleteCubit extends Cubit<DeleteState> {
  DeleteCubit() : super(DeleteInitial());

  void deleteThread(int id) async {
    emit(DeleteLoading());

    try {
      await dioClient.delete(
        '/threads/$id/',
      );
      emit(DeleteSuccess());
    } catch (e) {
      emit(DeleteError(message: e.toString()));
    }
  }
}
