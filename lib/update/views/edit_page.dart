import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_app/Common/views/navigation_bar.dart';
import 'package:form_app/home/cubit/home_cubit.dart';
import 'package:form_app/update/cubit/update_cubit.dart';
import 'package:google_fonts/google_fonts.dart';

class EditThread extends StatefulWidget {
  final String content;
  final int id;
  const EditThread({super.key, required this.content, required this.id});

  @override
  State<EditThread> createState() => _EditThreadState();
}

class _EditThreadState extends State<EditThread> {
  final _contentcontroller = TextEditingController();

  @override
  void initState() {
    _contentcontroller.text = widget.content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black,
          toolbarHeight: 50,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => NavigationTabs(),
              ));
            },
            icon: Image.asset('assets/close.png'),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocConsumer<UpdateCubit, UpdateState>(
                listener: (context, state) {
                  if (state is UpdateError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Something went wrong"),
                    ));
                  }

                  if (state is UpdateSuccess) {
                    context.read<HomeCubit>().getHomeData();
                    _contentcontroller.clear();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Thread Updated successfully"),
                    ));
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => NavigationTabs(),
                    ));
                  }
                },
                builder: (context, state) {
                  if (state is UpdateLoading) {
                    return CircularProgressIndicator();
                  } else {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      onPressed: () {
                        final content = _contentcontroller.text;
                        context
                            .read<UpdateCubit>()
                            .updateThread(content, widget.id);
                      },
                      child: Row(children: [
                        Text(
                          'Save',
                          style: GoogleFonts.robotoSlab(
                            color: Colors.white,
                          ),
                        ),
                      ]),
                    );
                  }
                },
              ),
            )
          ]),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          TextField(
              controller: _contentcontroller,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: GoogleFonts.robotoSerif(color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
              ))
        ]),
      )),
    );
  }
}
