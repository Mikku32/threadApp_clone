import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:form_app/Common/models/user.dart';
import 'package:form_app/Common/utils/api_client.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

 void login(String email, String password) async{
   emit(AuthLoading());
   try{
    final user = await dioClient.post(
      '/login/', //go to this page
      data: {
        'username': email,
        'password': password
      }
    ); 
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', user.data['token']);
    emit(AuthSuccess(user: User.fromJson(user.data)));
   } catch(e){
     emit(AuthError(message: e.toString()));
   }
 }
 void loadUser() async {
   emit(AuthLoading());
   try{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final user = await dioClient.get(
      '/profile/', //go to this page
      options: Options(
        headers: {
          'Authorization': 'Token $token'   
        },
        )
    );
    user.data['token'] = token;
    emit(AuthSuccess(user: User.fromJson(user.data)));
   }
   catch(e){
     emit(AuthInitial());
   }
 }
 void logout() async {
   final SharedPreferences prefs = await SharedPreferences.getInstance();
   await prefs.remove('token');
 }
}
