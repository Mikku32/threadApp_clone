import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_app/Common/utils/api_client.dart';
import 'package:form_app/auth/cubit/auth_cubit.dart';
import 'package:form_app/home/models/thread.dart';
import 'package:form_app/profile/model/profile_model.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  // void getProfileData() async {
  //   emit(ProfileLoading());
  //   try {
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     final token = prefs.getString('token');

  //     final profile = await dioClient.get( '/profile/',
  //       options: Options( headers: { 'Authorization': 'Token $token'} ));


      
      
      
  //   }
  //   catch(e){
  //     emit(ProfileError(message: e.toString()));
  //   }
  // }
 
  void getProfileThreads(int? userId) async{
    emit(ProfileLoading());
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
  
      final profile = await dioClient.get( '/threads/?user=$userId',
        options: Options( headers: { 'Authorization': 'Token $token'} ));
        
         final List<Thread> UserThreadList = [];
    for (var thread in profile.data){
      UserThreadList.add(Thread.fromJson(thread));}
    emit(ProfileSuccess(UserThreadList));
    }
    catch(e){
      emit(ProfileError(message: e.toString()));
    }
  }
}
