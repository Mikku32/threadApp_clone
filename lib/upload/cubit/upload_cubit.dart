import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:form_app/Common/utils/api_client.dart';
import 'package:form_app/upload/models/create.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'upload_state.dart';

class UploadCubit extends Cubit<UploadState> {
  UploadCubit() : super(UploadInitial());

  void createThread(
    String content,
    XFile? image
    ) async {
     emit(UploadLoading());

     
   try{
     final formData= FormData.fromMap({
    "content":content,
    if(image!=null)
    "image": await MultipartFile.fromFile(image.path,filename: image.name)
  });



    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    
    final user = await dioClient.post('/threads/', //go to this page
    options: Options( headers: { 'Authorization': 'Token $token'} ),

      data: formData
    ); 
    emit(UploadSuccess( Create.fromJson(user.data)));
  
   } catch(e){
     emit(UploadError(message: e.toString()));
   }
  }
}
