import 'package:bloc/bloc.dart';
import 'package:form_app/Common/utils/api_client.dart';
import 'package:form_app/upload/models/create.dart';
import 'package:meta/meta.dart';

part 'upload_state.dart';

class UploadCubit extends Cubit<UploadState> {
  UploadCubit() : super(UploadInitial());

  void createThread(String content, String image) async {
     emit(UploadLoading());
   try{
    final user = await dioClient.post(
      '/threads/', //go to this page
      data: {
        'content': content,
        'image': '' ,
      }
    ); 
    emit(UploadSuccess( Create.fromJson(user.data)));
  
   } catch(e){
     emit(UploadError(message: e.toString()));
   }
  }
}
