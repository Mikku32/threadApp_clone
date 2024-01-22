import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:form_app/Common/utils/api_client.dart';
import 'package:form_app/upload/models/create.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'upload_state.dart';

class UploadCubit extends Cubit<UploadState> {
  UploadCubit() : super(UploadInitial());

  void createThread(String content) async {
     emit(UploadLoading());
   try{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    
    final user = await dioClient.post(
      '/threads/', //go to this page

      options: Options( headers: { 'Authorization': 'Token $token'} ),
      data: {
        'content': content,
        
      }
    ); 
    emit(UploadSuccess( Create.fromJson(user.data)));
  
   } catch(e){
     emit(UploadError(message: e.toString()));
   }
  }
}
