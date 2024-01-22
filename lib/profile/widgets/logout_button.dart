import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_app/auth/cubit/auth_cubit.dart';
import 'package:form_app/auth/views/login_page.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          context.read<AuthCubit>().logout();
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Login(),
          ));
        },
        icon: Icon(Icons.logout));
  }
}