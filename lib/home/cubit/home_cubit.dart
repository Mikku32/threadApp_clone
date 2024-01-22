import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:form_app/Common/utils/api_client.dart';
import 'package:form_app/home/models/thread.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

void getHomeData() async {
  emit(HomeLoading());
  try{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final threads = await dioClient.get(
      '/threads/',
      options: Options(
        headers: {
          'Authorization': 'Token $token'
        }
      )
    );
    final List<Thread> threadsList = [];
    for (var thread in threads.data){
      threadsList.add(Thread.fromJson(thread));
    }
    emit(HomeSuccess(threadsList));
  } catch(e){
    emit(HomeError(message: e.toString()));
  }

}
}
