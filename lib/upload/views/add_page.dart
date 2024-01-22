import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_app/Common/views/navigation_bar.dart';
import 'package:form_app/home/cubit/home_cubit.dart';
import 'package:form_app/upload/cubit/upload_cubit.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadPage extends StatelessWidget {
  UploadPage({super.key});

  final contentcontroller = TextEditingController();
  final imagecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                child: BlocConsumer<UploadCubit, UploadState>(
                  listener: (context, state) {
                   if(state is UploadError)
                   {
                     ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(
                         content: Text(state.message),
                       )
                     );

                     if (state is UploadSuccess) {
                      context.read<HomeCubit>().getHomeData();
                      contentcontroller.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Thread created successfully"),
                        )
                      );
                       Navigator.of(context).pushReplacement(MaterialPageRoute(
                         builder: (context) => NavigationTabs(),
                       ));
                     }
                   }
                  },
                  builder: (context, state) {
                    if (state is UploadLoading) {
                      return CircularProgressIndicator();}
                     return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      onPressed: () {
                        final content = contentcontroller.text;
                        context.read<UploadCubit>().createThread(content);


                      },
                      child: Row(children: [
                        Image.asset(
                          'assets/add_square.png',
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Add',
                          style: GoogleFonts.robotoSlab(
                            color: Colors.white,
                          ),
                        ),
                      ]),
                    ); 
                    }
                    
                  
                ),
              )
            ]),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              TextField(
                  controller: contentcontroller,
                  style: GoogleFonts.robotoSerif(color: Colors.white),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Your content here....",
                      hintStyle: GoogleFonts.robotoSerif(
                        color: Color.fromARGB(255, 192, 186, 186),
                      ))),
              TextField(
                  controller: imagecontroller,
                  style: GoogleFonts.robotoSerif(color: Colors.white),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Image URL",
                      hintStyle: GoogleFonts.robotoSerif(
                        color: Color.fromARGB(255, 192, 186, 186),
                      )))
            ])),
      ),
    );
  }
}
