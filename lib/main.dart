import 'package:flutter/material.dart';
import 'package:form_app/Common/views/navigation_bar.dart';
import 'package:form_app/Common/views/splash_screen.dart';
import 'package:form_app/auth/cubit/auth_cubit.dart';
import 'package:form_app/auth/views/login_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_app/home/cubit/home_cubit.dart';
import 'package:form_app/profile/cubit/profile_cubit.dart';
import 'package:form_app/upload/cubit/upload_cubit.dart';
void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit()..loadUser(),
        ),
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(),
        ),
        BlocProvider(
          create: (context) => UploadCubit(),
        ),
        
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
      )
    )
    ;
  }
}
