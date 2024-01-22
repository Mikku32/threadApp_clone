import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_app/Common/views/navigation_bar.dart';
import 'package:form_app/auth/cubit/auth_cubit.dart';
import 'package:form_app/home/views/home_page.dart';
import 'package:form_app/auth/views/login_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {

        if (state is AuthInitial){
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => Login(),
            )
          );
        }


        if (state is AuthSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => NavigationTabs(),
            )
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Image.asset(
                'assets/Threads Logo.png',
                height: 500,
                width: 500,
              ),
            ));
      },
    );
  }
}
